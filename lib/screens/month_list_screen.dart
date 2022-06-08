// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/uranai_data.dart';

import '../utilities/utility.dart';

import '../view_model/uranai_view_model.dart';

import 'detail_display_screen.dart';

class MonthListScreen extends ConsumerWidget {
  MonthListScreen({Key? key, required this.date}) : super(key: key);

  final String date;

  final Utility _utility = Utility();

  late BuildContext _context;
  late WidgetRef _ref;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;
    _context = context;



    final exDate = date.split('-');

    //----------------------------------//
    DateTime prevMonth =
    DateTime(int.parse(exDate[0]), int.parse(exDate[1]) - 1, 1);
    DateTime nextMonth =
    DateTime(int.parse(exDate[0]), int.parse(exDate[1]) + 1, 1);
    //----------------------------------//

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _utility.getBackGround(),
          Column(
            children: [
              const SizedBox(height: 40),
              monthLine(exDate, prevMonth, nextMonth),
              Divider(
                thickness: 2,
                color: Colors.white.withOpacity(0.3),
              ),
              headerLine(),
              Expanded(child: uranaiList()),
            ],
          ),
        ],
      ),
    );
  }

  ///
  Widget monthLine(
      List<String> exDate, DateTime prevMonth, DateTime nextMonth) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('${exDate[0]}-${exDate[1]}'),
          Row(
            children: <Widget>[
              GestureDetector(
                child: const Icon(Icons.skip_previous),
                onTap: () {
                  _goMonthlyListScreen(date: prevMonth.toString());
                },
              ),
              const SizedBox(width: 20),
              GestureDetector(
                child: const Icon(Icons.skip_next),
                onTap: () {
                  _goMonthlyListScreen(date: nextMonth.toString());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  Widget headerLine() {
    final yearlyUranaiState = _ref.watch(yearlyUranaiProvider(date));

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 10),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: _context,
                  builder: (_) {
                    return YearGraphScreen(data: yearlyUranaiState);
                  },
                );
              },
              child: const Icon(Icons.graphic_eq),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text('Total'),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.topRight,
            child: const Text('Money'),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.topRight,
            child: const Text('Work'),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.topRight,
            child: const Text('Love'),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(right: 10, left: 40),
          child: Container(),
        ),
      ],
    );
  }

  /// リスト表示
  Widget uranaiList() {
    final monthlyUranaiState = _ref.watch(monthlyUranaiProvider(date));

    return ListView.builder(
      padding: MediaQuery.of(_context).padding.copyWith(
        left: 0,
        right: 0,
        top: 10,
        bottom: 50,
      ),
      itemCount: monthlyUranaiState.length,
      itemBuilder: (context, int position) {
        return listItem(data: monthlyUranaiState[position]);
      },
    );
  }

  ///
  Widget listItem({required Datum data}) {
    final exDate = data.date.toString().split(' ');
    final exOneDate = exDate[0].split('-');

    _utility.makeYMDYData(exDate[0], 0);

    return Card(
      color: _utility.getBgColor(exDate[0]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('${exOneDate[2]}（${_utility.youbiStr}）'),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: (int.parse(data.pointTotal) >= 70)
                    ? BoxDecoration(
                  color: Colors.yellowAccent.withOpacity(0.3),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                )
                    : null,
                child: Text(data.pointTotal),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(data.pointMoney),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(data.pointWork),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(data.pointLove),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 10, left: 40),
                child: GestureDetector(
                  onTap: () => _goDetailDisplayScreen(
                    date: exDate[0],
                  ),
                  child: const Icon(
                    Icons.call_made,
                    color: Colors.greenAccent,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: Text(data.titleTotal),
          ),
        ],
      ),
    );
  }

  /////////////////////////////////////////////////////

  ///
  _goMonthlyListScreen({required String date}) {
    Navigator.pushReplacement(
      _context,
      MaterialPageRoute(
        builder: (context) => MonthListScreen(date: date,),
      ),
    );
  }

  ///
  _goDetailDisplayScreen({date}) {
    Navigator.push(
      _context,
      MaterialPageRoute(
        builder: (context) => DetailDisplayScreen(date: date),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////

class YearGraphScreen extends StatelessWidget {
  const YearGraphScreen({Key? key, required this.data}) : super(key: key);

  final List<Datum> data;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: size.width * 10,
          height: size.height - 100,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
          ),
          child: Column(
            children: [_makeGraph(data: data)],
          ),
        ),
      ),
    );
  }

  ///
  Widget _makeGraph({required List<Datum> data}) {
    List<ChartData> list = [];

    for (var i = 0; i < data.length; i++) {
      list.add(
        ChartData(
          x: data[i].date,
          total: num.parse(data[i].pointTotal),
          money: num.parse(data[i].pointMoney),
          work: num.parse(data[i].pointWork),
          love: num.parse(data[i].pointLove),
        ),
      );
    }

    return Expanded(
      child: SfCartesianChart(
        series: <ChartSeries>[
          LineSeries<ChartData, DateTime>(
            color: Colors.greenAccent,
            width: 5,
            dataSource: list,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.total,
          ),
          LineSeries<ChartData, DateTime>(
            color: Colors.yellowAccent,
            width: 3,
            dataSource: list,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.money,
          ),
          LineSeries<ChartData, DateTime>(
            color: Colors.orangeAccent,
            width: 3,
            dataSource: list,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.work,
          ),
          LineSeries<ChartData, DateTime>(
            color: Colors.pinkAccent,
            width: 3,
            dataSource: list,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.love,
          ),
        ],
        primaryXAxis: DateTimeAxis(
          majorGridLines: const MajorGridLines(width: 2, color: Colors.white30),
        ),
        primaryYAxis: NumericAxis(
          majorGridLines: const MajorGridLines(width: 2, color: Colors.white30),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////

class ChartData {
  final DateTime x;
  final num total;
  final num money;
  final num work;
  final num love;

  ChartData({
    required this.x,
    required this.total,
    required this.money,
    required this.work,
    required this.love,
  });
}
