// To parse this JSON data, do
//
//     final blockPsikotes = blockPsikotesFromJson(jsonString);

import 'dart:convert';



class Block_psikotes {
  int status;
  String message;
  String link;
  String planStartDate;
  String planEndDate;


  Block_psikotes({
    this.status,
    this.message,
    this.link,
    this.planStartDate,
    this.planEndDate,


  });
  @override
  String toString() {
    return 'Sample{name: $message, age: $message}';
  }

  factory Block_psikotes.fromJson(Map<String, dynamic> json) {
    return Block_psikotes(
      status: json["status"],
      message: json["message"],
      link: json["link"],
      planStartDate: json["plan_start_date"],
      planEndDate: json["plan_end_date"],


    );
  }
}
