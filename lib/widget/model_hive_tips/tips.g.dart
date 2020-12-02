// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tips.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TipsAdapter extends TypeAdapter<Tips> {
  @override
  final int typeId = 1;

  @override
  Tips read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tips(
      id: fields[0] as int,
      judul: fields[1] as String,
      body: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Tips obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.judul)
      ..writeByte(2)
      ..write(obj.body);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TipsAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
