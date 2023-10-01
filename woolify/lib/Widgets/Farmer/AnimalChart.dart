import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woolify/Model/Animal.dart';
import 'package:woolify/Provider/Farmer/animalChartData.dart';
import 'package:woolify/Widgets/Farmer/sheepManagementChart.dart';

import 'AnimalCategory.dart';

class AnimalChart extends ConsumerStatefulWidget {
  const AnimalChart(this.data);
  final data;
  @override
  ConsumerState<AnimalChart> createState() {
    return _AnimalChartState();
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _AnimalChartState extends ConsumerState<AnimalChart> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(
    context,
  ) {
    return Expanded(
      flex: 4,
      child: LayoutBuilder(
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
              child: SizedBox(
                width: constraints.maxWidth * 0.6,
                child: GestureDetector(
                  onTapUp: (details) {},
                  child: SheepManagementChart(widget.data),
                ),
              ),
            ),
            Center(
              child: Container(
                height: constraints.maxHeight * 0.4,
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
                          blurRadius: 10,
                          offset: Offset(5, 5),
                          color: Colors.black.withOpacity(0.5))
                    ]),
                child: Center(
                  child: Text(
                    '',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

// class PieChart extends CustomPainter {
//   PieChart({required this.width});
//   final double width;

//   @override
//   void paint(Canvas canvas, Size size) {
//     Offset center = Offset(size.width / 2, size.height / 2);
//     double radius = min(size.width / 2, size.height / 2);
//     var paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = width / 2;
//     double total = AnimalData.totalAnimals().toDouble();
//     print(total);
//     double startRadian = -pi / 2;
//     AnimalData.getAllAnimalsList().forEach((key, value) {
//       print(value);
//       final sweepradian = value / total * 2 * pi;
//       paint.color = AnimalData.colorSchemeForAnimals[key]!;
//       canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
//           startRadian, sweepradian, false, paint);
//       startRadian += sweepradian;
//     });
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     // TODO: implement shouldRepaint
//     return true;
//   }
// }
