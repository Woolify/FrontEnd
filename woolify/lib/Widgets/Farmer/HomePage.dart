import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:woolify/Model/chartData.dart';
import 'package:woolify/SharedPreference.dart';
import 'dart:developer' as dev;

class FarmerMainPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _FarmerHomePage();
  }
}

class _FarmerHomePage extends ConsumerState {
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            icon: Icon(Icons.login),
            onPressed: () {
              mySharedPreference.pref.clear();
              GoRouter.of(context).pushReplacement("/");
            })
      ], title: Text("Farmer")),
      body: Column(
        children: [
          Container(
            height: 300,
            child: LineChart(LineChartData(lineBarsData: [
              LineChartBarData(
                  show: true,
                  color: Colors.amber,
                  isCurved: true,
                  dotData: FlDotData(show: true),
                  spots: getList())
            ])),
          )
        ],
      ),
    );
  }

  List<FlSpot> getList() {
    int i = 0;
    List<FlSpot> data = [];

    List<Map<String, dynamic>> data1 = calculateMonthlyAverages();
    for (var e in data1) {
      DateTime date = DateFormat('yyyy-MM').parse(e['month']);
      data.add(FlSpot(date.millisecondsSinceEpoch.toDouble(),
          e['average'].toInt().toDouble()));
    }

    return data;
  }
}
