// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartAdapter extends TypeAdapter<Cart> {
  @override
  final int typeId = 2;

  @override
  Cart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cart(
      id: fields[0] as int,
      kain: fields[1] as String,
      seri: fields[2] as String,
      harga: fields[3] as double,
      stok: fields[4] as double,
      tglMasuk: fields[5] as DateTime,
      kondisi: fields[6] as int,
      bidang: fields[7] as int,
      rate: fields[8] as int,
      pembeli: fields[9] as int,
      dilihat: fields[10] as int,
      whistlist: fields[11] as int,
      images: (fields[12] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Cart obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.kain)
      ..writeByte(2)
      ..write(obj.seri)
      ..writeByte(3)
      ..write(obj.harga)
      ..writeByte(4)
      ..write(obj.stok)
      ..writeByte(5)
      ..write(obj.tglMasuk)
      ..writeByte(6)
      ..write(obj.kondisi)
      ..writeByte(7)
      ..write(obj.bidang)
      ..writeByte(8)
      ..write(obj.rate)
      ..writeByte(9)
      ..write(obj.pembeli)
      ..writeByte(10)
      ..write(obj.dilihat)
      ..writeByte(11)
      ..write(obj.whistlist)
      ..writeByte(12)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
