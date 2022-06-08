// To parse this JSON data, do
//
//     final uranaiData = uranaiDataFromJson(jsonString);

import 'dart:convert';

UranaiData uranaiDataFromJson(String str) =>
    UranaiData.fromJson(json.decode(str));

String uranaiDataToJson(UranaiData data) => json.encode(data.toJson());

class UranaiData {
  UranaiData({
    required this.data,
  });

  List<Datum> data;

  factory UranaiData.fromJson(Map<String, dynamic> json) => UranaiData(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.date,
    required this.titleTotal,
    required this.pointTotal,
    required this.pointLove,
    required this.pointMoney,
    required this.pointWork,
  });

  DateTime date;
  String titleTotal;
  String pointTotal;
  String pointLove;
  String pointMoney;
  String pointWork;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    date: DateTime.parse(json["date"]),
    titleTotal: json["title_total"],
    pointTotal: json["point_total"],
    pointLove: json["point_love"],
    pointMoney: json["point_money"],
    pointWork: json["point_work"],
  );

  Map<String, dynamic> toJson() => {
    "date":
    "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "title_total": titleTotal,
    "point_total": pointTotal,
    "point_love": pointLove,
    "point_money": pointMoney,
    "point_work": pointWork,
  };
}
