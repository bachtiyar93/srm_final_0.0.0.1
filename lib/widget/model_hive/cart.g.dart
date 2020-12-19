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
      produk: fields[1] as String,
      seri: fields[2] as String,
      harga: fields[3] as double,
      qty: fields[4] as double,
      tglTransaksi: fields[5] as DateTime,
      size: fields[6] as String,
      ket: fields[7] as String,
      status: fields[8] as int,
      images: (fields[9] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Cart obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.produk)
      ..writeByte(2)
      ..write(obj.seri)
      ..writeByte(3)
      ..write(obj.harga)
      ..writeByte(4)
      ..write(obj.qty)
      ..writeByte(5)
      ..write(obj.tglTransaksi)
      ..writeByte(6)
      ..write(obj.size)
      ..writeByte(7)
      ..write(obj.ket)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
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
