import 'dart:convert';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:woolify/Model/Animal.dart';
import 'package:woolify/ServerRoutes/ApiServicesFarmer.dart';
import 'dart:developer' as dev;
import 'package:woolify/Widgets/ShowDailogLoder.dart';

class UpdateShipData extends StatefulWidget {
  UpdateShipData({super.key, required this.data});
  final data;

  @override
  State<UpdateShipData> createState() => _UpdateShipDataState();
}

class _UpdateShipDataState extends State<UpdateShipData> {
  late bool previousData = false;
  String nickName = '', age = '', weight = '', date = '', discription = '';
  DateTime selectedDate = DateTime.now();
  late var data;
  final SingleValueDropDownController type = SingleValueDropDownController();

  final SingleValueDropDownController breed = SingleValueDropDownController();
  final TextEditingController lastShreedDate = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.data is String) {
      data = jsonDecode(widget.data);
    } else {
      data = widget.data;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // if (data['animal']['saveAsDraft'] == false) {
      //   setState(() {
      //     type.setDropDown(DropDownValueModel(
      //         name: data['animal']['type'].toString(),
      //         value: data['animal']['type'].toString()));
      //     breed.setDropDown(DropDownValueModel(
      //         name: data['animal']['breed'].toString(),
      //         value: data['animal']['breed'].toString()));
      //     previousData = true;
      //   });
      // }
      print("Build Completed");
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    type.dispose();
    breed.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text("Update Animal data"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                        initialValue: previousData == true
                            ? data['animal']['nickName'].toString()
                            : null,
                        onSaved: (newValue) {
                          nickName = newValue!;
                        },
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
                        initialValue: previousData == true
                            ? data['animal']['age'].toString()
                            : null,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
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
                        initialValue: previousData == true
                            ? data['animal']['weight'].toString()
                            : null,
                        keyboardType: TextInputType.number,
                        onSaved: ((newValue) {
                          weight = newValue.toString();
                        }),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "please Enter age";
                          } else if (double.parse(value) < 1) {
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
                    "Type *",
                    textAlign: TextAlign.center,
                  ),
                  Theme(
                    data: ThemeData(),
                    child: DropDownTextField(
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return "Please select type";
                          }
                          return null;
                        }),
                        controller: type,
                        textFieldDecoration: const InputDecoration(
                            label: Text("Select Animal Type")),
                        dropDownList: sheepCategoryList.values
                            .map((e) =>
                                DropDownValueModel(name: e.name, value: e.name))
                            .toList()),
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
                    child: DropDownTextField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please select breed";
                          }
                          return null;
                        },
                        controller: breed,
                        textFieldDecoration:
                            const InputDecoration(label: Text("Select Breed")),
                        dropDownList: sheepCategoryList.values
                            .map((e) =>
                                DropDownValueModel(name: e.name, value: e.name))
                            .toList()),
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
                        controller: lastShreedDate,
                        initialValue: previousData == true
                            ? data['animal']['date'].toString()
                            : null,
                        readOnly: true,
                        onTap: () async {
                          await _selectDate(context);
                        },
                        keyboardType: TextInputType.datetime,
                        onSaved: ((newValue) {
                          date = newValue.toString();
                        }),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "please Enter Date";
                          }

                          return null;
                        },
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
                        initialValue: previousData == true
                            ? data['animal']['descp'].toString()
                            : null,
                        maxLines: 2,
                        keyboardType: TextInputType.text,
                        onSaved: ((newValue) {
                          discription = newValue.toString();
                        }),
                        validator: (value) {
                          return null;
                        },
                        decoration: const InputDecoration(),
                      )),
                  Center(
                      child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              showDailogLoder(context: context, size: size);
                              dev.log(widget.data.toString());
                              var res =
                                  await ApiServicersFarmer.updateAnimalDetails(
                                      data['url'],
                                      AnimalData(
                                          nickName: nickName,
                                          age: age,
                                          weight: weight,
                                          lastShread: date,
                                          descp: discription,
                                          breed: breed.dropDownValue!.value,
                                          type: type.dropDownValue!.value));
                              Navigator.of(context).pop();

                              ScaffoldMessenger.of(context).clearSnackBars();
                              if (res['status'] == 'success') {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text("Animal Data Updated!")));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                            "Some Internal Error Occured!")));
                              }
                            }
                          },
                          child: Text("Submit")))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');

      setState(() {
        selectedDate = picked;
        lastShreedDate.text = formatter.format(selectedDate);
      });
    }
  }
}
