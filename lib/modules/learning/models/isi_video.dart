// To parse this JSON data, do
//
//     final isivideoModel = isivideoModelFromJson(jsonString);

import 'dart:convert';

IsivideoModel isivideoModelFromJson(String str) => IsivideoModel.fromJson(json.decode(str));

String isivideoModelToJson(IsivideoModel data) => json.encode(data.toJson());

class IsivideoModel {
  IsivideoModel({
    this.status,
    this.message,
    this.videoIsi,
  });

  int status;
  String message;
  List<VideoIsi> videoIsi;

  factory IsivideoModel.fromJson(Map<String, dynamic> json) => IsivideoModel(
    status: json["status"],
    message: json["message"],
    videoIsi: List<VideoIsi>.from(json["video_isi"].map((x) => VideoIsi.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "video_isi": List<dynamic>.from(videoIsi.map((x) => x.toJson())),
  };
}

class VideoIsi {
  VideoIsi({
    this.id,
    this.namaMateri,
    this.url,
    this.materiId,
    this.penulis,
    this.video,
    this.status,
  });

  String id;
  String namaMateri;
  String url;
  String materiId;
  String penulis;
  String video;
  String status;

  factory VideoIsi.fromJson(Map<String, dynamic> json) => VideoIsi(
    id: json["id"],
    namaMateri: json["nama_materi"],
    url: json["url"],
    materiId: json["materi_id"],
    penulis: json["penulis"],
    video: json["video"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_materi": namaMateri,
    "url": url,
    "materi_id": materiId,
    "penulis": penulis,
    "video": video,
    "status": status,
  };
}
