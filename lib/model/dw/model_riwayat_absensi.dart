// To parse this JSON data, do
//
//     final modelRiwayatAbsensi = modelRiwayatAbsensiFromJson(jsonString);

import 'dart:convert';

ModelRiwayatAbsensi modelRiwayatAbsensiFromJson(String str) => ModelRiwayatAbsensi.fromJson(json.decode(str));

String modelRiwayatAbsensiToJson(ModelRiwayatAbsensi data) => json.encode(data.toJson());

class ModelRiwayatAbsensi {
  ModelRiwayatAbsensi({
    this.status,
    this.message,
    this.dwRiwayatAbsen,
  });

  int status;
  String message;
  List<DwRiwayatAbsen> dwRiwayatAbsen;

  factory ModelRiwayatAbsensi.fromJson(Map<String, dynamic> json) => ModelRiwayatAbsensi(
    status: json["status"],
    message: json["message"],
    dwRiwayatAbsen: List<DwRiwayatAbsen>.from(json["dw_riwayat_absen"].map((x) => DwRiwayatAbsen.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "dw_riwayat_absen": List<dynamic>.from(dwRiwayatAbsen.map((x) => x.toJson())),
  };
}

class DwRiwayatAbsen {
  DwRiwayatAbsen({
    this.id,
    this.tanggalMasuk,
    this.tanggalKeluar,
  });

  String id;
  String tanggalMasuk;
  String tanggalKeluar;

  factory DwRiwayatAbsen.fromJson(Map<String, dynamic> json) => DwRiwayatAbsen(
    id: json["id"],
    tanggalMasuk: json["tanggal_masuk"],
    tanggalKeluar: json["tanggal_keluar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tanggal_masuk": tanggalMasuk,
    "tanggal_keluar": tanggalKeluar,
  };
}
