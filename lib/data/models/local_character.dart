import 'package:hive/hive.dart';

part 'local_character.g.dart';

@HiveType(typeId: 0)
class LocalCharacter extends HiveObject {
  @HiveField(0)
  final int apiId;

  @HiveField(1)
  final String originalName;

  @HiveField(2)
  final String customName;

  @HiveField(3)
  final String image;

  LocalCharacter({
    required this.apiId,
    required this.originalName,
    required this.customName,
    required this.image,
  });
}