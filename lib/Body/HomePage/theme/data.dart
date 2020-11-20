
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:srm_final/apikey/sumberapi.dart';

//Bangun List Data
Future<List<Produk>>dataProduk() async {
  final response = await http.post(SumberApi.dataproduk);
    return compute(parseProduk, response.body);
}

//json dipecahkan
List<Produk> parseProduk(String responseBody) {
final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//data dikembalikan ke List
return parsed.map<Produk>((json) => Produk.fromJson(json)).toList();
}

class Produk {
  Produk({
    this.id,
    this.kain,
    this.seri,
    this.harga,
    this.stok,
    this.tglMasuk,
    this.kondisi,
    this.images,
  });

  int id;
  String kain;
  String seri;
  int harga;
  int stok;
  DateTime tglMasuk;
  int kondisi;
  List<String> images;

  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
    id: int.parse(json["id"]),
    kain: json["kain"],
    seri: json["seri"],
    harga: int.parse(json["harga"]),
    stok: int.parse(json["stok"]),
    tglMasuk: DateTime.parse(json["tgl_masuk"]),
    kondisi: int.parse(json["kondisi"]),
    images: List<String>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "kain": kain,
    "seri": seri,
    "harga": harga,
    "stok": stok,
    "tgl_masuk": "${tglMasuk.year.toString().padLeft(4, '0')}-${tglMasuk.month.toString().padLeft(2, '0')}-${tglMasuk.day.toString().padLeft(2, '0')}",
    "kondisi": kondisi,
    "images": List<dynamic>.from(images.map((x) => x)),
  };
}

class Filter {

  String name;

  Filter(this.name);

}

List<Filter> getFilterList(){
  return <Filter>[
    Filter("Best Match"),
    Filter("Highest Price"),
    Filter("Lowest Price"),
  ];
}
