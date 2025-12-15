import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_character.freezed.dart';
part 'api_character.g.dart';

@freezed
class ApiCharacter with _$ApiCharacter {
  const factory ApiCharacter({
    required int id,
    required String name,
    @JsonKey(name: 'normalized_name') required String normalizedName,
    required String? gender,
    @Default('https://via.placeholder.com/150') String image,
    @Default('Unknown') String occupation,
  }) = _ApiCharacter;

  factory ApiCharacter.fromJson(Map<String, dynamic> json) =>
      _$ApiCharacterFromJson(json);
}
