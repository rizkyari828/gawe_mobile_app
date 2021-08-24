// To parse this JSON data, do
//
//     final modelRiwayatSaldo = modelRiwayatSaldoFromJson(jsonString);

import 'dart:convert';

ModelRiwayatSaldo modelRiwayatSaldoFromJson(String str) => ModelRiwayatSaldo.fromJson(json.decode(str));

String modelRiwayatSaldoToJson(ModelRiwayatSaldo data) => json.encode(data.toJson());

class ModelRiwayatSaldo {
  ModelRiwayatSaldo({
    this.status,
    this.message,
    this.dwRiwayatSaldo,
  });

  int status;
  String message;
  List<DwRiwayatSaldo> dwRiwayatSaldo;

  factory ModelRiwayatSaldo.fromJson(Map<String, dynamic> json) => ModelRiwayatSaldo(
    status: json["status"],
    message: json["message"],
    dwRiwayatSaldo: List<DwRiwayatSaldo>.from(json["dw_riwayat_saldo"].map((x) => DwRiwayatSaldo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "dw_riwayat_saldo": List<dynamic>.from(dwRiwayatSaldo.map((x) => x.toJson())),
  };
}

class DwRiwayatSaldo {
  DwRiwayatSaldo({
    this.id,
    this.saldoMasuk,
    this.tanggalSaldoMasuk,
    this.idLowongan,
  });

  String id;
  String saldoMasuk;
  String tanggalSaldoMasuk;
  String idLowongan;

  factory DwRiwayatSaldo.fromJson(Map<String, dynamic> json) => DwRiwayatSaldo(
    id: json["id"],
    saldoMasuk: json["saldo_masuk"],
    tanggalSaldoMasuk: json["tanggal_saldo_masuk"],
    idLowongan: json["id_lowongan"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "saldo_masuk": saldoMasuk,
    "tanggal_saldo_masuk": tanggalSaldoMasuk,
    "id_lowongan": idLowongan,
  };
}
