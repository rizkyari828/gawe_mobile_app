// To parse this JSON data, do
//
//     final modelPsikotes = modelPsikotesFromJson(jsonString);

import 'dart:convert';

ModelPsikotes modelPsikotesFromJson(String str) => ModelPsikotes.fromJson(json.decode(str));

String modelPsikotesToJson(ModelPsikotes data) => json.encode(data.toJson());

class ModelPsikotes {
  String status;
  String message;
  List<Undangan> undangan;

  ModelPsikotes({
    this.status,
    this.message,
    this.undangan,
  });

  factory ModelPsikotes.fromJson(Map<String, dynamic> json) => ModelPsikotes(
    status: json["status"],
    message: json["message"],
    undangan: List<Undangan>.from(json["undangan"].map((x) => Undangan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "undangan": List<dynamic>.from(undangan.map((x) => x.toJson())),
  };
}

class Undangan {
  String id;
  String lowonganId;
  String employeeId;
  String kehadiran;
  DateTime tanggalPsikotes;
  String keterangan;
  dynamic hasil;
  String status;
  dynamic tanggalReshedule;
  String rangeReshedule;
  dynamic statusResheduleJg;
  dynamic statusResheduleJs;
  String namaPerusahaan;
  String posisi;
  String logo;
  String perusahaanId;
  String cityId;
  String provinceId;

  Undangan({
    this.id,
    this.lowonganId,
    this.employeeId,
    this.kehadiran,
    this.tanggalPsikotes,
    this.keterangan,
    this.hasil,
    this.status,
    this.tanggalReshedule,
    this.rangeReshedule,
    this.statusResheduleJg,
    this.statusResheduleJs,
    this.namaPerusahaan,
    this.posisi,
    this.logo,
    this.perusahaanId,
    this.cityId,
    this.provinceId,
  });

  factory Undangan.fromJson(Map<String, dynamic> json) => Undangan(
    id: json["id"],
    lowonganId: json["lowongan_id"],
    employeeId: json["employee_id"],
    kehadiran: json["kehadiran"] == null ? null : json["kehadiran"],
    tanggalPsikotes: DateTime.parse(json["tanggal_psikotes"]),
    keterangan: json["keterangan"],
    hasil: json["hasil"],
    status: json["status"],
    tanggalReshedule: json["tanggal_reshedule"],
    rangeReshedule: json["range_reshedule"],
    statusResheduleJg: json["status_reshedule_jg"],
    statusResheduleJs: json["status_reshedule_js"],
    namaPerusahaan: json["nama_perusahaan"],
    posisi: json["posisi"],
    logo: json["logo"],
    perusahaanId: json["perusahaan_id"],
    cityId: json["city_id"],
    provinceId: json["province_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lowongan_id": lowonganId,
    "employee_id": employeeId,
    "kehadiran": kehadiran == null ? null : kehadiran,
    "tanggal_psikotes": "${tanggalPsikotes.year.toString().padLeft(4, '0')}-${tanggalPsikotes.month.toString().padLeft(2, '0')}-${tanggalPsikotes.day.toString().padLeft(2, '0')}",
    "keterangan": keterangan,
    "hasil": hasil,
    "status": status,
    "tanggal_reshedule": tanggalReshedule,
    "range_reshedule": rangeReshedule,
    "status_reshedule_jg": statusResheduleJg,
    "status_reshedule_js": statusResheduleJs,
    "nama_perusahaan": namaPerusahaan,
    "posisi": posisi,
    "logo": logo,
    "perusahaan_id": perusahaanId,
    "city_id": cityId,
    "province_id": provinceId,
  };
}
