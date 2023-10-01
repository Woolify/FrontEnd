import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woolify/Model/Animal.dart';
import 'package:woolify/Model/ColorList.dart';

class AnimalCategoryWidget extends ConsumerWidget {
  AnimalCategoryWidget(this.data);
  var data;
  Widget build(context, ref) {
    // Map<sheepCategoryList, int> animalList = AnimalData.getAllAnimalsList();
    return Expanded(
        flex: 3,
        child:
            SingleChildScrollView(child: Column(children: getList(context))));
  }

  getList(context) {
    List<Widget> d = [];
    int i = 0;

    if (data['AnimalsData'] != null)
      for (var e in data['AnimalsData']) {
        d.add(Row(
          children: [
            Container(
              width: 7,
              height: 7,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: myColorList[i]),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              e['_id']['type'],
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ));
        i++;
      }
    return d;
  }
}
