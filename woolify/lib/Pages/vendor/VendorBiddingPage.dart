import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:woolify/Provider/Vendor/AuctionProvider.dart';
import 'package:woolify/Provider/Vendor/ProductPage.dart';
import 'package:woolify/ServerRoutes/ApiServicesVendro.dart';
import 'package:woolify/ServerRoutes/ServerDetails.dart';
import 'package:woolify/SharedPreference.dart';
import 'package:woolify/Widgets/ShowDailogLoder.dart';
import 'package:woolify/Widgets/buttonRow1.dart';
import 'package:woolify/Widgets/buttonRow2.dart';
import 'package:woolify/Widgets/vendor/BidCard.dart';
import 'package:woolify/Widgets/vendor/ConfrimBidCard.dart';
import 'dart:developer' as developer;

class VendroBiddingPage extends ConsumerStatefulWidget {
  const VendroBiddingPage({super.key, required this.data});
  final data;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _VendorBiddingPage();
    throw UnimplementedError();
  }
}

class _VendorBiddingPage extends ConsumerState<VendroBiddingPage> {
  var data;
  @override
  void initState() {
    // developer.log(data.toString(), name: "on vendroBiddginPage");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      data = jsonDecode(widget.data);
      ref.read(VendorProductPageProvider.notifier).setData(data);
    });

    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  String amount = '';
  String discription = '';
  Widget build(context) {
    data = ref.watch(VendorProductPageProvider);
    late List bids;
    late var higestBid;
    if (data != null && data.isNotEmpty) {
      bids = ref.read(VendorProductPageProvider.notifier).getBidsList();

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
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  pinned: true,
                  title: Text("Auction"),
                ),
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: size.height * 0.42,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Stack(children: [
                    Positioned(
                        top: 60,
                        bottom: 0,
                        child: Container(
                          // height: size.height * 04,
                          width: size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(data['woolImg']
                                      .toString()
                                      .replaceAll(
                                          'localhost', ServerDetails.ip)))),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Spacer(),
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero),
                                  color: Colors.black.withOpacity(0.3),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      data['inventory']['typeOfWool'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary),
                                    ),
                                  ),
                                )
                              ]),
                        )),
                    Container(
                      height: size.height * 0.16,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(60),
                              bottomRight: Radius.circular(60))),
                      child: Column(children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: size.width,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                            Icons.info,
                                            size: 40,
                                          ),
                                          onPressed: () {
                                            openItemInfo(context, size);
                                          },
                                        ),
                                      ),
                                    ),
                                    Text("Info")
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
                                            Icons.account_circle,
                                            size: 40,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                    Text("Farmer Info")
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
                                            Icons.car_crash,
                                            size: 40,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                    Text("Transport")
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                    ),
                  ])),
                ),
                SliverAppBar(
                  // title: ,
                  automaticallyImplyLeading: false,
                  expandedHeight: 130,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Card(
                      color: Theme.of(context).colorScheme.primary,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: buttonRow2(
                          HigestBid: higestBid.toString(),
                          basePrice: data['basePrice']!.toString(),
                          marketPrice: "222"),
                    ),
                  )),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  childCount: bids.length,
                  (context, index) {
                    return VendorBidCard(
                      lockedBy:
                          data.containsKey('lockedBy') ? data['lockedBy'] : '',
                      data: bids[index],
                    );
                  },
                )),
                data['status'] == true
                    ? closedByMe()
                        ? SliverToBoxAdapter(
                            child: Row(
                              children: [
                                Card(
                                  color: Colors.green,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                              "assets/vendor/handshake.png",
                                              height: 100),
                                          Text("Deal accepted By Farmer")
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : SliverToBoxAdapter(child: SizedBox())
                    : SliverToBoxAdapter(child: SizedBox()),
                data['status'] == true
                    ? SliverToBoxAdapter(
                        child: Center(child: Text("Bid Closed")),
                      )
                    : SliverToBoxAdapter(
                        child: AddYourBid(context, size),
                      )
              ],
            ),
          );
  }

  bool closedByMe() {
    for (var e in data['bids']) {
      if (e['_id'] == data['lockedBy']) {
        if (e['bidder'] is String) {
          if (e['bidder'] == mySharedPreference.pref.getString('id')) {
            return true;
          }
        } else {
          if (e['bidder']['_id'] == mySharedPreference.pref.getString('id')) {
            return true;
          }
        }
      }
    }
    return false;
  }

  Widget AddYourBid(BuildContext context, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Container(
              child: Column(children: [
                Row(
                  children: [
                    SizedBox(
                        width: 130,
                        child: Text(
                          "We need to Raise bid..?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        addBid(context, size);
                      },
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset("assets/farmer/auction.png"),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Add Bid",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ]),
            ),
          ),
        )
      ],
    );
  }

  void openItemInfo(BuildContext context, Size size) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            // height: 220,

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.document_scanner,
                    size: 150,
                  ),
                  Text(
                    "Details",
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            ),
            // Spacer(),

            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 24, 8, 8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 8),
                      child: Row(
                        children: [
                          // Icon(Icons.monitor_weight_sharp),
                          Text(
                            "Total Quantity:",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${data['quantity']} kg",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.w900),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 8),
                      child: Row(
                        children: [
                          // Icon(Icons.monitor_weight_sharp),
                          Text(
                            "Location:",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),

                          SizedBox(
                              width: size.width * 0.33,
                              child: Theme(
                                  data: ThemeData(),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: TextFormField(
                                      maxLines: 1,
                                      initialValue: " Amravati",
                                      decoration: const InputDecoration(
                                          disabledBorder: InputBorder.none),
                                      enabled: false,
                                    ),
                                  )))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 8),
                      child: Row(
                        children: [
                          // Icon(Icons.monitor_weight_sharp),
                          Text(
                            "Quality ",
                            style: Theme.of(context).textTheme.bodyLarge,
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 8),
                      child: Row(
                        children: [
                          // Icon(Icons.monitor_weight_sharp),
                          Text(
                            "color:",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${data['inventory']['color']} ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.w900),
                          )
                        ],
                      ),
                    )
                  ]),
            )
          ]),
        );
      },
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
                                discription = newValue!;
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
                                    "description": discription,
                                    "_id": data['_id']
                                  });
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  if (res['status'] == 'success') {
                                    // ref
                                    //     .read(
                                    //         VendorProductPageProvider.notifier)
                                    //     .setDataToEmpty();
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
