import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/services/api_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiService _apiService;

  HomeCubit(this._apiService) : super(HomeInitial());

  Future<void> getCharacters() async {
    emit(HomeLoading());
    try {
      final characters = await _apiService.getCharacters();
      emit(HomeLoaded(characters));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
