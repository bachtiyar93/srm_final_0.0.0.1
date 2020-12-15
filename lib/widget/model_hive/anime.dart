import 'package:hive/hive.dart';
part 'anime.g.dart';

@HiveType(typeId: 0)
class Produk extends HiveObject{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String produk;
  @HiveField(2)
  final String seri;
  @HiveField(3)
  final double harga;
  @HiveField(4)
  final double stok;
  @HiveField(5)
  final DateTime tglMasuk;
  @HiveField(6)
  final int kondisi;
  @HiveField(7)
  final int bidang;
  @HiveField(8)
  final int rate;
  @HiveField(9)
  final int pembeli;
  @HiveField(10)
  final int dilihat;
  @HiveField(11)
  final int whistlist;
  @HiveField(12)
  final List<String> images;

  Produk({
    this.id,
    this.produk,
    this.seri,
    this.harga,
    this.stok,
    this.tglMasuk,
    this.kondisi,
    this.bidang,
    this.rate,
    this.pembeli,
    this.dilihat,
    this.whistlist,
    this.images,
  });
}
