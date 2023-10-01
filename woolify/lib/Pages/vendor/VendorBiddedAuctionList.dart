import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:woolify/Provider/Farmer/FarmerAuction.dart';
import 'package:woolify/Provider/Vendor/AuctionProvider.dart';
import 'package:woolify/Provider/Vendor/BiddedAuction.dart';
import 'package:woolify/Router/NamedRoutes.dart';
import 'package:woolify/ServerRoutes/ServerDetails.dart';
import 'package:woolify/SharedPreference.dart';

class VendorBiddedAutions extends ConsumerStatefulWidget {
  VendorBiddedAutions({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _farmerTransactionState();
    throw UnimplementedError();
  }
}

class _farmerTransactionState extends ConsumerState<VendorBiddedAutions> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(VendorBiddedAuctionListProvider.notifier).getData();
    });
    super.initState();
  }

  var data;
  Widget build(context) {
    data = ref.watch(VendorBiddedAuctionListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Acution You Bidded In"),
        centerTitle: true,
      ),
      body: data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : data.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Column(children: [
                  Expanded(
                      child: ListView.builder(
                          cacheExtent: 9999,
                          itemCount: data.length,
                          itemBuilder: ((context, index) {
                            // developer.log(data[index].toString());

                            late var higestBid;
                            if (data[index].containsKey('highestBidDocument')) {
                              higestBid = data[index]['highestBidDocument']
                                  ['offeredPrice'];
                            } else
                              higestBid = data[index]['basePrice'];

                            print(higestBid);
                            return Container(
                              height: 480,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 0, 12, 0),
                                    child: Stack(
                                      children: [
                                        Card(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(40))),
                                          margin: EdgeInsets.zero,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      data[index]['woolImg']
                                                          .replaceAll(
                                                              'localhost',
                                                              ServerDetails.ip),
                                                    ))),
                                            width: double.infinity,
                                            height: 260,
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Spacer(),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        24.0, 24, 24, 0),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          color: Colors.black
                                                              .withOpacity(0.5),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                data[index]['inventory']
                                                                        [
                                                                        'typeOfWool']
                                                                    .toString()
                                                                    .toUpperCase(),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headlineSmall!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        color: Colors
                                                                            .white),
                                                              ),
                                                              Text(
                                                                "wool Type",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        color: Colors
                                                                            .white),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                            // color: Colors.amber,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        45, 0, 45, 16),
                                    child: Card(
                                      elevation: 10,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(40),
                                              bottomRight: Radius.circular(40),
                                              topLeft: Radius.zero,
                                              topRight: Radius.zero)),
                                      margin: const EdgeInsets.all(0),
                                      child: Container(
                                        // color: Theme.of(context).cardColor,
                                        height: 180,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Card(
                                                  margin: EdgeInsets.all(0),
                                                  shape: const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft:
                                                                  Radius.zero,
                                                              topRight:
                                                                  Radius.zero,
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          data[index]['basePrice']
                                                                  .toString() +
                                                              "/kg",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headlineSmall!
                                                              .copyWith(
                                                                  fontSize: 17),
                                                        ),
                                                        const Text("Base price")
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Card(
                                                  margin:
                                                      const EdgeInsets.all(0),
                                                  shape: const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft:
                                                                  Radius.zero,
                                                              topRight:
                                                                  Radius.zero,
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          higestBid.toString() +
                                                              "/kg",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headlineSmall!
                                                              .copyWith(
                                                                  fontSize: 17),
                                                        ),
                                                        Text("Higest Bid")
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 2.0,
                                                        horizontal: 8),
                                                    child: Row(
                                                      children: [
                                                        // Icon(Icons.monitor_weight_sharp),
                                                        Text(
                                                          "Total Quantity:",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          data[index]['inventory']
                                                                      [
                                                                      'quantity']
                                                                  .toString() +
                                                              " kg",
                                                          style: Theme.of(
                                                                  context)
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
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 2.0,
                                                        horizontal: 8),
                                                    child: Row(
                                                      children: [
                                                        // Icon(Icons.monitor_weight_sharp),
                                                        Text(
                                                          "Quality ",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          "200kg",
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ]),
                                            Center(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  GoRouter.of(context).pushNamed(
                                                      VendorRoutes
                                                          .productBiddingPage,
                                                      pathParameters: {
                                                        'data': jsonEncode(
                                                            data[index])
                                                      }).then((value) {
                                                    ref
                                                        .read(
                                                            VendorBiddedAuctionListProvider
                                                                .notifier)
                                                        .setDataToEmpty();

                                                    ref
                                                        .read(
                                                            VendorBiddedAuctionListProvider
                                                                .notifier)
                                                        .getData();
                                                  });
                                                },
                                                child: const Text("Open"),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          })))
                ]),
    );
  }
}
