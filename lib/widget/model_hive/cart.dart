import 'package:hive/hive.dart';
part 'cart.g.dart';

@HiveType(typeId: 2)
class Cart extends HiveObject{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String produk;
  @HiveField(2)
  final String seri;
  @HiveField(3)
  final double harga;
  @HiveField(4)
  final double qty;
  @HiveField(5)
  final DateTime tglTransaksi;
  @HiveField(6)
  final String size;
  @HiveField(7)
  final String ket;
  @HiveField(8)
  final int status;
  @HiveField(9)
  final List<String> images;

  Cart({
    this.id,
    this.produk,
    this.seri,
    this.harga,
    this.qty,
    this.tglTransaksi,
    this.size,
    this.ket,
    this.status,
    this.images,
  });
}
