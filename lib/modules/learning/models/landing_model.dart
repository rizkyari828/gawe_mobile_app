// To parse this JSON data, do
//
//     final modelLanding = modelLandingFromJson(jsonString);

import 'dart:convert';

ModelLanding modelLandingFromJson(String str) => ModelLanding.fromJson(json.decode(str));

String modelLandingToJson(ModelLanding data) => json.encode(data.toJson());

class ModelLanding {
  ModelLanding({
    this.status,
    this.message,
    this.learning,
    this.level,
  });

  int status;
  String message;
  List<Learning> learning;
  List<Level> level;

  factory ModelLanding.fromJson(Map<String, dynamic> json) => ModelLanding(
    status: json["status"],
    message: json["message"],
    learning: List<Learning>.from(json["learning"].map((x) => Learning.fromJson(x))),
    level: List<Level>.from(json["level"].map((x) => Level.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "learning": List<dynamic>.from(learning.map((x) => x.toJson())),
    "level": List<dynamic>.from(level.map((x) => x.toJson())),
  };
}

class Learning {
  Learning({
    this.id,
    this.kategori,
    this.namaPerusahaan,
    this.image,
    this.description,
    this.codeGenerate,
    this.userIdP,
    this.statusBerbayar,
    this.statusSertifikasi,
    this.statusSelesai,
    this.statusActivasi,
    this.statusLevel,
    this.kodeReferral,
    this.accessCount,
    this.aktif,
  });

  String id;
  String kategori;
  String namaPerusahaan;
  String image;
  String description;
  String codeGenerate;
  String userIdP;
  String statusBerbayar;
  String statusSertifikasi;
  String statusSelesai;
  String statusActivasi;
  String statusLevel;
  String kodeReferral;
  String accessCount;
  String aktif;

  factory Learning.fromJson(Map<String, dynamic> json) => Learning(
    id: json["id"],
    kategori: json["kategori"],
    namaPerusahaan: json["nama_perusahaan"],
    image: json["image"],
    description: json["description"],
    codeGenerate: json["code_generate"],
    userIdP: json["user_id_p"],
    statusBerbayar: json["status_berbayar"],
    statusSertifikasi: json["status_sertifikasi"],
    statusSelesai: json["status_selesai"],
    statusActivasi: json["status_aktivasi"],
    statusLevel: json["status_level"],
    kodeReferral: json["kode_referral"],
    accessCount: json["access_count"],
    aktif: json["aktif"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "kategori": kategori,
    "nama_perusahaan": namaPerusahaan,
    "image": image,
    "description": description,
    "code_generate": codeGenerate,
    "user_id_p": userIdP,
    "status_berbayar": statusBerbayar,
    "status_sertifikasi": statusSertifikasi,
    "status_selesai": statusSelesai,
    "status_aktivasi": statusActivasi,
    "status_level": statusLevel,
    "kode_referral": kodeReferral,
    "access_count":accessCount,
    "aktif":aktif
  };
}

class Level {
  Level({
    this.id,
    this.level,
    this.description,
    this.date,
  });

  String id;
  String level;
  String description;
  String date;

  factory Level.fromJson(Map<String, dynamic> json) => Level(
    id: json["id"],
    level: json["level"],
    description: json["description"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "level": level,
    "description": description,
    "date": date,
  };
}
