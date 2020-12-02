import 'package:hive/hive.dart';
part 'tips.g.dart';

@HiveType(typeId: 1)
class Tips extends HiveObject{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String judul;
  @HiveField(2)
  final String body;
  @HiveField(3)

  Tips({
    this.id,
    this.judul,
    this.body,
  });
}
