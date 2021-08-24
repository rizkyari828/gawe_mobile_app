// To parse this JSON data, do
//
//     final modelPengalamanOrg = modelPengalamanOrgFromJson(jsonString);

import 'dart:convert';

ModelPengalamanOrg modelPengalamanOrgFromJson(String str) => ModelPengalamanOrg.fromJson(json.decode(str));

String modelPengalamanOrgToJson(ModelPengalamanOrg data) => json.encode(data.toJson());

class ModelPengalamanOrg {
  ModelPengalamanOrg({
    this.status,
    this.message,
    this.pengalamanOrg,
  });

  String status;
  String message;
  List<PengalamanOrg> pengalamanOrg;

  factory ModelPengalamanOrg.fromJson(Map<String, dynamic> json) => ModelPengalamanOrg(
    status: json["status"],
    message: json["message"],
    pengalamanOrg: List<PengalamanOrg>.from(json["pengalaman_org"].map((x) => PengalamanOrg.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "pengalaman_org": List<dynamic>.from(pengalamanOrg.map((x) => x.toJson())),
  };
}

class PengalamanOrg {
  PengalamanOrg({
    this.id,
    this.namaOrganisasi,
    this.jabatan,
    this.mulai,
    this.akhir,
  });

  String id;
  String namaOrganisasi;
  String jabatan;
  String mulai;
  String akhir;

  factory PengalamanOrg.fromJson(Map<String, dynamic> json) => PengalamanOrg(
    id: json["id"],
    namaOrganisasi: json["nama_organisasi"],
    jabatan: json["jabatan"],
    mulai: json["mulai"],
    akhir: json["akhir"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_organisasi": namaOrganisasi,
    "jabatan": jabatan,
    "mulai": mulai,
    "akhir": akhir,

  };
}
