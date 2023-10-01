import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:woolify/Provider/Farmer/animalChartData.dart';
import 'package:woolify/Router/NamedRoutes.dart';
import 'package:woolify/ServerRoutes/ApiServicesFarmer.dart';
import 'package:woolify/Widgets/Farmer/AnimalCategory.dart';
import 'package:woolify/Widgets/Farmer/AnimalChart.dart';
import 'package:woolify/Widgets/ShowDailogLoder.dart';

class ManageSheep extends ConsumerStatefulWidget {
  const ManageSheep({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ManageSheep();
  }
}

class _ManageSheep extends ConsumerState<ManageSheep> {
  var data;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
      print("Build Completed");
    });
    super.initState();
  }

  void getData() async {
    data = await ApiServicersFarmer.getAllAnimalData();
    setState(() {
      this.data = data;
    });
  }

  TextEditingController countController = TextEditingController();
  String count = '';
  bool _validate = false;
  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.primary,
      body: data == null
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SafeArea(
                    child: Card(
                      // color: Theme.of(context).colorScheme.primary,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50))),
                      // color: Theme.of(context).colorScheme.inversePrimary,
                      // elevation: 2,
                      child: Container(
                        width: size.width,
                        height: size.height * 0.425,
                        decoration: const BoxDecoration(
                          // color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    icon: const Icon(Icons.arrow_back),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }),
                                Center(
                                  child: Text(
                                    "Sheep",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.notifications))
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Card(
                                margin: EdgeInsets.all(8),
                                elevation: 10,
                                child: SizedBox(
                                  width: size.width * 1,
                                  height: size.height * 0.3,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 10, 0, 10),
                                                  child: Text(
                                                    "Sheeps",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall,
                                                  ),
                                                ),
                                                AnimalCategoryWidget(data),
                                              ],
                                            ),
                                          ),
                                          AnimalChart(data),
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
                  sliver: SliverToBoxAdapter(
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(60),
                      )),
                      elevation: 5,
                      child: Container(
                        width: size.height * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LayoutBuilder(builder: (context, constrain) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: (() {
                                    GoRouter.of(context).pushNamed(
                                        FarmerRoutes.farmerQRPDFList);
                                  }),
                                  child: Card(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                    child: SizedBox(
                                      width: constrain.maxWidth * 0.4,
                                      child: Column(
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.qr_code,
                                              size: 30,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Pending QR',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  child: SizedBox(
                                    width: constrain.maxWidth * 0.4,
                                    child: Column(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.qr_code),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'QR Files',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(8, 2, 16, 10),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 3,
                      mainAxisExtent: 265,
                      crossAxisSpacing: 0,
                    ),
                    delegate: SliverChildListDelegate([
                      InkWell(
                        onTap: (() {
                          print("object");
                          _showBottomModal(context, size);
                        }),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 10,
                            // color: Theme.of(context).colorScheme.inversePrimary,
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/farmer/addShip.png",
                                  height: size.height * 0.22,
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                    child: Text(
                                      "Add Sheeps",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (() {
                            GoRouter.of(context).pushNamed(FarmerRoutes.scanQr);
                          }),
                          child: Card(
                            elevation: 10,
                            // color: Theme.of(context).colorScheme.inversePrimary,
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/farmer/qr.png",
                                  height: size.height * 0.22,
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                    child: Text(
                                      "Scan QR",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 10,
                          // color: Theme.of(context).colorScheme.inversePrimary,
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/farmer/update.png",
                                height: size.height * 0.22,
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: Text(
                                    "Update",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 10,
                          // color: Theme.of(context).colorScheme.inversePrimary,
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/farmer/Freports.png",
                                height: size.height * 0.22,
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: Text(
                                    "Report",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ),
                      )
                    ]),
                  ),
                )
              ],
            ),
    );
  }

  _showBottomModal(context, Size size) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        useSafeArea: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(60)),
        ),
        context: context,
        showDragHandle: true,
        // backgroundColor: Colors.transparent,
        builder: (builder) {
          return StatefulBuilder(builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                      child: Lottie.asset("assets/farmer/qr.json",
                          height: size.height * 0.25)),
                  Text(
                    "Eneter the Number Of QR to be Generated for each animals",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 20),
                    child: TextFormField(
                      controller: countController,
                      keyboardType: TextInputType.phone,
                      onChanged: (newValue) {
                        setState(() {
                          _validate = false;
                        });
                      },
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35.0),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35)),
                          prefixIcon: const Icon(Icons.qr_code_2),
                          errorText: _validate ? "Value Can't Be Empty'" : null,
                          hintText: "Number of animals in farm"),
                      validator: (value) {
                        if (value != null) {
                          if (value.isNotEmpty) {
                            count = value;
                            return null;
                          } else {
                            return "Invalid Username";
                          }
                        } else {
                          return "username cannot be empty";
                        }
                      },
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (countController.text.trim().isNotEmpty) {
                          showDailogLoder(context: context, size: size);

                          Map<String, dynamic> res =
                              await ApiServicersFarmer.generateNewQRs(
                                  count: countController.text);
                          Navigator.of(context).pop();
                          print(res);
                          if (res['status'] == 'success') {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                    "OR generated Successfull !Please check the File in ORFiles")));
                          } else {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("Some Internal Erro occurred")));
                          }
                        } else {
                          setState(() {
                            _validate = true;
                          });
                        }
                      },
                      child: Text("Submit"))
                ],
              ),
            );
          });
        });
  }
}
