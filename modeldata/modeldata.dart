// To parse this JSON data, do
//
//     final db = dbFromJson(jsonString);

import 'dart:convert';

List<Db?>? dbFromJson(String str) => json.decode(str) == null
    ? []
    : List<Db?>.from(json.decode(str)!.map((x) => Db.fromJson(x)));

String dbToJson(List<Db?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class Db {
  Db({
    this.id,
    this.namaIkan,
    this.jenis,
    this.tempatHidup,
  });

  String? id;
  String? namaIkan;
  String? jenis;
  String? tempatHidup;

  factory Db.fromJson(Map<String, dynamic> json) => Db(
        id: json["id"],
        namaIkan: json["nama_ikan"],
        jenis: json["jenis"],
        tempatHidup: json["tempat_hidup"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_ikan": namaIkan,
        "jenis": jenis,
        "tempat_hidup": tempatHidup,
      };
}
