import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/character_model.dart';
import '../../../data/models/local_character.dart';
import '../../../data/services/local_storage_service.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final LocalStorageService _localStorageService;

  FavoritesCubit(this._localStorageService) : super(FavoritesLoading());

  Future<void> loadFavorites() async {
    emit(FavoritesLoading());
    try {
      final favorites = await _localStorageService.getFavorites();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError("Error al cargar favoritos: $e"));
    }
  }

  Future<void> addFavorite(CharacterModel apiChar, String customName) async {
    try {
      final newFavorite = LocalCharacter(
        apiId: apiChar.id,
        originalName: apiChar.name,
        customName: customName,
        image: apiChar.image,
      );

      await _localStorageService.saveCharacter(newFavorite);
      
      loadFavorites(); 
    } catch (e) {
      emit(FavoritesError("No se pudo guardar: $e"));
    }
  }

  Future<void> deleteFavorite(int apiId) async {
    try {
      await _localStorageService.deleteCharacter(apiId);
      loadFavorites();
    } catch (e) {
      emit(FavoritesError("Error al eliminar"));
    }
  }
}