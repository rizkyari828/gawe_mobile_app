// To parse this JSON data, do
//
//     final modelNotifikasi = modelNotifikasiFromJson(jsonString);

import 'dart:convert';

ModelNotifikasi modelNotifikasiFromJson(String str) => ModelNotifikasi.fromJson(json.decode(str));

String modelNotifikasiToJson(ModelNotifikasi data) => json.encode(data.toJson());

class ModelNotifikasi {
  String status;
  String message;
  String not_read;
  int total;
  List<Pemberitahuan> pemberitahuan;

  ModelNotifikasi({
    this.status,
    this.message,
    this.not_read,
    this.total,
    this.pemberitahuan,
  });

  factory ModelNotifikasi.fromJson(Map<String, dynamic> json) => ModelNotifikasi(
    status: json["status"],
    message: json["message"],
    not_read: json["not_read"],
    total: json["total"],
    pemberitahuan: List<Pemberitahuan>.from(json["pemberitahuan"].map((x) => Pemberitahuan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "not_read":not_read,
    "total":total,
    "pemberitahuan": List<dynamic>.from(pemberitahuan.map((x) => x.toJson())),
  };
}

class Pemberitahuan {
  String id;
  String relatedType;
  String relatedName;
  String relatedText;
  String relatedModule;
  String relatedLinkText;
  String relatedLinkFrom;
  String relatedLast;
  String redirectLinkRefid;
  String redirectLink;
  String readIs;
  String readAt;
  String mdd;
  String ctd;
  String link_go_to;

  Pemberitahuan({
    this.id,
    this.relatedType,
    this.relatedName,
    this.relatedText,
    this.relatedModule,
    this.relatedLinkText,
    this.relatedLinkFrom,
    this.relatedLast,
    this.redirectLinkRefid,
    this.redirectLink,
    this.readIs,
    this.readAt,
    this.mdd,
    this.ctd,
    this.link_go_to,
  });

  factory Pemberitahuan.fromJson(Map<String, dynamic> json) => Pemberitahuan(
    id: json["id"],
    relatedType: json["related_type"],
    relatedName: json["related_name"],
    relatedText: json["related_text"],
    relatedModule: json["related_module"],
    relatedLinkText: json["related_link_text"],
    relatedLinkFrom: json["related_link_from"],
    relatedLast: json["related_last"],
    redirectLinkRefid: json["redirect_link_refid"],
    redirectLink: json["redirect_link"],
    readIs: json["read_is"],
    readAt: json["read_at"],
    mdd: json["mdd"],
    ctd: json["ctd"],
    link_go_to:json["link_go_to"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "related_type": relatedType,
    "related_text": relatedText,
    "related_module": relatedModule,
    "related_link_text": relatedLinkText,
    "related_link_from": relatedLinkFrom,
    "related_last": relatedLast,
    "redirect_link_refid": redirectLinkRefid,
    "redirect_link": redirectLink,
    "read_is": readIs,
    "read_at": readAt,
    "mdd": mdd,
    "ctd": ctd,
    "link_go_to":link_go_to,
  };
}
