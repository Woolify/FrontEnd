// import 'dart:ffi';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:woolify/Model/Animal.dart';
import 'package:woolify/Model/filters.dart';

class MarketPlaceDrawer extends StatefulWidget {
  @override
  State<MarketPlaceDrawer> createState() => _MarketPlaceDrawerState();
}

class _MarketPlaceDrawerState extends State<MarketPlaceDrawer> {
  Widget build(
    context,
  ) {
    // print(myFilters.filtesList[0]['GaddiSheep']);
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.3),
                Theme.of(context).colorScheme.primary.withOpacity(0.8)
              ],
            )),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          DrawerHeader(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    Theme.of(context).colorScheme.primary.withOpacity(0.8)
                  ],
                )),
            child: const Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/farmer/placeholder.png"),
                  radius: 50,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("User Name")
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.zero)),
                    child: Container(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Filters",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const Spacer(),
                              const Text('Unchek All'),
                              Checkbox(value: true, onChanged: (v) {})
                            ],
                          ),
                        ))),
                Card(
                  margin: EdgeInsets.all(0),
                  child: Container(
                    height: 300,
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          String name = '';
                          bool val = false;
                          myFilters.filtesList[index].entries.forEach((entry) {
                            name = entry.key;
                            val = entry.value;

                            // Now you can use 'key' and 'value' as needed
                            // print('Key: $name, Value: $val');
                          });

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(name),
                              trailing: Checkbox(
                                // checkColor: Colors.amber,
                                // activeColor: Colors.white,
                                onChanged: (v) {
                                  if (myFilters.filtesList[index][name] ==
                                      true) {
                                    myFilters.filtesList[index][name] = false;
                                  } else {
                                    myFilters.filtesList[index][name] = true;
                                  }
                                  setState(() {});
                                },
                                value: val,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: myFilters.filtesList.length),
                  ),
                ),
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.zero)),
                    child: Container(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Location",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ))),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
