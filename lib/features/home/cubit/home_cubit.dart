import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/services/api_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiService _apiService;

  HomeCubit(this._apiService) : super(HomeInitial());

  /// Carga inicial de personajes
  Future<void> getCharacters() async {
    emit(HomeLoading());
    try {
      final response = await _apiService.getCharacters(page: 1);
      emit(
        HomeLoaded(
          characters: response.characters,
          currentPage: response.currentPage,
          hasReachedMax: !response.hasNextPage,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  /// Carga más personajes (siguiente página)
  Future<void> loadMore() async {
    final currentState = state;

    // Solo cargar si estamos en estado HomeLoaded y no hemos llegado al máximo
    if (currentState is! HomeLoaded) return;
    if (currentState.hasReachedMax) return;
    if (currentState.isLoadingMore) return;

    // Indicar que estamos cargando más
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
