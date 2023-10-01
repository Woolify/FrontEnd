import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetPreference extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SetPrefence();
  }
}

class _SetPrefence extends State<SetPreference> {
  bool search = false;
  String searchText = "";
  FocusNode focusNode = FocusNode();
  List<String> preferenceIds = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.addListener(() {
        if (focusNode.hasFocus) {
          setState(() {
            search = true;
          });
        } else if (!focusNode.hasFocus) {
          setState(() {
            search = false;
          });
        }
      });
    });
    // TODO: implement initState
    super.initState();
  }

  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Theme(
            data: ThemeData(),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              focusNode: focusNode,
              onTap: () {
                setState(() {
                  search = true;
                });
              },
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              )),
            ),
          ),
        ),
        focusNode.hasFocus
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // color: Colors.amber,
                  height: 300,
                  width: size.width,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemBuilder: ((context, index) {
                        return const ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/farmer/inventory.png"),
                          ),
                          title: Text("jjjjj"),
                        );
                      })),
                ),
              )
            : preferenceIds.isEmpty
                ? const SizedBox()
                : Card(
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      width: size.width,
                      height: 40,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: preferenceIds.length,
                          itemBuilder: ((context, index) {
                            return Card(
                              color: Colors.amber,
                              child: Stack(
                                children: [
                                  Center(
                                      child: Container(
                                          height: 80,
                                          width: 140,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              preferenceIds[index],
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))),
                                  Positioned(
                                      right: -16,
                                      bottom: 0,
                                      child: Align(
                                        // alignment: Alignment.topRight,
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            CupertinoIcons.clear_circled_solid,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            size: 15,
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            );
                          })),
                    ),
                  ),
      ],
    );
  }
}
