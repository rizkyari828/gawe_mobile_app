// To parse this JSON data, do
//
//     final soal2Model = soal2ModelFromJson(jsonString);

import 'dart:convert';

Soal2Model soal2ModelFromJson(String str) => Soal2Model.fromJson(json.decode(str));

String soal2ModelToJson(Soal2Model data) => json.encode(data.toJson());

class Soal2Model {
  Soal2Model({
    this.status,
    this.message,
    this.soal,
  });

  int status;
  String message;
  List<Soal> soal;

  factory Soal2Model.fromJson(Map<String, dynamic> json) => Soal2Model(
    status: json["status"],
    message: json["message"],
    soal: List<Soal>.from(json["soal"].map((x) => Soal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "soal": List<dynamic>.from(soal.map((x) => x.toJson())),
  };
}

class Soal {
  Soal({
    this.soal,
    this.jawabanA,
    this.jawabanB,
    this.jawabanC,
    this.jawabanD,
    this.kunciJawaban,
    this.skor,
    this.soalSekarang,
    this.insertId,
    this.idSoal,
  });

  String soal;
  String jawabanA;
  String jawabanB;
  String jawabanC;
  String jawabanD;
  String kunciJawaban;
  String skor;
  String soalSekarang;
  String insertId;
  String idSoal;

  factory Soal.fromJson(Map<String, dynamic> json) => Soal(
    soal: json["soal"],
    jawabanA: json["jawaban_a"],
    jawabanB: json["jawaban_b"],
    jawabanC: json["jawaban_c"],
    jawabanD: json["jawaban_d"],
    kunciJawaban: json["kunci_jawaban"],
    skor: json["skor"],
    soalSekarang: json["soal_sekarang"],
    insertId: json["insert_id"],
    idSoal: json["id_soal"],
  );

  Map<String, dynamic> toJson() => {
    "soal": soal,
    "jawaban_a": jawabanA,
    "jawaban_b": jawabanB,
    "jawaban_c": jawabanC,
    "jawaban_d": jawabanD,
    "kunci_jawaban": kunciJawaban,
    "skor": skor,
    "soal_sekarang": soalSekarang,
    "insert_id": insertId,
    "id_soal": idSoal,
  };
}
