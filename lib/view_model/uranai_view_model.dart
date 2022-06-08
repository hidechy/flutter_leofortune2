import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import '../models/uranai_data.dart';

//////////////////////////////////////////////////////////////////////
final monthlyUranaiProvider = StateNotifierProvider.autoDispose
    .family<MonthlyUranaiStateNotifier, List<Datum>, String>((ref, date) {
  return MonthlyUranaiStateNotifier([])..getMonthlyUranaiData(date: date);
});

class MonthlyUranaiStateNotifier extends StateNotifier<List<Datum>> {
  MonthlyUranaiStateNotifier(List<Datum> state) : super(state);

  ///
  void getMonthlyUranaiData({required String date}) async {
    String url = "http://toyohide.work/BrainLog/api/monthlyuranai";
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({"date": date});
    Response response = await post(Uri.parse(url), headers: headers, body: body);

    final data = jsonDecode(response.body);

    List<Datum> list = [];
    for (var i = 0; i < data['data'].length; i++) {
      list.add(
        Datum(
          date: DateTime.parse(data['data'][i]['date']),
          titleTotal: data['data'][i]['title_total'],
          pointTotal: data['data'][i]['point_total'],
          pointLove: data['data'][i]['point_love'],
          pointMoney: data['data'][i]['point_money'],
          pointWork: data['data'][i]['point_work'],
        ),
      );
    }

    state = list;
  }
}
//////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////
final yearlyUranaiProvider = StateNotifierProvider.autoDispose
    .family<YearlyUranaiStateNotifier, List<Datum>, String>((ref, date) {
  return YearlyUranaiStateNotifier([])..getYearlyUranaiData(date: date);
});

class YearlyUranaiStateNotifier extends StateNotifier<List<Datum>> {
  YearlyUranaiStateNotifier(List<Datum> state) : super(state);

  ///
  void getYearlyUranaiData({required String date}) async {
    String url = "http://toyohide.work/BrainLog/api/yearlyuranai";
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({"date": date});
    Response response = await post(Uri.parse(url), headers: headers, body: body);

    final data = jsonDecode(response.body);

    List<Datum> list = [];
    for (var i = 0; i < data['data'].length; i++) {
      list.add(
        Datum(
          date: DateTime.parse(data['data'][i]['date']),
          titleTotal: data['data'][i]['title_total'],
          pointTotal: data['data'][i]['point_total'],
          pointLove: data['data'][i]['point_love'],
          pointMoney: data['data'][i]['point_money'],
          pointWork: data['data'][i]['point_work'],
        ),
      );
    }

    state = list;
  }
}
//////////////////////////////////////////////////////////////////////
