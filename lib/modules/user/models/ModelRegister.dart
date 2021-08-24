// To parse this JSON data, do
//
//     final modelRegister = modelRegisterFromJson(jsonString);

import 'dart:convert';

ModelRegister modelRegisterFromJson(String str) => ModelRegister.fromJson(json.decode(str));

String modelRegisterToJson(ModelRegister data) => json.encode(data.toJson());

class ModelRegister {
  int status;
  String message;


  ModelRegister({
    this.status,
    this.message,

  });

  factory ModelRegister.fromJson(Map<String, dynamic> json) => ModelRegister(
    status: json["status"],
    message: json["message"],


  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
