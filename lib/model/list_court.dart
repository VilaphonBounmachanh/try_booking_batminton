// To parse this JSON data, do
//
//     final listCourt = listCourtFromJson(jsonString);

import 'dart:convert';

List<ListCourt> listCourtFromJson(String str) => List<ListCourt>.from(json.decode(str).map((x) => ListCourt.fromJson(x)));

String listCourtToJson(List<ListCourt> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListCourt {
  String date;
  List<String> durationTime;

  ListCourt({
    required this.date,
    required this.durationTime,
  });

  factory ListCourt.fromJson(Map<String, dynamic> json) => ListCourt(
        date: json["date"],
        durationTime: List<String>.from(json["duration_time"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "duration_time": List<dynamic>.from(durationTime.map((x) => x)),
      };
}
