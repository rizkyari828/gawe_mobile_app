// To parse this JSON data, do
//
//     final modelPengalamankerja = modelPengalamankerjaFromJson(jsonString);

import 'dart:convert';

ModelPengalamankerja modelPengalamankerjaFromJson(String str) => ModelPengalamankerja.fromJson(json.decode(str));

String modelPengalamankerjaToJson(ModelPengalamankerja data) => json.encode(data.toJson());

class ModelPengalamankerja {
  ModelPengalamankerja({
    this.status,
    this.message,
    this.pengalaman,
  });

  int status;
  String message;
  List<Pengalaman> pengalaman;

  factory ModelPengalamankerja.fromJson(Map<String, dynamic> json) => ModelPengalamankerja(
    status: json["status"],
    message: json["message"],
    pengalaman: List<Pengalaman>.from(json["pengalaman"].map((x) => Pengalaman.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "pengalaman": List<dynamic>.from(pengalaman.map((x) => x.toJson())),
  };
}

class Pengalaman {
  Pengalaman({
    this.id,
    this.posisi,
    this.namaPerusahaan,
    this.industri,
    this.lokasi,
    this.gaji,
    this.tglMulai,
    this.tglBerhenti,
    this.masihBekerja,
    this.deskripsiPekerjaan,
    this.fungsiKerjaId,
    this.jenjang_career_id
  });

  String id;
  String posisi;
  String namaPerusahaan;
  String industri;
  String lokasi;
  String gaji;
  String tglMulai;
  String tglBerhenti;
  String masihBekerja;
  String deskripsiPekerjaan;
  String fungsiKerjaId;
  String jenjang_career_id;

  factory Pengalaman.fromJson(Map<String, dynamic> json) => Pengalaman(
    id: json["id"],
    posisi: json["posisi"],
    namaPerusahaan: json["nama_perusahaan"],
    industri: json["industri"],
    lokasi: json["lokasi"],
    gaji: json["gaji"],
    tglMulai: json["tgl_mulai"],
    tglBerhenti: json["tgl_berhenti"],
    masihBekerja: json["masih_bekerja"],
    deskripsiPekerjaan: json["deskripsi_pekerjaan"],
    fungsiKerjaId: json["fungsi_kerja_id"],
      jenjang_career_id: json["jenjang_career_id"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "posisi": posisi,
    "nama_perusahaan": namaPerusahaan,
    "industri": industri,
    "lokasi": lokasi,
    "gaji": gaji,
    "tgl_mulai": tglMulai,
    "tgl_berhenti":tglBerhenti,
    "masih_bekerja": masihBekerja,
    "deskripsi_pekerjaan": deskripsiPekerjaan,
    "fungsi_kerja_id": fungsiKerjaId,
    "jenjang_career_id":jenjang_career_id,
  };
}
