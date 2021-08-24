class ModelEditPengalamanOrg {
  String id;
  String employee_id;
  String nama_organisasi;
  String jabatan;
  String mulai;
  String akhir;



  ModelEditPengalamanOrg({
    this.id,
    this.employee_id,
    this.nama_organisasi,
    this.jabatan,
    this.mulai,
    this.akhir,
  });


  @override
  String toString() {
    return 'Sample{nama_organisasi: $nama_organisasi, nama_organisasi: $nama_organisasi}';
  }

  factory ModelEditPengalamanOrg.fromJson(Map<String, dynamic> json) {
    return ModelEditPengalamanOrg(
      id: json["id"],
      employee_id: json["employee_id"],
      nama_organisasi: json["nama_organisasi"],
      jabatan: json["jabatan"],
      mulai: json["mulai"],
      akhir: json["akhir"],


    );
  }
}
