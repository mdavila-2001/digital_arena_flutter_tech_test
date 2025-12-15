// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_character.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalCharacterAdapter extends TypeAdapter<LocalCharacter> {
  @override
  final int typeId = 0;

  @override
  LocalCharacter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalCharacter(
      apiId: fields[0] as int,
      originalName: fields[1] as String,
      customName: fields[2] as String,
      image: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LocalCharacter obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.apiId)
      ..writeByte(1)
      ..write(obj.originalName)
      ..writeByte(2)
      ..write(obj.customName)
      ..writeByte(3)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalCharacterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
