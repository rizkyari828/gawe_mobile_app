// To parse this JSON data, do
//
//     final modelUser = modelUserFromJson(jsonString);

import 'dart:convert';

ModelUser modelUserFromJson(String str) => ModelUser.fromJson(json.decode(str));

String modelUserToJson(ModelUser data) => json.encode(data.toJson());

class ModelUser {
  String message;
  int status;
  String level;
  User user;

  ModelUser({
    this.message,
    this.status,
    this.level,
    this.user,
  });

  factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
    message: json["message"],
    status: json["status"],
    level: json["level"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "level": level,
    "user": user.toJson(),
  };
}

class User {
  String id;
  String name;
  String email;
  String password;
  String idProvince;
  String idCity;
  String idKecamatan;
  String gender;
  String statusUser;
  String photo;
  String token;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.idProvince,
    this.idCity,
    this.idKecamatan,
    this.gender,
    this.statusUser,
    this.photo,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    idProvince: json["id_province"],
    idCity: json["id_city"],
    idKecamatan: json["id_kecamatan"],
    gender: json["gender"],
    statusUser: json["status_user"],
    photo: json["photo"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "password": password,
    "id_province": idProvince,
    "id_city": idCity,
    "id_kecamatan": idKecamatan,
    "gender": gender,
    "status_user": statusUser,
    "photo": photo,
    "token": token,
  };
}
