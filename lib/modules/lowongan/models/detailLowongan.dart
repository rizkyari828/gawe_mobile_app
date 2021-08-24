// To parse this JSON data, do
//
//     final detailLowonganModel = detailLowonganModelFromJson(jsonString);

import 'dart:convert';

DetailLowonganModel detailLowonganModelFromJson(String str) => DetailLowonganModel.fromJson(json.decode(str));

String detailLowonganModelToJson(DetailLowonganModel data) => json.encode(data.toJson());

class DetailLowonganModel {
  DetailLowonganModel({
    this.status,
    this.message,
    this.lowongan,
  });

  String status;
  String message;
  Lowongan lowongan;

  factory DetailLowonganModel.fromJson(Map<String, dynamic> json) => DetailLowonganModel(
    status: json["status"],
    message: json["message"],
    lowongan: Lowongan.fromJson(json["lowongan"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "lowongan": lowongan.toJson(),
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
    this.jenisPekerjaan,
    this.rincian,
    this.kualifikasi,
    this.kouta,
    this.alamat,
    this.deskripsi,
    this.idPerusahaan,
    this.directLink,
    this.distance,
    this.duration,
    this.pelamarText,
  });

  String idLowongan;
  String namaPerusahaan;
  String jenjangCareerId;
  String pendidikan;
  String pengalamanId;
  String endPost;
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
  String directLink;
  String distance;
  String duration;
  String pelamarText;

  factory Lowongan.fromJson(Map<String, dynamic> json) => Lowongan(
    idLowongan: json["id_lowongan"],
    namaPerusahaan: json["nama_perusahaan"],
    jenjangCareerId: json["jenjang_career_id"],
    pendidikan: json["pendidikan"],
    pengalamanId: json["pengalaman_id"],
    endPost: json["end_post"],
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
    directLink: json["direct_link"],
    distance: json["distance"],
    duration: json["duration"],
    pelamarText: json["pelamar_text"],
  );

  Map<String, dynamic> toJson() => {
    "id_lowongan": idLowongan,
    "nama_perusahaan": namaPerusahaan,
    "jenjang_career_id": jenjangCareerId,
    "pendidikan": pendidikan,
    "pengalaman_id": pengalamanId,
    "end_post": endPost,
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
    "direct_link": directLink,
    "distance": distance,
    "duration": duration,
    "pelamar_text": pelamarText,
  };
}
