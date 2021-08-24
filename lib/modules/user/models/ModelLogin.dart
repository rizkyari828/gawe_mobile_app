// To parse this JSON data, do
//
//     final modelLogin = modelLoginFromJson(jsonString);

import 'dart:convert';

ModelLogin modelLoginFromJson(String str) => ModelLogin.fromJson(json.decode(str));

String modelLoginToJson(ModelLogin data) => json.encode(data.toJson());

class ModelLogin {
  String message;
  int status;
  String userId;
  String idEmployee;
  String firstName;
  String email;
  String password;
  String picture;
  String profile_power;
  double latitude;
  double longitude;

  ModelLogin({
    this.message,
    this.status,
    this.userId,
    this.idEmployee,
    this.firstName,
    this.email,
    this.password,
    this.picture,
    this.profile_power,
    this.latitude,
    this.longitude
  });

  factory ModelLogin.fromJson(Map<String, dynamic> json) => ModelLogin(
    message: json["message"],
    status: json["status"],
    userId: json["user_id"],
    idEmployee: json["id_employee"],
    firstName: json["firstName"],
    email: json["email"],
    password: json["password"],
    picture: json["picture"],
      profile_power : json['profile_power'],
      latitude : json["latitude"],
    longitude : json["longitude"]
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "user_id": userId,
    "id_employee": idEmployee,
    "firstName": firstName,
    "email": email,
    "password": password,
    "picture": picture,
    "profile_power":profile_power,
    "latitude" : latitude,
    "longitude" : longitude
  };
}
