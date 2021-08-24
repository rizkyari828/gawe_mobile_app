// To parse this JSON data, do
//
//     final modelInterview = modelInterviewFromJson(jsonString);

import 'dart:convert';

ModelInterview modelInterviewFromJson(String str) => ModelInterview.fromJson(json.decode(str));

String modelInterviewToJson(ModelInterview data) => json.encode(data.toJson());

class ModelInterview {
  String status;
  String message;
  List<Undangan> undangan;

  ModelInterview({
    this.status,
    this.message,
    this.undangan,
  });

  factory ModelInterview.fromJson(Map<String, dynamic> json) => ModelInterview(
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
  dynamic kdPerusahaanId;
  String tglInterview;
  String kehadiran;
  String hasil;
  dynamic tglKerja;
  String keteranganUndangan;
  String keterangan;
  dynamic catatanInterview;
  String statusKd;
  dynamic statusTes;
  dynamic status;
  dynamic rangeReshedule;
  dynamic jenisPekerjaan;
  dynamic jenisWawancara;
  dynamic tanggalReshedule;
  dynamic statusResheduleJs;
  dynamic statusResheduleJg;
  dynamic panggil;
  dynamic alamatKantor;
  dynamic bertemu;
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
    this.kdPerusahaanId,
    this.tglInterview,
    this.kehadiran,
    this.hasil,
    this.tglKerja,
    this.keteranganUndangan,
    this.keterangan,
    this.catatanInterview,
    this.statusKd,
    this.statusTes,
    this.status,
    this.rangeReshedule,
    this.jenisPekerjaan,
    this.jenisWawancara,
    this.tanggalReshedule,
    this.statusResheduleJs,
    this.statusResheduleJg,
    this.panggil,
    this.alamatKantor,
    this.bertemu,
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
    kdPerusahaanId: json["kd_perusahaan_id"],
    tglInterview: json["tgl_interview"],
    kehadiran: json["kehadiran"],
    hasil: json["hasil"],
    tglKerja: json["tgl_kerja"],
    keteranganUndangan: json["keterangan_undangan"],
    keterangan: json["keterangan"],
    catatanInterview: json["catatan_interview"],
    statusKd: json["status_kd"],
    statusTes: json["status_tes"],
    status: json["status"],
    rangeReshedule: json["range_reshedule"],
    jenisPekerjaan: json["jenis_pekerjaan"],
    jenisWawancara: json["jenis_wawancara"],
    tanggalReshedule: json["tanggal_reshedule"],
    statusResheduleJs: json["status_reshedule_js"],
    statusResheduleJg: json["status_reshedule_jg"],
    panggil: json["panggil"],
    alamatKantor: json["alamat_kantor"],
    bertemu: json["bertemu"],
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
    "kd_perusahaan_id": kdPerusahaanId,
    "tgl_interview": tglInterview,
    "kehadiran": kehadiran,
    "hasil": hasil,
    "tgl_kerja": tglKerja,
    "keterangan_undangan": keteranganUndangan,
    "keterangan": keterangan,
    "catatan_interview": catatanInterview,
    "status_kd": statusKd,
    "status_tes": statusTes,
    "status": status,
    "range_reshedule": rangeReshedule,
    "jenis_pekerjaan": jenisPekerjaan,
    "jenis_wawancara": jenisWawancara,
    "tanggal_reshedule": tanggalReshedule,
    "status_reshedule_js": statusResheduleJs,
    "status_reshedule_jg": statusResheduleJg,
    "panggil": panggil,
    "alamat_kantor": alamatKantor,
    "bertemu": bertemu,
    "nama_perusahaan": namaPerusahaan,
    "posisi": posisi,
    "logo": logo,
    "perusahaan_id": perusahaanId,
    "city_id": cityId,
    "province_id": provinceId,
  };
}
