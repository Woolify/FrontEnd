import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:woolify/Provider/Farmer/FarmerAuctionPageProvider.dart';
import 'package:woolify/Provider/Vendor/ProductPage.dart';
import 'package:woolify/ServerRoutes/ApiServicesVendro.dart';
import 'package:woolify/ServerRoutes/ServerDetails.dart';
import 'package:woolify/Sockets/SocketsConnect.dart';
import 'package:woolify/Widgets/Farmer/VendorBidCard.dart';
import 'package:woolify/Widgets/ShowDailogLoder.dart';
import 'package:woolify/Widgets/buttonRow1.dart';
import 'package:woolify/Widgets/buttonRow2.dart';
import 'package:woolify/Widgets/vendor/BidCard.dart';
import 'package:woolify/Widgets/vendor/ConfrimBidCard.dart';
import 'dart:developer' as developer;

class FarmerBiddingPage extends ConsumerStatefulWidget {
  const FarmerBiddingPage({super.key, required this.data});
  final data;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _FarmerBiddingPage();
    throw UnimplementedError();
  }
}

class _FarmerBiddingPage extends ConsumerState<FarmerBiddingPage> {
  var data;
  @override
  void initState() {
    // developer.log(data.toString(), name: "on vendroBiddginPage");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      data = jsonDecode(widget.data);
      ref.read(FarmerAuctionPageProvider.notifier).setData(data);
    });

    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  String amount = '';
  String discription = '';
  Widget build(context) {
    data = ref.watch(FarmerAuctionPageProvider);
    late List bids;
    late var higestBid;
    if (data != null && data.isNotEmpty) {
      developer.log(data['status'].toString(), name: "Sssss");
      bids = ref.read(FarmerAuctionPageProvider.notifier).getBidsList();

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
                  expandedHeight: size.height * 0.4,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Stack(children: [
                    Positioned(
                        top: 0,
                        bottom: 0,
                        child: Container(
                          height: size.height * 04,
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
                bids.isEmpty
                    ? const SliverToBoxAdapter(
                        child: Center(
                          child: Text("No Bids Raised"),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                        childCount: bids.length,
                        (context, index) {
                          return Farmer_VendorBidOfferCard(
                            lockedBy: data.containsKey('lockedBy')
                                ? data['lockedBy']
                                : '',
                            status: data['status'],
                            data: bids[index],
                            auctionId: data['_id'],
                          );
                        },
                      )),
                data['status'] == false
                    ? SliverToBoxAdapter(child: SizedBox())
                    : SliverToBoxAdapter(
                        child: Center(
                          child: Text("bid Closed"),
                        ),
                      )
              ],
            ),
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
}
