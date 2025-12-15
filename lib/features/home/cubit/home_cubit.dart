import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/services/api_service.dart';
import '../../../data/services/local_storage_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiService _apiService;
  final LocalStorageService _localStorageService;

  HomeCubit(this._apiService, this._localStorageService) : super(HomeInitial());

  Future<void> getCharacters() async {
    emit(HomeLoading());
    try {
      final response = await _apiService.getCharacters(page: 1);
      final favoriteIds = await _localStorageService.getFavoriteIds();
      emit(
        HomeLoaded(
          characters: response.characters,
          currentPage: response.currentPage,
          hasReachedMax: !response.hasNextPage,
          favoriteIds: favoriteIds,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> refreshFavorites() async {
    final currentState = state;
    if (currentState is HomeLoaded) {
      final favoriteIds = await _localStorageService.getFavoriteIds();
      emit(currentState.copyWith(favoriteIds: favoriteIds));
    }
  }

  void search(String query) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(currentState.copyWith(searchQuery: query));
    }
  }

  void clearSearch() {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(currentState.copyWith(searchQuery: ''));
    }
  }

  Future<void> loadMore() async {
    final currentState = state;

    if (currentState is! HomeLoaded) return;
    if (currentState.hasReachedMax) return;
    if (currentState.isLoadingMore) return;

    emit(currentState.copyWith(isLoadingMore: true));

    try {
      final nextPage = currentState.currentPage + 1;
      final response = await _apiService.getCharacters(page: nextPage);

      emit(
        currentState.copyWith(
          characters: [...currentState.characters, ...response.characters],
          currentPage: nextPage,
          hasReachedMax: !response.hasNextPage,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      emit(currentState.copyWith(isLoadingMore: false));
    }
  }
}