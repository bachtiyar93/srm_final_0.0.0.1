import 'package:hive/hive.dart';
part 'profile.g.dart';

@HiveType(typeId: 0)
class Profile extends HiveObject{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String kain;
  @HiveField(2)
  final String seri;
  @HiveField(3)
  final int harga;
  @HiveField(4)
  final int stok;
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
  final List<String> images;

  Profile({
    this.id,
    this.kain,
    this.seri,
    this.harga,
    this.stok,
    this.tglMasuk,
    this.kondisi,
    this.bidang,
    this.rate,
    this.pembeli,
    this.dilihat,
    this.images,
  });
}
