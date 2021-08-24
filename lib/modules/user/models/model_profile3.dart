// To parse this JSON data, do
//
//     final modelProfile3 = modelProfile3FromJson(jsonString);

import 'dart:convert';

List<ModelProfile3> modelProfile3FromJson(String str) => List<ModelProfile3>.from(json.decode(str).map((x) => ModelProfile3.fromJson(x)));

String modelProfile3ToJson(List<ModelProfile3> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelProfile3 {
  ModelProfile3({
    this.id,
    this.userId,
    this.nama,
    this.posisi,
    this.provinceId,
    this.cityId,
    this.minGaji,
    this.maxGaji,
    this.pendidikanId,
    this.universitas,
    this.jurusanId,
    this.ipk,
    this.thnMasuk,
    this.thnLulus,
    this.nomorTelepon,
    this.hp,
    this.nik,
    this.alamatDomisili,
    this.alamatKtp,
    this.kodepos,
    this.tglLahir,
    this.tglLahir2,
    this.tmpLahir,
    this.gender,
    this.statusPerkawinan,
    this.agama,
    this.cardSimA,
    this.cardSimB1,
    this.cardSimB2,
    this.cardSimC,
    this.punyaMobil,
    this.punyaMotor,
    this.website,
    this.facebook,
    this.twitter,
    this.instagram,
    this.linkedin,
    this.picture,
    this.poin,
    this.profilePower,
    this.kepemilikanHp,
    this.kepemilikanHpTipe,
    this.minatParent,
    this.minatChild,
    this.sim,
    this.kendaraan,
    this.statusPengalaman,
    this.sumber,
    this.versi,
    this.os,
    this.jobParent,
    this.jobChild,
    this.email,
    this.pengalamanKerja,
    this.pengalamanOrganisasi,
  });

  String id;
  String userId;
  String nama;
  dynamic posisi;
  String provinceId;
  String cityId;
  String minGaji;
  String maxGaji;
  String pendidikanId;
  String universitas;
  String jurusanId;
  String ipk;
  String thnMasuk;
  String thnLulus;
  String nomorTelepon;
  String hp;
  String nik;
  String alamatDomisili;
  String alamatKtp;
  String kodepos;
  String tglLahir;
  DateTime tglLahir2;
  String tmpLahir;
  String gender;
  String statusPerkawinan;
  String agama;
  String cardSimA;
  String cardSimB1;
  String cardSimB2;
  String cardSimC;
  String punyaMobil;
  String punyaMotor;
  dynamic website;
  String facebook;
  String twitter;
  String instagram;
  String linkedin;
  String picture;
  String poin;
  String profilePower;
  dynamic kepemilikanHp;
  dynamic kepemilikanHpTipe;
  String minatParent;
  String minatChild;
  String sim;
  String kendaraan;
  String statusPengalaman;
  String sumber;
  String versi;
  String os;
  String jobParent;
  String jobChild;
  String email;
  List<PengalamanKerja> pengalamanKerja;
  List<PengalamanOrganisasi> pengalamanOrganisasi;

  factory ModelProfile3.fromJson(Map<String, dynamic> json) => ModelProfile3(
    id: json["id"],
    userId: json["user_id"],
    nama: json["nama"],
    posisi: json["posisi"],
    provinceId: json["province_id"],
    cityId: json["city_id"],
    minGaji: json["min_gaji"],
    maxGaji: json["max_gaji"],
    pendidikanId: json["pendidikan_id"],
    universitas: json["universitas"],
    jurusanId: json["jurusan_id"],
    ipk: json["ipk"],
    thnMasuk: json["thn_masuk"],
    thnLulus: json["thn_lulus"],
    nomorTelepon: json["nomor_telepon"],
    hp: json["hp"],
    nik: json["nik"],
    alamatDomisili: json["alamat_domisili"],
    alamatKtp: json["alamat_ktp"],
    kodepos: json["kodepos"],
    tglLahir: json["tgl_lahir"],
    tglLahir2: DateTime.parse(json["tgl_lahir2"]),
    tmpLahir: json["tmp_lahir"],
    gender: json["gender"],
    statusPerkawinan: json["status_perkawinan"],
    agama: json["agama"],
    cardSimA: json["card_sim_a"],
    cardSimB1: json["card_sim_b1"],
    cardSimB2: json["card_sim_b2"],
    cardSimC: json["card_sim_c"],
    punyaMobil: json["punya_mobil"],
    punyaMotor: json["punya_motor"],
    website: json["website"],
    facebook: json["facebook"],
    twitter: json["twitter"],
    instagram: json["instagram"],
    linkedin: json["linkedin"],
    picture: json["picture"],
    poin: json["poin"],
    profilePower: json["profile_power"],
    kepemilikanHp: json["kepemilikan_hp"],
    kepemilikanHpTipe: json["kepemilikan_hp_tipe"],
    minatParent: json["minat_parent"],
    minatChild: json["minat_child"],
    sim: json["sim"],
    kendaraan: json["kendaraan"],
    statusPengalaman: json["status_pengalaman"],
    sumber: json["sumber"],
    versi: json["versi"],
    os: json["os"],
    jobParent: json["job_parent"],
    jobChild: json["job_child"],
    email: json["email"],
    pengalamanKerja: List<PengalamanKerja>.from(json["pengalaman_kerja"].map((x) => PengalamanKerja.fromJson(x))),
    pengalamanOrganisasi: List<PengalamanOrganisasi>.from(json["pengalaman_organisasi"].map((x) => PengalamanOrganisasi.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "nama": nama,
    "posisi": posisi,
    "province_id": provinceId,
    "city_id": cityId,
    "min_gaji": minGaji,
    "max_gaji": maxGaji,
    "pendidikan_id": pendidikanId,
    "universitas": universitas,
    "jurusan_id": jurusanId,
    "ipk": ipk,
    "thn_masuk": thnMasuk,
    "thn_lulus": thnLulus,
    "nomor_telepon": nomorTelepon,
    "hp": hp,
    "nik": nik,
    "alamat_domisili": alamatDomisili,
    "alamat_ktp": alamatKtp,
    "kodepos": kodepos,
    "tgl_lahir": tglLahir,
    "tgl_lahir2": "${tglLahir2.year.toString().padLeft(4, '0')}-${tglLahir2.month.toString().padLeft(2, '0')}-${tglLahir2.day.toString().padLeft(2, '0')}",
    "tmp_lahir": tmpLahir,
    "gender": gender,
    "status_perkawinan": statusPerkawinan,
    "agama": agama,
    "card_sim_a": cardSimA,
    "card_sim_b1": cardSimB1,
    "card_sim_b2": cardSimB2,
    "card_sim_c": cardSimC,
    "punya_mobil": punyaMobil,
    "punya_motor": punyaMotor,
    "website": website,
    "facebook": facebook,
    "twitter": twitter,
    "instagram": instagram,
    "linkedin": linkedin,
    "picture": picture,
    "poin": poin,
    "profile_power": profilePower,
    "kepemilikan_hp": kepemilikanHp,
    "kepemilikan_hp_tipe": kepemilikanHpTipe,
    "minat_parent": minatParent,
    "minat_child": minatChild,
    "sim": sim,
    "kendaraan": kendaraan,
    "status_pengalaman": statusPengalaman,
    "sumber": sumber,
    "versi": versi,
    "os": os,
    "job_parent": jobParent,
    "job_child": jobChild,
    "email": email,
    "pengalaman_kerja": List<dynamic>.from(pengalamanKerja.map((x) => x.toJson())),
    "pengalaman_organisasi": List<dynamic>.from(pengalamanOrganisasi.map((x) => x.toJson())),
  };
}

class PengalamanKerja {
  PengalamanKerja({
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
  });

  String id;
  String posisi;
  String namaPerusahaan;
  String industri;
  String lokasi;
  String gaji;
  DateTime tglMulai;
  DateTime tglBerhenti;
  String masihBekerja;
  String deskripsiPekerjaan;
  String fungsiKerjaId;

  factory PengalamanKerja.fromJson(Map<String, dynamic> json) => PengalamanKerja(
    id: json["id"],
    posisi: json["posisi"],
    namaPerusahaan: json["nama_perusahaan"],
    industri: json["industri"],
    lokasi: json["lokasi"],
    gaji: json["gaji"],
    tglMulai: DateTime.parse(json["tgl_mulai"]),
    tglBerhenti: DateTime.parse(json["tgl_berhenti"]),
    masihBekerja: json["masih_bekerja"],
    deskripsiPekerjaan: json["deskripsi_pekerjaan"],
    fungsiKerjaId: json["fungsi_kerja_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "posisi": posisi,
    "nama_perusahaan": namaPerusahaan,
    "industri": industri,
    "lokasi": lokasi,
    "gaji": gaji,
    "tgl_mulai": "${tglMulai.year.toString().padLeft(4, '0')}-${tglMulai.month.toString().padLeft(2, '0')}-${tglMulai.day.toString().padLeft(2, '0')}",
    "tgl_berhenti": "${tglBerhenti.year.toString().padLeft(4, '0')}-${tglBerhenti.month.toString().padLeft(2, '0')}-${tglBerhenti.day.toString().padLeft(2, '0')}",
    "masih_bekerja": masihBekerja,
    "deskripsi_pekerjaan": deskripsiPekerjaan,
    "fungsi_kerja_id": fungsiKerjaId,
  };
}

class PengalamanOrganisasi {
  PengalamanOrganisasi({
    this.id,
    this.namaOrganisasi,
    this.jabatan,
    this.mulai,
    this.akhir,
  });

  String id;
  String namaOrganisasi;
  String jabatan;
  String mulai;
  String akhir;

  factory PengalamanOrganisasi.fromJson(Map<String, dynamic> json) => PengalamanOrganisasi(
    id: json["id"],
    namaOrganisasi: json["nama_organisasi"],
    jabatan: json["jabatan"],
    mulai: json["mulai"],
    akhir: json["akhir"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_organisasi": namaOrganisasi,
    "jabatan": jabatan,
    "mulai": mulai,
    "akhir": akhir,
  };
}
