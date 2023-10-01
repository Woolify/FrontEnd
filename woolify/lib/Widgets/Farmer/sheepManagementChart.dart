import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woolify/Model/ColorList.dart';
import 'package:woolify/Provider/Farmer/animalChartData.dart';
import 'package:woolify/Widgets/Farmer/AnimalCategory.dart';

class SheepManagementChart extends ConsumerStatefulWidget {
  const SheepManagementChart(this.data);
  final data;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SheepManagementChartState();
    throw UnimplementedError();
  }
}

class _SheepManagementChartState extends ConsumerState<SheepManagementChart> {
  late Map data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int i = 0;

  Widget build(context) {
    return PieChart(PieChartData(
        centerSpaceRadius: 50,
        sectionsSpace: 0,
        borderData: FlBorderData(show: false),
        sections: getSection()));
  }

  getSection() {
    var data = widget.data;
    List<PieChartSectionData> list = [];

    if (data.isNotEmpty) {
      int i = 0;
      for (var e in data['AnimalsData']) {
        list.add(PieChartSectionData(
          color: myColorList[i],
          value: e['numberOfSheeps'].toDouble(),
          radius: 30,
        ));
        i++;
      }
    }
    return list;
  }
}
