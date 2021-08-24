// To parse this JSON data, do
//
//     final modelRiwayatPekerjaan = modelRiwayatPekerjaanFromJson(jsonString);

import 'dart:convert';

ModelRiwayatPekerjaan modelRiwayatPekerjaanFromJson(String str) => ModelRiwayatPekerjaan.fromJson(json.decode(str));

String modelRiwayatPekerjaanToJson(ModelRiwayatPekerjaan data) => json.encode(data.toJson());

class ModelRiwayatPekerjaan {
  ModelRiwayatPekerjaan({
    this.status,
    this.message,
    this.dwRiwayatPekerjaan,
  });

  int status;
  String message;
  List<DwRiwayatPekerjaan> dwRiwayatPekerjaan;

  factory ModelRiwayatPekerjaan.fromJson(Map<String, dynamic> json) => ModelRiwayatPekerjaan(
    status: json["status"],
    message: json["message"],
    dwRiwayatPekerjaan: List<DwRiwayatPekerjaan>.from(json["dw_riwayat_pekerjaan"].map((x) => DwRiwayatPekerjaan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "dw_riwayat_pekerjaan": List<dynamic>.from(dwRiwayatPekerjaan.map((x) => x.toJson())),
  };
}

class DwRiwayatPekerjaan {
  DwRiwayatPekerjaan({
    this.jobOrder,
    this.id,
    this.idEmployee,
    this.client,
    this.cleintLocation,
    this.idLowongan,
  });

  String jobOrder;
  String id;
  String idEmployee;
  String client;
  String cleintLocation;
  String idLowongan;

  factory DwRiwayatPekerjaan.fromJson(Map<String, dynamic> json) => DwRiwayatPekerjaan(
    jobOrder: json["job_order"],
    id: json["id"],
    idEmployee: json["id_employee"],
    client: json["client"],
    cleintLocation: json["cleint_location"],
    idLowongan: json["id_lowongan"],
  );

  Map<String, dynamic> toJson() => {
    "job_order": jobOrder,
    "id": id,
    "id_employee": idEmployee,
    "client": client,
    "cleint_location": cleintLocation,
    "id_lowongan": idLowongan,
  };
}
