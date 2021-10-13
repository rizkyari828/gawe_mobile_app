// To parse this JSON data, do
//
//     final versionModel = versionModelFromJson(jsonString);

import 'dart:convert';

VersionModel versionModelFromJson(String str) => VersionModel.fromJson(json.decode(str));

String versionModelToJson(VersionModel data) => json.encode(data.toJson());

class VersionModel {
  VersionModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Data data;

  factory VersionModel.fromJson(Map<String, dynamic> json) => VersionModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.appVersion,
    this.createdAt,
    this.description,
    this.buildNumber,
    this.updateAvailable,
  });

  String appVersion;
  DateTime createdAt;
  String description;
  String buildNumber;
  int updateAvailable;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    appVersion: json["app_version"],
    createdAt: DateTime.parse(json["created_at"]),
    description: json["description"],
    buildNumber: json["build_number"],
    updateAvailable: json["update_available"],
  );

  Map<String, dynamic> toJson() => {
    "app_version": appVersion,
    "created_at": createdAt.toIso8601String(),
    "description": description,
    "build_number": buildNumber,
    "update_available": updateAvailable,
  };
}
