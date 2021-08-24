// To parse this JSON data, do
//
//     final modelLowongan = modelLowonganFromJson(jsonString);

import 'dart:convert';

List<ModelLowongan> modelLowonganFromJson(String str) => List<ModelLowongan>.from(json.decode(str).map((x) => ModelLowongan.fromJson(x)));

String modelLowonganToJson(List<ModelLowongan> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelLowongan {
  ModelLowongan({
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
    this.jenisPekerjaan,
    this.rincian,
    this.kualifikasi,
    this.kouta,
    this.alamat,
    this.deskripsi,
    this.idPerusahaan,
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
  String jenisPekerjaan;
  String rincian;
  String kualifikasi;
  String kouta;
  String alamat;
  String deskripsi;
  String idPerusahaan;

  factory ModelLowongan.fromJson(Map<String, dynamic> json) => ModelLowongan(
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
    jenisPekerjaan: json["jenis_pekerjaan"],
    rincian: json["rincian"],
    kualifikasi: json["kualifikasi"],
    kouta: json["kouta"],
    alamat: json["alamat"],
    deskripsi: json["deskripsi"],
    idPerusahaan: json["id_perusahaan"],
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
    "jenis_pekerjaan": jenisPekerjaan,
    "rincian": rincian,
    "kualifikasi": kualifikasi,
    "kouta": kouta,
    "alamat": alamat,
    "deskripsi": deskripsi,
    "id_perusahaan": idPerusahaan,
  };
}
