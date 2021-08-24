// To parse this JSON data, do
//
//     final modelLowongan2 = modelLowongan2FromJson(jsonString);

import 'dart:convert';

ModelLowongan2 modelLowongan2FromJson(String str) => ModelLowongan2.fromJson(json.decode(str));

String modelLowongan2ToJson(ModelLowongan2 data) => json.encode(data.toJson());

class ModelLowongan2 {
  ModelLowongan2({
    this.status,
    this.message,
    this.lowongan,
  });

  String status;
  String message;
  List<Lowongan> lowongan;

  factory ModelLowongan2.fromJson(Map<String, dynamic> json) => ModelLowongan2(
    status: json["status"],
    message: json["message"],
    lowongan: List<Lowongan>.from(json["lowongan"].map((x) => Lowongan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "lowongan": List<dynamic>.from(lowongan.map((x) => x.toJson())),
  };
}

class Lowongan {
  Lowongan({
    this.idLowongan,
    this.namaPerusahaan,
    this.jenjangCareerId,
    this.pendidikan,
    this.pengalamanId,
    this.endPost,
    this.provinceId,
    this.cityId,
    this.logo,
    this.gajiMin,
    this.gajiMax,
    this.posisi,
    this.totalPelamar,
    this.datePostStart,
    this.datePostEnd,
    this.jenispekerjaan,
    this.rincian,
    this.kualifikasi,
    this.kouta,
    this.alamat,
    this.deskripsi,
    this.id_perusahaan,
    this.directLink,
    this.distance,
    this.duration,
    this.pelamarTeks,
  });

  String idLowongan;
  String namaPerusahaan;
  String jenjangCareerId;
  String pendidikan;
  String pengalamanId;
  DateTime endPost;
  String provinceId;
  String cityId;
  String logo;
  String gajiMin;
  String gajiMax;
  String posisi;
  int totalPelamar;
  String datePostStart;
  String datePostEnd;
  String jenispekerjaan;
  String rincian;
  String kualifikasi;
  String kouta;
  String alamat;
  String deskripsi;
  String id_perusahaan;
  String directLink;
  String distance;
  String duration;
  String pelamarTeks;

  factory Lowongan.fromJson(Map<String, dynamic> json) => Lowongan(
    idLowongan: json["id_lowongan"],
    namaPerusahaan: json["nama_perusahaan"],
    jenjangCareerId: json["jenjang_career_id"],
    pendidikan: json["pendidikan"],
    pengalamanId: json["pengalaman_id"],
    endPost: DateTime.parse(json["end_post"]),
    provinceId: json["province_id"],
    cityId: json["city_id"],
    logo: json["logo"],
    gajiMin: json["gaji_min"],
    gajiMax: json["gaji_max"],
    posisi: json["posisi"],
    totalPelamar: json["total_pelamar"],
    datePostStart: json["date_post_start"],
    datePostEnd: json["date_post_end"],
    jenispekerjaan: json["jenis_pekerjaan"],
    rincian: json["rincian"],
    kualifikasi: json["kualifikasi"],
    kouta: json["kouta"],
    alamat: json["alamat"],
    deskripsi: json["deskripsi"],
    id_perusahaan: json["id_perusahaan"],
    directLink: json["direct_link"],
    distance: json["distance"],
    duration: json["duration"],
    pelamarTeks: json["pelamar_text"],
  );

  Map<String, dynamic> toJson() => {
    "id_lowongan": idLowongan,
    "nama_perusahaan": namaPerusahaan,
    "jenjang_career_id": jenjangCareerId,
    "pendidikan": pendidikan,
    "pengalaman_id": pengalamanId,
    "end_post": "${endPost.year.toString().padLeft(4, '0')}-${endPost.month.toString().padLeft(2, '0')}-${endPost.day.toString().padLeft(2, '0')}",
    "province_id": provinceId,
    "city_id": cityId,
    "logo": logo,
    "gaji_min": gajiMin,
    "gaji_max": gajiMax,
    "posisi": posisi,
    "total_pelamar": totalPelamar,
    "date_post_start": datePostStart,
    "date_post_end": datePostEnd,
    "jenis_pekerjaan": jenispekerjaan,
    "rincian": rincian,
    "kualifikasi": kualifikasi,
    "kouta": kouta,
    "alamat": alamat,
    "deskripsi": deskripsi,
    "id_perusahaan":id_perusahaan,
    "direct_link":directLink,
    "distance":distance,
    "duration":duration,
    "pelamar_text":pelamarTeks,
  };
}
