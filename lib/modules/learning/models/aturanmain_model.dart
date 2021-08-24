// To parse this JSON data, do
//
//     final aturanmainModel = aturanmainModelFromJson(jsonString);

import 'dart:convert';

AturanmainModel aturanmainModelFromJson(String str) => AturanmainModel.fromJson(json.decode(str));

String aturanmainModelToJson(AturanmainModel data) => json.encode(data.toJson());

class AturanmainModel {
  AturanmainModel({
    this.status,
    this.message,
    this.insertId,
  });

  int status;
  String message;
  int insertId;

  factory AturanmainModel.fromJson(Map<String, dynamic> json) => AturanmainModel(
    status: json["status"],
    message: json["message"],
    insertId: json["insert_id"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "insert_id": insertId,
  };
}
