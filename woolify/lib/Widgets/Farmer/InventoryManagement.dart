// import 'dart:html';
import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woolify/Model/Animal.dart';
import 'package:woolify/Model/Auction.dart';
import 'package:woolify/Model/Farmer.dart';
import 'package:woolify/Model/Inventory.dart';
import 'package:woolify/Provider/Farmer/FarmerInventoryChart.dart';
import 'package:woolify/Provider/Farmer/FarmerInventoryPage.dart';
import 'package:woolify/ServerRoutes/ApiServicesFarmer.dart';
import 'package:woolify/Widgets/Farmer/AnimalCategory.dart';

import 'package:woolify/Widgets/Farmer/inventoryChart.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:circle_wheel_scroll/circle_wheel_render.dart';
import 'package:circle_wheel_scroll/circle_wheel_scroll_view.dart';
import 'package:woolify/Widgets/Farmer/setPreferenceWidget.dart';
import 'package:woolify/Widgets/ShowDailogLoder.dart';
import 'package:woolify/Widgets/internalErrorDialogbox.dart';

class FarmerIventory extends ConsumerStatefulWidget {
  @override
  ConsumerState<FarmerIventory> createState() {
    return _InventoryManagement();
  }
}

class _InventoryManagement extends ConsumerState<FarmerIventory> {
  int index = -1;
  SingleValueDropDownController listingwoolType =
      SingleValueDropDownController();
  String listingQuntity = '';
  String listingPrice = '';
  String listingdiscription = '';

  final listingForm = GlobalKey<FormState>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });

    super.initState();
  }

  Future getCameraPermission() async {
    final permission = await Permission.camera;
    if (await permission.isDenied || await permission.isPermanentlyDenied) {
      await permission.request();
    }
  }

  void getData() async {
    // data = await ApiServicersFarmer.getInventory();

    ref.read(FamarInventoryPageProvider.notifier).getData();
  }

  @override
  void dispose() {
    colorController.dispose();
    addInventoryBreedType.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  File? image;

  var addInventoryForm = GlobalKey<FormState>();
  final SingleValueDropDownController colorController =
      SingleValueDropDownController();
  final SingleValueDropDownController addInventoryBreedType =
      SingleValueDropDownController();
  String qnty = '';

  var data = null;

  Widget build(contex) {
    data = ref.watch(FamarInventoryPageProvider);
    ref.watch(FamarInventoryCharProvider);

    int curr = -1;
    int i = 0;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : data!['status'] == 'fail'
              ? Center(
                  child: showErrorDailogBox(context),
                )
              : SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      height: size.height * 0.2,
                      child: Stack(
                        children: [
                          Container(
                            height: size.height * 0.16,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(60),
                                    bottomRight: Radius.circular(60))),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: size.width,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100.0)),
                                          elevation: 10,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle),
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.add_business_rounded,
                                                size: 40,
                                              ),
                                              onPressed: () {
                                                openAddToInventory(
                                                    contex, size);
                                              },
                                            ),
                                          ),
                                        ),
                                        Text("Add")
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100.0)),
                                          elevation: 10,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle),
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.remove,
                                                size: 40,
                                              ),
                                              onPressed: () {},
                                            ),
                                          ),
                                        ),
                                        Text("Remove")
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100.0)),
                                          elevation: 10,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle),
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.auto_graph,
                                                size: 40,
                                              ),
                                              onPressed: () {},
                                            ),
                                          ),
                                        ),
                                        Text("Report")
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                                child: Container(
                              width: size.width * 0.4,
                              height: 100,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text("₹ " + "12334",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 35,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                  const Spacer(),
                                  Text(
                                    "Market Prices",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            )),
                            InkWell(
                              onTap: () {
                                image = null;
                                openListInAuction(contex, size);
                              },
                              child: Card(
                                  child: SizedBox(
                                width: size.width * 0.4,
                                height: 100,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Image.asset("assets/farmer/auction.png"),
                                    const Spacer(),
                                    Text(
                                      "Sell Out",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InventoryModel.inventoryStock.isEmpty
                        ? Center(child: Text('Empty Inventory'))
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              elevation: 5,
                              child: Container(
                                height: size.height * 0.52,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(60),
                                              bottomRight:
                                                  Radius.circular(60))),
                                      child: Center(
                                        child: Text(
                                          "INVENTORY",
                                          style: Theme.of(contex)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: size.height * 0.4,
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 50, 8, 8),
                                                child: CircleListScrollView(
                                                  clipToSize: true,
                                                  axis: Axis.vertical,
                                                  itemExtent: 30,
                                                  radius: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6,
                                                  onSelectedItemChanged:
                                                      (int ind) {
                                                    // if (ind != 0)
                                                    ref
                                                        .read(
                                                            FamarInventoryCharProvider
                                                                .notifier)
                                                        .changeIndex(ind);
                                                  },
                                                  children: InventoryModel
                                                      .inventoryStock
                                                      .map((e) {
                                                    curr++;
                                                    return Text(e['typeOfWool'],
                                                        style: ref.read(
                                                                    FamarInventoryCharProvider) ==
                                                                curr
                                                            ? Theme.of(contex)
                                                                .textTheme
                                                                .headlineSmall!
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)
                                                            : Theme.of(contex)
                                                                .textTheme
                                                                .bodyLarge);
                                                  }).toList(),
                                                ),
                                              )),
                                          Expanded(
                                              flex: 4,
                                              child: FarmerInventoryChart()),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ]),
                ),
    );
  }

  openAddToInventory(BuildContext context, Size size) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 10,
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: Form(
              key: addInventoryForm,
              child: SizedBox(
                width: size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: size.width,
                      height: 90,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(60),
                              bottomRight: Radius.circular(60))),
                      child: Center(
                        child: Text(
                          "Enhance our stock with a simple click",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      "assets/farmer/inventory (1).png",
                      height: size.height * 0.2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("Animal Type "),
                            Theme(
                              data: ThemeData(),
                              child: DropDownTextField(
                                  validator: (v) {
                                    print(v);
                                    if (v == null || v.isEmpty) {
                                      return "Select Animal Type";
                                    }
                                    return null;
                                  },
                                  controller: colorController,
                                  dropDownList: woolColor.values
                                      .map((e) => DropDownValueModel(
                                          name: e.name, value: e.name))
                                      .toList()),
                            )
                          ],
                        )),
                    Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("Wool Type "),
                            Theme(
                              data: ThemeData(),
                              child: DropDownTextField(
                                  validator: (v) {
                                    if (v == null || v.isEmpty) {
                                      return "Select Breed Type";
                                    }
                                    return null;
                                  },
                                  controller: addInventoryBreedType,
                                  dropDownList: sheepCategoryList.values
                                      .map((e) => DropDownValueModel(
                                          name: e.name, value: e.name))
                                      .toList()),
                            )
                          ],
                        )),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("Quntity "),
                              Theme(
                                data: ThemeData(),
                                child: TextFormField(
                                  onSaved: (val) {
                                    qnty = val!;
                                  },
                                  keyboardType: TextInputType.number,
                                  validator: (v) {
                                    if (v == null || v.isEmpty) {
                                      return "Please Enter Quntity";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          const Expanded(
                              child: DropDownTextField(
                            initialValue: "Select Qnty",
                            padding: EdgeInsets.all(8),
                            dropDownList: [
                              DropDownValueModel(name: "Kg", value: "Kg"),
                              DropDownValueModel(name: "Ton", value: "Ton"),
                            ],
                          )),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 245, 102, 92)),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (addInventoryForm.currentState!.validate()) {
                                addInventoryForm.currentState!.save();
                                InventoryModel model = InventoryModel(
                                    inventoryId: '',
                                    color: colorController.dropDownValue!.name,
                                    typeOfWool: addInventoryBreedType
                                        .dropDownValue!.name,
                                    quantity: qnty);
                                showDailogLoder(context: context, size: size);
                                var res =
                                    await ApiServicersFarmer.addToInventory(
                                        model);
                                Navigator.of(context).pop();

                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).clearSnackBars();
                                if (res['status'] == 'success') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.green,
                                          content: const Text(
                                              "Produce Added in inventory")));

                                  ref
                                      .read(FamarInventoryPageProvider.notifier)
                                      .setDataTonull();
                                  ref
                                      .read(FamarInventoryPageProvider.notifier)
                                      .getData();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.red,
                                          content: const Text(
                                              "Some Internal Error Occured ")));
                                }
                              }
                            },
                            child: Text("Submit")),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  openListInAuction(BuildContext context, Size size) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: SingleChildScrollView(
                  child: Form(
                key: listingForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width,
                      height: 90,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(60),
                              bottomRight: Radius.circular(60))),
                      child: Center(
                        child: Text(
                          "Put Your Finest Wool on the Bidding Floor, Where Every Thread Tells a Tale!",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset("assets/farmer/auction3.png"),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Wool Type",
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Theme(
                        data: ThemeData(),
                        child: DropDownTextField(
                            controller: listingwoolType,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'select wool type';
                              }
                              return null;
                            },
                            dropDownList: getDropDownValueModelList()),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("Quntity "),
                              Theme(
                                data: ThemeData(),
                                child: TextFormField(
                                  onSaved: (val) {
                                    listingQuntity = val!;
                                  },
                                  keyboardType: TextInputType.number,
                                  validator: (v) {
                                    if (v == null || v.isEmpty) {
                                      return "Please Enter Quntity";
                                    }
                                    for (var e
                                        in InventoryModel.inventoryStock) {
                                      if (e['typeOfWool'] ==
                                          listingwoolType.dropDownValue!.name) {
                                        if (double.parse(v) >
                                            e['totalQuantity']) {
                                          return "only ${e['totalQuantity']}kg available in Inventory";
                                        }
                                      }
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          const Expanded(
                              child: DropDownTextField(
                            initialValue: "Select Qnty",
                            padding: EdgeInsets.all(8),
                            dropDownList: [
                              DropDownValueModel(name: "Kg", value: "Kg"),
                              DropDownValueModel(name: "Ton", value: "Ton"),
                            ],
                          )),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("Price ₹"),
                              Theme(
                                data: ThemeData(),
                                child: TextFormField(
                                  onSaved: (val) {
                                    listingPrice = val!;
                                  },
                                  keyboardType: TextInputType.number,
                                  validator: (v) {
                                    if (v == null || v.isEmpty) {
                                      return "Please Enter Price";
                                    }

                                    return null;
                                  },
                                ),
                              ),
                            ],
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Card(
                              child: Container(
                            width: size.width * 0.4,
                            height: 80,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("₹ " + "12334",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                const Spacer(),
                                Text(
                                  "Market Prices",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Discription"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Theme(
                          data: ThemeData(),
                          child: TextFormField(
                            onSaved: ((newValue) {
                              listingdiscription = newValue!;
                            }),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        // height: 100,
                        child: image == null
                            ? ElevatedButton(
                                onPressed: () async {
                                  await getCameraPermission();
                                  try {
                                    final imag = await ImagePicker()
                                        .pickImage(source: ImageSource.camera);
                                    developer.log("ima is" + imag.toString());
                                    if (imag == null) return;
                                    final imgTemp = File(imag.path);
                                    setState(() {
                                      image = imgTemp;
                                    });
                                  } catch (e) {
                                    developer.log(e.toString(),
                                        name: "camaera acces");
                                  }
                                },
                                child: Text("Select Image"))
                            : ListTile(
                                title: Text("Image Seleced"),
                                trailing: IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () async {
                                    try {
                                      final image = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.camera);
                                      developer.log(
                                          "imahe is :  " + image.toString());
                                      if (image == null) return;
                                      final imgTemp = File(image.path);
                                      setState(() {
                                        this.image = imgTemp;
                                      });
                                    } catch (e) {
                                      developer.log(e.toString(),
                                          name: "camaera acces");
                                    }
                                  },
                                ),
                                leading: CircleAvatar(
                                    backgroundImage: FileImage(image!)),
                              )),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Set Preference"),
                    ),
                    Container(
                      child: SetPreference(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              if (listingForm.currentState!.validate()) {
                                if (image == null) return;
                                listingForm.currentState!.save();
                                AuctionModel model = AuctionModel(
                                    basePrice: listingPrice,
                                    quantity: listingQuntity,
                                    typeOfWool:
                                        listingwoolType.dropDownValue!.name,
                                    descp: listingdiscription);
                                showDailogLoder(context: context, size: size);
                                Map<String, dynamic> res =
                                    await ApiServicersFarmer.raiseAuction(
                                        model, image!);
                                image = null;
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                if (res['status'] == 'success') {
                                  ref
                                      .read(FamarInventoryPageProvider.notifier)
                                      .getData();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text(
                                              "Auction Is Now Open For Bidding")));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text(
                                              "Vendors NearBy will be Notified soon 😀")));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Some Internal Error Occured")));
                                }
                              }
                            },
                            child: Text("Auction !")),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 212, 96, 88)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("cancel"))
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )),
            );
          });
        }).onError((error, stackTrace) {
      developer.log(error.toString(), name: "showDailog Box");
    });
  }

  List<DropDownValueModel> getDropDownValueModelList() {
    List<DropDownValueModel> data = [];
    for (var e in InventoryModel.inventoryStock) {
      if (e['typeOfWool'] != 'All') {
        data.add(
            DropDownValueModel(name: e['typeOfWool'], value: e['typeOfWool']));
      }
    }
    return data;
  }
}
