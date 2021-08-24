import 'dart:convert';

List<ModelFaq> modelFaqFromJson(String str) => List<ModelFaq>.from(json.decode(str).map((x) => ModelFaq.fromJson(x)));

String modelFaqToJson(List<ModelFaq> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelFaq {
  String id;
  String title;
  String desc;
//  DateTime dateCreated;

  ModelFaq({
    this.id,
    this.title,
    this.desc,
//    this.dateCreated,
  });

  factory ModelFaq.fromJson(Map<String, dynamic> json) => ModelFaq(
    id: json["id"],
    title: json["title"],
    desc: json["desc"],
//    dateCreated: DateTime.parse(json["date_created"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "desc": desc,
//    "date_created": "${dateCreated.year.toString().padLeft(4, '0')}-${dateCreated.month.toString().padLeft(2, '0')}-${dateCreated.day.toString().padLeft(2, '0')}",
  };
}
