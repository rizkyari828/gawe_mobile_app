// To parse this JSON data, do
//
//     final materiModul = materiModulFromJson(jsonString);

import 'dart:convert';

MateriModul materiModulFromJson(String str) => MateriModul.fromJson(json.decode(str));

String materiModulToJson(MateriModul data) => json.encode(data.toJson());

class MateriModul {
  MateriModul({
    this.status,
    this.message,
    this.materi,
  });

  int status;
  String message;
  List<Materi> materi;

  factory MateriModul.fromJson(Map<String, dynamic> json) => MateriModul(
    status: json["status"],
    message: json["message"],
    materi: List<Materi>.from(json["materi"].map((x) => Materi.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "materi": List<dynamic>.from(materi.map((x) => x.toJson())),
  };
}

class Materi {
  Materi({
    this.id,
    this.namaMateri,
    this.preTes,
    this.postTes,
    this.modulId,
    this.kkm,
    this.remedial,
    this.video,
    this.foto,
  });

  String id;
  String namaMateri;
  String preTes;
  String postTes;
  String modulId;
  String kkm;
  String remedial;
  String video;
  String foto;

  factory Materi.fromJson(Map<String, dynamic> json) => Materi(
    id: json["id"],
    namaMateri: json["nama_materi"],
    preTes: json["pre_tes"],
    postTes: json["post_tes"],
    modulId: json["modul_id"],
    kkm: json["kkm"],
    remedial: json["remedial"],
    video: json["video"],
    foto: json["foto"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_materi": namaMateri,
    "pre_tes": preTes,
    "post_tes": postTes,
    "modul_id": modulId,
    "kkm": kkm,
    "remedial": remedial,
    "video": video,
    "foto": foto,
  };
}
