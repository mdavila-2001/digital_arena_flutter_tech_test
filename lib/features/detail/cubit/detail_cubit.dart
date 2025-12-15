import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/services/api_service.dart';
import 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  final ApiService _apiService;

  DetailCubit(this._apiService) : super(DetailLoading());

  Future<void> loadDetail(int id) async {
    emit(DetailLoading());
    try {
      final detail = await _apiService.getCharacterDetail(id);
      emit(DetailLoaded(detail));
    } catch (e) {
      emit(DetailError("Error obteniendo detalle: $e"));
    }
  }
}