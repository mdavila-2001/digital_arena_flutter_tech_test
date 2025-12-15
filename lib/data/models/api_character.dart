import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_character.freezed.dart';
part 'api_character.g.dart';

@freezed
class ApiCharacter with _$ApiCharacter {
  // Definimos solo lo que necesitamos para la UI
  const factory ApiCharacter({
    required int id,
    required String name,
    required String normalized_name, // Útil para búsquedas
    required String? gender,         // Puede ser null
    @Default('https://via.placeholder.com/150') String image, // Valor por defecto si no hay imagen
    @Default('Unknown') String occupation,
  }) = _ApiCharacter;

  // Método mágico para convertir JSON a Objeto
  factory ApiCharacter.fromJson(Map<String, dynamic> json) => _$ApiCharacterFromJson(json);
}