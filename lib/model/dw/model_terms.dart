class Terms {
  String id;
  String job_order;
  String upah;
  String mulai_kerja;
  String selesai_kerja;
  String client;
  String penempatan;
  String ttd;
  String hariiini;
  String hariini2;
  String tanggal_gajian;
  String lokasi_penempatan_client;



  Terms({
    this.id,
    this.job_order,
    this.upah,
    this.mulai_kerja,
    this.selesai_kerja,
    this.client,
    this.penempatan,
    this.ttd,
    this.hariiini,
    this.hariini2,
    this.tanggal_gajian,
    this.lokasi_penempatan_client,

  });
  @override
  String toString() {
    return 'Sample{name: $job_order, age: $job_order}';
  }

  factory Terms.fromJson(Map<String, dynamic> json) {
    return Terms(
      id: json["id"],
      job_order: json["job_order"],
      upah: json["upah"],
      mulai_kerja: json["mulai_kerja"],
      selesai_kerja: json["selesai_kerja"],
      client: json["client"],
      penempatan: json["penempatan"],
      ttd: json["ttd"],
      hariiini: json["hariiini"],
      hariini2: json["hariini2"],
      tanggal_gajian: json["tanggal_gajian"],
      lokasi_penempatan_client: json["lokasi_penempatan_client"],



    );
  }
}
