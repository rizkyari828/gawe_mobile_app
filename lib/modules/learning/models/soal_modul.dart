// To parse this JSON data, do
//
//     final soalModul = soalModulFromJson(jsonString);

import 'dart:convert';

SoalModul soalModulFromJson(String str) => SoalModul.fromJson(json.decode(str));

String soalModulToJson(SoalModul data) => json.encode(data.toJson());

class SoalModul {
  SoalModul({
    this.status,
    this.message,
    this.soal,
    this.jawabanA,
    this.jawabanB,
    this.jawabanC,
    this.jawabanD,
    this.kunciJawaban,
    this.skor,
    this.idSoal,
    this.soalSekarang,
    this.insertId,
  });

  int status;
  String message;
  String soal;
  String jawabanA;
  String jawabanB;
  String jawabanC;
  String jawabanD;
  String kunciJawaban;
  String skor;
  String idSoal;
  int soalSekarang;
  String insertId;

  factory SoalModul.fromJson(Map<String, dynamic> json) => SoalModul(
    status: json["status"],
    message: json["message"],
    soal: json["soal"],
    jawabanA: json["jawaban_a"],
    jawabanB: json["jawaban_b"],
    jawabanC: json["jawaban_c"],
    jawabanD: json["jawaban_d"],
    kunciJawaban: json["kunci_jawaban"],
    skor: json["skor"],
    idSoal: json["id_soal"],
    soalSekarang: json["soal_sekarang"],
    insertId: json["insert_id"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "soal": soal,
    "jawaban_a": jawabanA,
    "jawaban_b": jawabanB,
    "jawaban_c": jawabanC,
    "jawaban_d": jawabanD,
    "kunci_jawaban": kunciJawaban,
    "skor": skor,
    "id_soal": idSoal,
    "soal_sekarang": soalSekarang,
    "insert_id": insertId,
  };
}
