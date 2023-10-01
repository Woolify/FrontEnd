import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:developer' as developer;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:woolify/Pages/vendor/VendorBiddingPage.dart';
import 'package:woolify/Provider/Vendor/AuctionProvider.dart';
import 'package:woolify/Provider/Vendor/ProductPage.dart';
import 'package:woolify/Router/NamedRoutes.dart';
import 'package:woolify/ServerRoutes/ApiServicesVendro.dart';
import 'package:woolify/ServerRoutes/ServerDetails.dart';
import 'package:woolify/Widgets/ShowDailogLoder.dart';
import 'package:woolify/Widgets/buttonRow1.dart';

class ProductPage extends ConsumerStatefulWidget {
  const ProductPage({super.key, required this.data});
  final data;

  @override
  ConsumerState<ProductPage> createState() {
    return _ProductPage();
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _ProductPage extends ConsumerState<ProductPage> {
  var data;
  @override
  void initState() {
    // developer.log(data.toString(), name: "on productPAge");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      data = jsonDecode(widget.data);
      ref.read(VendorProductPageProvider.notifier).setData(data);
    });
    // developer.log(data.containsKey('isAlreadyBidded').toString(), name: "");

    // TODO: implement initState
    super.initState();
  }

  String amount = '';
  String discripTion = '';
  final formKey = GlobalKey<FormState>();

  Widget build(context) {
    data = ref.watch(VendorProductPageProvider);
    late var higestBid;
    if (data != null && data.isNotEmpty) {
      if (data.containsKey('highestBidDocument')) {
        higestBid = data['highestBidDocument']['offeredPrice'];
      } else
        higestBid = data['basePrice'];
    }
    Size size = MediaQuery.of(context).size;
    return data == null || data.isEmpty
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: Theme.of(context).colorScheme.primary,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Theme.of(context).colorScheme.onPrimary,
                onPressed: (() {
                  Navigator.of(context).pop();
                }),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Text("ShahaBadi",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      )),
              centerTitle: true,
            ),
            body: SafeArea(
              child: SizedBox(
                height: size.height,
                child: SingleChildScrollView(
                  child: Stack(children: [
                    Container(
                      height: 1068,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(data['woolImg']
                                  .toString()
                                  .replaceAll('localhost', ServerDetails.ip)))),
                      height: size.height * 0.6,
                    ),
                    Positioned(
                      top: 300,
                      // bottom: 0,
                      child: Card(
                        margin: const EdgeInsets.all(0),
                        // color: Colors.amber,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(60),
                                topRight: Radius.circular(60))),
                        child: Container(
                          // color: Colors.amber,
                          // height: 500,
                          width: size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  color: Theme.of(context).colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: size.width * 0.6,
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Spacer(),
                                            Text(
                                              "₹ ${data['basePrice']}/kg",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary),
                                            ),
                                            Spacer(),
                                            Card(
                                              child: IconButton(
                                                  onPressed: () {
                                                    addBid(context, size);
                                                  },
                                                  icon: Image.asset(
                                                    "assets/farmer/auction.png",
                                                    scale: 1.4,
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                // height: 220,
                                child: Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.document_scanner,
                                              size: 150,
                                            ),
                                            Text(
                                              "Details",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 24, 8, 8),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2.0,
                                                        horizontal: 8),
                                                child: Row(
                                                  children: [
                                                    // Icon(Icons.monitor_weight_sharp),
                                                    Expanded(
                                                      child: Text(
                                                        "Quantity:",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "${data['inventory']['quantity']} kg",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2.0,
                                                        horizontal: 8),
                                                child: Row(
                                                  children: [
                                                    // Icon(Icons.monitor_weight_sharp),
                                                    Text(
                                                      "Location:",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge,
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "Amravati(100 km)",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2.0,
                                                        horizontal: 8),
                                                child: Row(
                                                  children: [
                                                    // Icon(Icons.monitor_weight_sharp),
                                                    Text(
                                                      "Quality ",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Noice",
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2.0,
                                                        horizontal: 8),
                                                child: Row(
                                                  children: [
                                                    // Icon(Icons.monitor_weight_sharp),
                                                    Text(
                                                      "color:",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "${data['inventory']['color']} ",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ]),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 24.0, horizontal: 8),
                                child: Theme(
                                  data: ThemeData(),
                                  child: TextFormField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                          // fillColor: Colors.amber,
                                          disabledBorder: InputBorder.none),
                                      minLines: 1,
                                      maxLines: 3,
                                      initialValue:
                                          "Sai is a Good Boi he " * 30),
                                ),
                              ),
                              buttonRow(
                                basePrice: data['basePrice'].toString(),
                                HigestBid: higestBid.toString(),
                                marketPrice: '112',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(),
                              ListTile(
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.navigate_next),
                                ),
                                leading: CircleAvatar(radius: 50),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Gaurav Pawar"),
                                    Text(
                                      "farmer detail",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    Icon(Icons.star),
                                    Icon(Icons.star),
                                    Icon(Icons.star),
                                    Icon(Icons.star)
                                  ],
                                ),
                              ),
                              Divider(),
                              ListTile(
                                  leading: SizedBox(
                                    width: 100,
                                    child: Image.asset(
                                        'assets/vendor/delivery-truck.png'),
                                  ),
                                  title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Approx Dilivery Date:"),
                                        Text(
                                          "12/33/2023",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ]),
                                  trailing: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.navigate_next),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ),
          );
  }

  void addBid(BuildContext context, Size size) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 00, 0, 8),
              child: Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                            "Raise a Bid",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                          ),
                        ),
                      ),
                      Center(
                        child: Lottie.asset(
                          "assets/vendor/bid.json",
                          height: 150,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Enter Bid Amount"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Theme(
                            data: ThemeData(),
                            child: TextFormField(
                              onSaved: ((newValue) {
                                amount = newValue!;
                              }),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value!.isEmpty) {
                                  return "Amount cannot Be Empty";
                                }
                                return null;
                              },
                              decoration: InputDecoration(hintText: "₹ 123"),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Enter Discription"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Theme(
                            data: ThemeData(),
                            child: TextFormField(
                              onSaved: ((newValue) {
                                discripTion = newValue!;
                              }),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value!.isEmpty) {
                                  return "Discription cannot Be Empty";
                                }
                                return null;
                              },
                              decoration: InputDecoration(hintText: "hehehe"),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();

                                  showDailogLoder(context: context, size: size);
                                  var res = await ApiServicesVendor.raiseBid({
                                    "offeredPrice": amount,
                                    "description": discripTion,
                                    "_id": data['_id']
                                  });
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  if (res['status'] == 'success') {
                                    GoRouter.of(context).pushReplacementNamed(
                                        VendorRoutes.productBiddingPage,
                                        pathParameters: {
                                          'data': jsonEncode(data)
                                        });
                                    ref
                                        .read(
                                            VendorAuctionListProvider.notifier)
                                        .getData();

                                    ref
                                        .read(
                                            VendorProductPageProvider.notifier)
                                        .getData(auctionId: data['_id']);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text("Bid Raised")));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.green,
                                            content:
                                                Text("Some error occured")));
                                  }
                                }
                              },
                              child: Text("Submit")),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("cancle"))
                        ],
                      )
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
