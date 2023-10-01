import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woolify/Model/Animal.dart';
import 'package:woolify/Model/ColorList.dart';
import 'package:woolify/Model/Inventory.dart';
import 'package:woolify/Provider/Farmer/FarmerInventoryChart.dart';

import 'AnimalCategory.dart';

class FarmerInventoryChart extends ConsumerStatefulWidget {
  @override
  ConsumerState<FarmerInventoryChart> createState() {
    return _FarmerInventoryChart();
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _FarmerInventoryChart extends ConsumerState<FarmerInventoryChart> {
  // int index = -1;
  int curIndex = -1;
  Widget build(context) {
    curIndex = ref.read(FamarInventoryCharProvider);
    ref.watch(FamarInventoryCharProvider);
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primaryContainer,
            boxShadow: [
              const BoxShadow(
                  spreadRadius: -10,
                  blurRadius: 30,
                  offset: Offset(
                    -5,
                    -5,
                  ),
                  color: Colors.white),
              BoxShadow(
                spreadRadius: -10,
                blurRadius: 17,
                offset: const Offset(
                  7,
                  7,
                ),
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ]),
        child: Stack(children: [
          Center(
            child: Container(
              width: constraints.maxWidth,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: PieChart(PieChartData(
                    centerSpaceRadius: 50,
                    sectionsSpace: 0,
                    borderData: FlBorderData(show: false),
                    sections: getSection())),
              ),
            ),
          ),
          Center(
            child: Container(
              height: constraints.maxHeight * 0.26,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                  boxShadow: [
                    const BoxShadow(
                        blurRadius: 1,
                        offset: Offset(-1, -1),
                        color: Colors.white),
                    BoxShadow(
                        spreadRadius: -2,
                        blurRadius: 17,
                        offset: Offset(5, 5),
                        color: Colors.black.withOpacity(0.5))
                  ]),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        InventoryModel.inventoryStock[curIndex]['totalQuantity']
                            .toStringAsFixed(2),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold)),
                    Text("Kg",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  List<PieChartSectionData> getSection() {
    int num = 0;

    List<PieChartSectionData> data = [];
    for (Map<String, dynamic> element in InventoryModel.inventoryStock) {
      if (element['typeOfWool'] != 'All') {
        data.add(PieChartSectionData(
            value: element['totalQuantity'].toDouble(),
            color: myColorList[num],
            radius: num == curIndex ? 85 : 55));
      }
      num++;
    }
    return data;
  }
}
