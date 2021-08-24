// To parse this JSON data, do
//
//     final modelCheck = modelCheckFromJson(jsonString);

import 'dart:convert';

ModelCheck modelCheckFromJson(String str) => ModelCheck.fromMap(json.decode(str));

String modelCheckToJson(ModelCheck data) => json.encode(data.toMap());

class ModelCheck {
  int status;
  String message;
  String check;

  ModelCheck({
    this.status,
    this.message,
    this.check,
  });

  factory ModelCheck.fromMap(Map<String, dynamic> json) => ModelCheck(
    status: json["status"],
    message: json["message"],
    check: json["check"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "check": check,
  };
}
