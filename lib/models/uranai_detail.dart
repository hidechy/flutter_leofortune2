// To parse this JSON data, do
//
//     final uranaiDetail = uranaiDetailFromJson(jsonString);

import 'dart:convert';

UranaiDetail uranaiDetailFromJson(String str) =>
    UranaiDetail.fromJson(json.decode(str));

String uranaiDetailToJson(UranaiDetail data) => json.encode(data.toJson());

class UranaiDetail {
  UranaiDetail({
    required this.data,
  });

  List<DetailData> data;

  factory UranaiDetail.fromJson(Map<String, dynamic> json) => UranaiDetail(
    data: List<DetailData>.from(
        json["data"].map((x) => DetailData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DetailData {
  DetailData({
    required this.date,
    required this.totalTitle,
    required this.totalDescription,
    required this.totalPoint,
    required this.loveDescription,
    required this.lovePoint,
    required this.moneyDescription,
    required this.moneyPoint,
    required this.workDescription,
    required this.workPoint,
    required this.sachikoiRank,
    required this.sachikoiLove,
    required this.sachikoiMoney,
    required this.sachikoiWork,
    required this.sachikoiMan,
  });

  DateTime date;
  String totalTitle;
  String totalDescription;
  String totalPoint;
  String loveDescription;
  String lovePoint;
  String moneyDescription;
  String moneyPoint;
  String workDescription;
  String workPoint;
  String sachikoiRank;
  String sachikoiLove;
  String sachikoiMoney;
  String sachikoiWork;
  String sachikoiMan;

  factory DetailData.fromJson(Map<String, dynamic> json) => DetailData(
    date: DateTime.parse(json["date"]),
    totalTitle: json["total_title"],
    totalDescription: json["total_description"],
    totalPoint: json["total_point"],
    loveDescription: json["love_description"],
    lovePoint: json["love_point"],
    moneyDescription: json["money_description"],
    moneyPoint: json["money_point"],
    workDescription: json["work_description"],
    workPoint: json["work_point"],
    sachikoiRank: json["sachikoi_rank"],
    sachikoiLove: json["sachikoi_love"],
    sachikoiMoney: json["sachikoi_money"],
    sachikoiWork: json["sachikoi_work"],
    sachikoiMan: json["sachikoi_man"],
  );

  Map<String, dynamic> toJson() => {
    "date":
    "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "total_title": totalTitle,
    "total_description": totalDescription,
    "total_point": totalPoint,
    "love_description": loveDescription,
    "love_point": lovePoint,
    "money_description": moneyDescription,
    "money_point": moneyPoint,
    "work_description": workDescription,
    "work_point": workPoint,
    "sachikoi_rank": sachikoiRank,
    "sachikoi_love": sachikoiLove,
    "sachikoi_money": sachikoiMoney,
    "sachikoi_work": sachikoiWork,
    "sachikoi_man": sachikoiMan,
  };
}
