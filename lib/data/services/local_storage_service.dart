import 'package:hive_flutter/hive_flutter.dart';
import '../models/local_character.dart';

class LocalStorageService {
  static const String boxName = 'favoritesBox';

  Future<Box<LocalCharacter>> _getBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<LocalCharacter>(boxName);
    }
    return await Hive.openBox<LocalCharacter>(boxName);
  }

  Future<void> saveCharacter(LocalCharacter character) async {
    final box = await _getBox();
    await box.put(character.apiId, character);
  }

  Future<List<LocalCharacter>> getFavorites() async {
    final box = await _getBox();
    return box.values.toList();
  }

  Future<void> deleteCharacter(int apiId) async {
    final box = await _getBox();
    await box.delete(apiId);
  }

  Future<bool> isFavorite(int apiId) async {
    final box = await _getBox();
    return box.containsKey(apiId);
  }

  Future<Set<int>> getFavoriteIds() async {
    final box = await _getBox();
    return box.keys.cast<int>().toSet();
  }

  Future<void> updateCustomName(int apiId, String newCustomName) async {
    final box = await _getBox();
    final existing = box.get(apiId);
    if (existing != null) {
      final updated = LocalCharacter(
        apiId: existing.apiId,
        originalName: existing.originalName,
        customName: newCustomName,
        image: existing.image,
      );
      await box.put(apiId, updated);
    }
  }
}