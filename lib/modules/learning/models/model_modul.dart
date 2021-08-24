// To parse this JSON data, do
//
//     final modelModul = modelModulFromJson(jsonString);

import 'dart:convert';

ModelModul modelModulFromJson(String str) => ModelModul.fromJson(json.decode(str));

String modelModulToJson(ModelModul data) => json.encode(data.toJson());

class ModelModul {
  ModelModul({
    this.status,
    this.message,
    this.modul,
  });

  int status;
  String message;
  List<Modul> modul;

  factory ModelModul.fromJson(Map<String, dynamic> json) => ModelModul(
    status: json["status"],
    message: json["message"],
    modul: List<Modul>.from(json["modul"].map((x) => Modul.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "modul": List<dynamic>.from(modul.map((x) => x.toJson())),
  };
}

class Modul {
  Modul({
    this.namaModul,
    this.foto,
    this.desc,
    this.idModul,
    this.kodeMateri,
    this.materiContent,
  });

  String namaModul;
  String foto;
  String desc;
  String idModul;
  String kodeMateri;
  List<MateriContent> materiContent;

  factory Modul.fromJson(Map<String, dynamic> json) => Modul(
    namaModul: json["nama_modul"],
    foto: json["foto"],
    desc: json["desc"],
    idModul: json["id_modul"],
    kodeMateri: json["kode_materi"],
    materiContent: List<MateriContent>.from(json["materi_content"].map((x) => MateriContent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "nama_modul": namaModul,
    "foto": foto,
    "desc": desc,
    "id_modul": idModul,
    "kode_materi": kodeMateri,
    "materi_content": List<dynamic>.from(materiContent.map((x) => x.toJson())),
  };
}

class MateriContent {
  MateriContent({
    this.id,
    this.namaMateri,
    this.latihan,
    this.preTest,
    this.postTest,
    this.penulis,
    this.kkm,
    this.urutan,
    this.statusRemidial,
    this.statusSelection,
    this.contentMateri,
    this.contentVideo,
    this.statusContent,
    this.contentPenulis,
    this.contentPic,
    this.statusSelesai,
    this.statusPretest,
    this.statusPostest,
    this.statusMateri,
    this.scorePostest,
    this.hasilPostest,
    this.statusUserRemidial,
    this.accessCount,
    this.likeCount,
    this.commentCount,
  });

  String id;
  String namaMateri;
  String latihan;
  String preTest;
  String postTest;
  String penulis;
  String kkm;
  String urutan;
  String statusRemidial;
  String statusSelection;
  String contentMateri;
  String contentVideo;
  String statusContent;
  String contentPenulis;
  String contentPic;
  String statusSelesai;
  String statusPretest;
  String statusPostest;
  String statusMateri;
  int scorePostest;
  String hasilPostest;
  String statusUserRemidial;
  int accessCount;
  int likeCount;
  int commentCount;

  factory MateriContent.fromJson(Map<String, dynamic> json) => MateriContent(
    id: json["id"],
    namaMateri: json["nama_materi"],
    latihan: json["latihan"],
    preTest: json["pre_test"],
    postTest: json["post_test"],
    penulis: json["penulis"],
    kkm: json["kkm"],
    urutan: json["urutan"],
    statusRemidial: json["status_remidial"],
    statusSelection: json["status_selection"],
    contentMateri: json["content_materi"],
    contentVideo: json["content_video"],
    statusContent: json["status_content"],
    contentPenulis: json["content_penulis"],
    contentPic: json["content_pic"],
    statusSelesai: json["status_selesai"],
    statusPretest: json["status_pretest"],
    statusPostest: json["status_postest"],
    statusMateri: json["status_materi"],
    scorePostest: json["score_postest"],
    hasilPostest: json["hasil_postest"],
    statusUserRemidial : json["status_user_remidial"],
    accessCount : json["access_count"],
    likeCount : json["count_like"],
    commentCount : json["count_comment"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_materi": namaMateri,
    "latihan": latihan,
    "pre_test": preTest,
    "post_test": postTest,
    "penulis": penulis,
    "kkm": kkm,
    "urutan": urutan,
    "status_remidial": statusRemidial,
    "status_selection": statusSelection,
    "content_materi": contentMateri,
    "content_video": contentVideo,
    "status_content": statusContent,
    "content_penulis": contentPenulis,
    "content_pic": contentPic,
    "status_selesai": statusSelesai,
    "status_pretest": statusPretest,
    "status_postest": statusPostest,
    "status_materi": statusMateri,
    "score_postest": scorePostest,
    "hasil_postest": hasilPostest,
    "status_user_remidial": statusUserRemidial,
    "access_count": accessCount,
    "count_like": likeCount,
    "count_comment": commentCount,
  };
}
