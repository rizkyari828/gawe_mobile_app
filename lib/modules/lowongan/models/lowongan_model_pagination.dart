// To parse this JSON data, do
//
//     final lowonganPagination = lowonganPaginationFromJson(jsonString);

import 'dart:convert';

LowonganPagination lowonganPaginationFromJson(String str) => LowonganPagination.fromJson(json.decode(str));

String lowonganPaginationToJson(LowonganPagination data) => json.encode(data.toJson());

class LowonganPagination {
  LowonganPagination({
    this.data,
    this.info,
  });

  List<Datum> data;
  Info info;

  factory LowonganPagination.fromJson(Map<String, dynamic> json) => LowonganPagination(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    // info: Info.fromJson(json["info"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "info": info.toJson(),
  };
}

class Datum {
  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idLowongan: json["id_lowongan"],
    namaPerusahaan: json["nama_perusahaan"],
    jenjangCareerId: json["jenjang_career_id"],
    pendidikan: json["pendidikan"],
    pengalamanId: json["pengalaman_id"],
    endPost: DateTime.parse(json["end_post"]),
    provinceId: json["province_id"],
    cityId: json["city_id"] == null ? null : json["city_id"],
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
    "city_id": cityId == null ? null : cityId,
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

class Info {
  Info({
    this.page,
    this.number,
  });

  int page;
  int number;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    page: json["page"],
    number: json["number"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "number": number,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
