// To parse this JSON data, do
//
//     final modelLowonganDetail = modelLowonganDetailFromJson(jsonString);

import 'dart:convert';

ModelLowonganDetail modelLowonganDetailFromJson(String str) => ModelLowonganDetail.fromJson(json.decode(str));

String modelLowonganDetailToJson(ModelLowonganDetail data) => json.encode(data.toJson());

class ModelLowonganDetail {
  String status;
  String message;
  List<Lowongan> lowongan;
  List<Perusahaan> perusahaan;

  ModelLowonganDetail({
    this.status,
    this.message,
    this.lowongan,
    this.perusahaan,
  });

  factory ModelLowonganDetail.fromJson(Map<String, dynamic> json) => ModelLowonganDetail(
    status: json["status"],
    message: json["message"],
    lowongan: List<Lowongan>.from(json["lowongan"].map((x) => Lowongan.fromJson(x))),
    perusahaan: List<Perusahaan>.from(json["perusahaan"].map((x) => Perusahaan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "lowongan": List<dynamic>.from(lowongan.map((x) => x.toJson())),
    "perusahaan": List<dynamic>.from(perusahaan.map((x) => x.toJson())),
  };
}

class Lowongan {
  String idLowongan;
  String idPerusahaan;
  String namaPerusahaan;
  String pendidikan;
  String kouta;
  DateTime endPost;
  String provinceId;
  String cityId;
  String logo;
  String gajiMin;
  String gajiMax;
  String posisi;
  String kualifikasi;
  String jenjangCareerId;
  int totalPelamar;
  String pengalamanId;
  String fungsiKerjaId;
  String rincian;

  Lowongan({
    this.idLowongan,
    this.idPerusahaan,
    this.namaPerusahaan,
    this.pendidikan,
    this.kouta,
    this.endPost,
    this.provinceId,
    this.cityId,
    this.logo,
    this.gajiMin,
    this.gajiMax,
    this.posisi,
    this.kualifikasi,
    this.jenjangCareerId,
    this.totalPelamar,
    this.pengalamanId,
    this.fungsiKerjaId,
    this.rincian,
  });

  factory Lowongan.fromJson(Map<String, dynamic> json) => Lowongan(
    idLowongan: json["id_lowongan"],
    idPerusahaan: json["id_perusahaan"],
    namaPerusahaan: json["nama_perusahaan"],
    pendidikan: json["pendidikan"],
    kouta: json["kouta"],
    endPost: DateTime.parse(json["end_post"]),
    provinceId: json["province_id"],
    cityId: json["city_id"],
    logo: json["logo"],
    gajiMin: json["gaji_min"],
    gajiMax: json["gaji_max"],
    posisi: json["posisi"],
    kualifikasi: json["kualifikasi"],
    jenjangCareerId: json["jenjang_career_id"],
    totalPelamar: json["total_pelamar"],
    pengalamanId: json["pengalaman_id"],
    fungsiKerjaId: json["fungsi_kerja_id"],
    rincian: json["rincian"],
  );

  Map<String, dynamic> toJson() => {
    "id_lowongan": idLowongan,
    "id_perusahaan": idPerusahaan,
    "nama_perusahaan": namaPerusahaan,
    "pendidikan": pendidikan,
    "kouta": kouta,
    "end_post": "${endPost.year.toString().padLeft(4, '0')}-${endPost.month.toString().padLeft(2, '0')}-${endPost.day.toString().padLeft(2, '0')}",
    "province_id": provinceId,
    "city_id": cityId,
    "logo": logo,
    "gaji_min": gajiMin,
    "gaji_max": gajiMax,
    "posisi": posisi,
    "kualifikasi": kualifikasi,
    "jenjang_career_id": jenjangCareerId,
    "total_pelamar": totalPelamar,
    "pengalaman_id": pengalamanId,
    "fungsi_kerja_id": fungsiKerjaId,
    "rincian": rincian,
  };
}

class Perusahaan {
  String id;
  String userId;
  String paketId;
  String duration;
  String contractDateStart;
  String contractDateEnd;
  String total;
  String nama;
  String posisi;
  String namaPerusahaan;
  String alamatWebsite;
  String nomorTelepon;
  String hp;
  String alamat;
  String provinceId;
  String cityId;
  String kodepos;
  String noReg;
  String logo;
  String sifatBisnis;
  String industriId;
  String deskripsi;
  String bankId;
  String namaRekening;
  String nomorRekening;
  String status;
  String statusPaket;
  String isOmss;
  String isCsr;
  dynamic isCabangRelated;
  String isCabangStatus;
  String kuotaLowker;
  String kuotaDetpelamar;
  String kuotaTawarkerja;
  String kuotaRefkandidat;
  String kuotaJadwalinterview;
  String statusPaketUnlimited;
  String statusRejected;
  dynamic idCabang;
  dynamic cabangStatusId;
  dynamic suratPerjanjian;
  dynamic dateActive;
  String statusTop;
  String statusHomepage;
  String statusInternal;
  String referralCode;

  Perusahaan({
    this.id,
    this.userId,
    this.paketId,
    this.duration,
    this.contractDateStart,
    this.contractDateEnd,
    this.total,
    this.nama,
    this.posisi,
    this.namaPerusahaan,
    this.alamatWebsite,
    this.nomorTelepon,
    this.hp,
    this.alamat,
    this.provinceId,
    this.cityId,
    this.kodepos,
    this.noReg,
    this.logo,
    this.sifatBisnis,
    this.industriId,
    this.deskripsi,
    this.bankId,
    this.namaRekening,
    this.nomorRekening,
    this.status,
    this.statusPaket,
    this.isOmss,
    this.isCsr,
    this.isCabangRelated,
    this.isCabangStatus,
    this.kuotaLowker,
    this.kuotaDetpelamar,
    this.kuotaTawarkerja,
    this.kuotaRefkandidat,
    this.kuotaJadwalinterview,
    this.statusPaketUnlimited,
    this.statusRejected,
    this.idCabang,
    this.cabangStatusId,
    this.suratPerjanjian,
    this.dateActive,
    this.statusTop,
    this.statusHomepage,
    this.statusInternal,
    this.referralCode,
  });

  factory Perusahaan.fromJson(Map<String, dynamic> json) => Perusahaan(
    id: json["id"],
    userId: json["user_id"],
    paketId: json["paket_id"],
    duration: json["duration"],
    contractDateStart: json["contract_date_start"],
    contractDateEnd: json["contract_date_end"],
    total: json["total"],
    nama: json["nama"],
    posisi: json["posisi"],
    namaPerusahaan: json["nama_perusahaan"],
    alamatWebsite: json["alamat_website"],
    nomorTelepon: json["nomor_telepon"],
    hp: json["hp"],
    alamat: json["alamat"],
    provinceId: json["province_id"],
    cityId: json["city_id"],
    kodepos: json["kodepos"],
    noReg: json["no_reg"],
    logo: json["logo"],
    sifatBisnis: json["sifat_bisnis"],
    industriId: json["industri_id"],
    deskripsi: json["deskripsi"],
    bankId: json["bank_id"],
    namaRekening: json["nama_rekening"],
    nomorRekening: json["nomor_rekening"],
    status: json["status"],
    statusPaket: json["status_paket"],
    isOmss: json["is_omss"],
    isCsr: json["is_csr"],
    isCabangRelated: json["is_cabang_related"],
    isCabangStatus: json["is_cabang_status"],
    kuotaLowker: json["kuota_lowker"],
    kuotaDetpelamar: json["kuota_detpelamar"],
    kuotaTawarkerja: json["kuota_tawarkerja"],
    kuotaRefkandidat: json["kuota_refkandidat"],
    kuotaJadwalinterview: json["kuota_jadwalinterview"],
    statusPaketUnlimited: json["status_paket_unlimited"],
    statusRejected: json["status_rejected"],
    idCabang: json["id_cabang"],
    cabangStatusId: json["cabang_status_id"],
    suratPerjanjian: json["surat_perjanjian"],
    dateActive: json["date_active"],
    statusTop: json["status_top"],
    statusHomepage: json["status_homepage"],
    statusInternal: json["status_internal"],
    referralCode: json["referral_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "paket_id": paketId,
    "duration": duration,
    "contract_date_start": contractDateStart,
    "contract_date_end": contractDateEnd,
    "total": total,
    "nama": nama,
    "posisi": posisi,
    "nama_perusahaan": namaPerusahaan,
    "alamat_website": alamatWebsite,
    "nomor_telepon": nomorTelepon,
    "hp": hp,
    "alamat": alamat,
    "province_id": provinceId,
    "city_id": cityId,
    "kodepos": kodepos,
    "no_reg": noReg,
    "logo": logo,
    "sifat_bisnis": sifatBisnis,
    "industri_id": industriId,
    "deskripsi": deskripsi,
    "bank_id": bankId,
    "nama_rekening": namaRekening,
    "nomor_rekening": nomorRekening,
    "status": status,
    "status_paket": statusPaket,
    "is_omss": isOmss,
    "is_csr": isCsr,
    "is_cabang_related": isCabangRelated,
    "is_cabang_status": isCabangStatus,
    "kuota_lowker": kuotaLowker,
    "kuota_detpelamar": kuotaDetpelamar,
    "kuota_tawarkerja": kuotaTawarkerja,
    "kuota_refkandidat": kuotaRefkandidat,
    "kuota_jadwalinterview": kuotaJadwalinterview,
    "status_paket_unlimited": statusPaketUnlimited,
    "status_rejected": statusRejected,
    "id_cabang": idCabang,
    "cabang_status_id": cabangStatusId,
    "surat_perjanjian": suratPerjanjian,
    "date_active": dateActive,
    "status_top": statusTop,
    "status_homepage": statusHomepage,
    "status_internal": statusInternal,
    "referral_code": referralCode,
  };
}