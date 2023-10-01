import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:woolify/Router/NamedRoutes.dart';
import 'package:woolify/ServerRoutes/ApiServicesFarmer.dart';
import 'package:woolify/Widgets/ShowDailogLoder.dart';

class ShowShipData extends StatefulWidget {
  const ShowShipData({super.key, required this.data});
  final data;

  @override
  State<ShowShipData> createState() => _ShowShipDataState();
}

class _ShowShipDataState extends State<ShowShipData> {
  var data;

  String url = '';
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getData();
      // do something
    });

    // TODO: implement initState
    super.initState();
  }

  void getData() async {
    data = null;
    var res = await ApiServicersFarmer.getAnimalData(widget.data['url']);
    setState(() {
      print(data);
      this.data = res['data'];
      url = res['url'];
    });
  }

  Widget build(context) {
    print("SSSSs  $data");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text("Animal data"),
        centerTitle: true,
      ),
      body: data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: CircleAvatar(
                          radius: 70,
                          child: Icon(
                            Icons.qr_code_2,
                            size: 80,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        "NickName",
                        textAlign: TextAlign.center,
                      ),
                      Theme(
                          data: ThemeData(),
                          child: TextFormField(
                            initialValue: data['nickName'].toString(),
                            readOnly: true,
                            decoration: const InputDecoration(),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Age *",
                        textAlign: TextAlign.center,
                      ),
                      Theme(
                          data: ThemeData(),
                          child: TextFormField(
                            initialValue: data['animal']['age'].toString(),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value!.trim().isEmpty) {
                                return "please Enter age";
                              } else if (int.parse(value) == 0) {
                                return "Age cannot be zero";
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Weight *",
                        textAlign: TextAlign.center,
                      ),
                      Theme(
                          data: ThemeData(),
                          child: TextFormField(
                            initialValue: data['animal']['wieght'].toString(),
                            keyboardType: TextInputType.number,
                            readOnly: true,
                            decoration: const InputDecoration(),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Type *",
                        textAlign: TextAlign.center,
                      ),
                      Theme(
                        data: ThemeData(),
                        child: TextFormField(
                          initialValue: data['animal']['type'].toString(),
                          readOnly: true,
                          decoration: const InputDecoration(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Breed *",
                        textAlign: TextAlign.center,
                      ),
                      Theme(
                        data: ThemeData(),
                        child: Theme(
                          data: ThemeData(),
                          child: TextFormField(
                            initialValue: data['animal']['breed'].toString(),
                            readOnly: true,
                            decoration: const InputDecoration(
                                label: Text("Select Animal Type")),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Last Shreed Date *",
                        textAlign: TextAlign.center,
                      ),
                      Theme(
                          data: ThemeData(),
                          child: TextFormField(
                            initialValue:
                                data['animal']['lastShread'].toString(),
                            readOnly: true,
                            keyboardType: TextInputType.datetime,
                            decoration: const InputDecoration(),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Discription ",
                        textAlign: TextAlign.center,
                      ),
                      Theme(
                          data: ThemeData(),
                          child: TextFormField(
                            initialValue: data['animal']['descp'].toString(),
                            maxLines: 2,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return null;
                            },
                            decoration: const InputDecoration(),
                          )),
                      Center(
                          child: ElevatedButton(
                              onPressed: () async {
                                GoRouter.of(context).pushNamed(
                                    FarmerRoutes.updateAnimalData,
                                    pathParameters: {
                                      "data": jsonEncode(widget.data)
                                    }).then((value) {
                                  getData();
                                });
                              },
                              child: Text("Update"))),
                      Center(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(
                                    255, 207, 79, 70), // Background color
                              ),
                              onPressed: () async {
                                showDailogLoder(context: context, size: size);
                                var res =
                                    await ApiServicersFarmer.deleteAnimal(url);
                                Navigator.of(context).pop();
                                if (res['status'] == 'success') {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Animal Deleted SuccessFull!")));
                                }
                                Navigator.of(context).pop();
                              },
                              child: Text("Delete"))),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
