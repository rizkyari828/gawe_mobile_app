class Sample {
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
  String tglLahir2;
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
  dynamic poin;
  String profilePower;
  String kepemilikanHp;
  String kepemilikanHpTipe;
  String minatParent;
  String minatChild;
  String sim;
  String kendaraan;
  dynamic statusPengalaman;
  String sumber;
  String versi;
  String os;
  String jobParent;
  String jobChild;
  String email;
  String file_ktp;
  String file_cv;
  String file_kk;
  String file_bk;
  String file_ijazah;
  String nama_bank;
  String no_rek;
  String nama_keluarga;
  String hubungan_keluarga;
  String no_hp_keluarga;
  String province_lahir;
  String no_kk;

  Sample({
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
    this.file_ktp,
    this.file_cv,
    this.file_kk,
    this.file_bk,
    this.file_ijazah,
    this.nama_bank,
    this.no_rek,
    this.nama_keluarga,
    this.hubungan_keluarga,
    this.no_hp_keluarga,
    this.province_lahir,
    this.no_kk,
  });
  @override
  String toString() {
    return 'Sample{name: $nama, age: $nama}';
  }

  factory Sample.fromJson(Map<String, dynamic> json) {
    return Sample(
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
      tglLahir2: json["tgl_lahir2"],
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
      file_ktp: json["file_ktp"],
      file_kk: json["file_kk"],
      file_cv: json["file_cv"],
      file_bk: json["file_bk"],
      file_ijazah: json["file_ijazah"],
      nama_bank: json["nama_bank"],
      no_rek: json["no_rek"],
      nama_keluarga: json["nama_keluarga"],
      hubungan_keluarga: json["hubungan_keluarga"],
      no_hp_keluarga: json["no_hp_keluarga"],
      province_lahir: json["province_lahir"],
      no_kk: json["no_kk"],
    );
  }
}
