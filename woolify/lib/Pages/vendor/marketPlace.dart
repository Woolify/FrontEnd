import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:woolify/Model/Animal.dart';
import 'package:woolify/Provider/Vendor/AuctionProvider.dart';
import 'package:woolify/Router/NamedRoutes.dart';
import 'package:woolify/ServerRoutes/ServerDetails.dart';
import 'package:woolify/SharedPreference.dart';
import 'package:woolify/Widgets/vendor/MarketPlaceDrawer.dart';

class VendorMarketPlace extends ConsumerStatefulWidget {
  const VendorMarketPlace({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _VendorMarketPlace();
    throw UnimplementedError();
  }
}

class _VendorMarketPlace extends ConsumerState<VendorMarketPlace> {
  @override
  void initState() {
    ref.read(VendorAuctionListProvider.notifier).getData();
    // TODO: implement initState
    super.initState();
  }

  Widget build(context) {
    List data = ref.watch(VendorAuctionListProvider);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      drawer: MarketPlaceDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // backgroundColor: Theme.of(context).,
        centerTitle: true,
        toolbarHeight: 250,

        flexibleSpace: FlexibleSpaceBar(
            background: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40))),
          elevation: 5,
          // color: Theme.of(context).colorScheme.outline,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                      Text(
                        "Search",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.search))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: size.width,
                  height: 160,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(8.0, 8, 0, 0),
                          child: Text("Choose What you Want to browse"),
                        ),
                        const Divider(),
                        Expanded(
                          child: ListView.builder(
                            itemCount: sheepCategoryList.values.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.all(8),
                                // color: Colors.amber,

                                child: Column(children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/vendor/rowWool.png'),
                                    radius: 40,
                                  ),
                                  Text(sheepCategoryList.values[index].name)
                                ]),
                              );
                            },
                          ),
                        )
                      ]),
                ),
              ),
            ],
          ),
        )),
      ),
      body: data.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                      cacheExtent: 9999,
                      itemCount: data.length,
                      itemBuilder: ((context, index) {
                        // developer.log(data[index].toString());

                        bool isAlreadyBidded = false;

                        if (data[index]['bids'][0].isNotEmpty) {
                          for (var e in data[index]['bids']) {
                            if (e['bidder']['_id'] ==
                                mySharedPreference.pref.getString('id')) {
                              isAlreadyBidded = true;
                              data[index]['isAlreadyBidded'] = true;
                              break;
                            }
                          }
                        }

                        late var higestBid;
                        if (data[index].containsKey('highestBidDocument')) {
                          higestBid =
                              data[index]['highestBidDocument']['offeredPrice'];
                        } else
                          higestBid = data[index]['basePrice'];

                        print(higestBid);

                        return Container(
                          height: 430,
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
                                                      .replaceAll('localhost',
                                                          ServerDetails.ip),
                                                ))),
                                        width: double.infinity,
                                        height: 210,
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Spacer(),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
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
                                    isAlreadyBidded == true
                                        ? const Positioned(
                                            top: 4,
                                            right: 0,
                                            child: Icon(
                                              Icons.local_offer_rounded,
                                              color: Colors.amber,
                                              size: 50,
                                            ))
                                        : const SizedBox()
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(45, 0, 45, 16),
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
                                    height: 183,
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
                                              shape:
                                                  const RoundedRectangleBorder(
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
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      data[index]['basePrice']
                                                              .toString() +
                                                          "/kg",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineSmall!
                                                          .copyWith(
                                                              fontSize: 17),
                                                    ),
                                                    Text("Base price")
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Card(
                                              margin: EdgeInsets.all(0),
                                              shape:
                                                  const RoundedRectangleBorder(
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
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      higestBid.toString() +
                                                          "/kg",
                                                      style: Theme.of(context)
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
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Column(
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
                                                          Expanded(
                                                            child: Text(
                                                              "Quantity:",
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                            ),
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
                                                            "Location:",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Expanded(
                                                            // width: 122,
                                                            child: Text(
                                                              "Amravati(100km away)",
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
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
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Icon(Icons.star),
                                                          Icon(Icons.star),
                                                          Icon(Icons.star),
                                                        ],
                                                      ),
                                                    )
                                                  ]),
                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            1.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Image.asset(
                                                            "assets/farmer/auction.png"),
                                                        SizedBox(
                                                          child: ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      // elevation: 10,
                                                                      backgroundColor: Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .secondary),
                                                              onPressed: () {
                                                                print(index);

                                                                if (isAlreadyBidded ==
                                                                    true) {
                                                                  GoRouter.of(context).pushNamed(
                                                                      VendorRoutes
                                                                          .productBiddingPage,
                                                                      pathParameters: {
                                                                        "data":
                                                                            jsonEncode(data[index])
                                                                      }).then(
                                                                      (value) {
                                                                    ref
                                                                        .read(VendorAuctionListProvider
                                                                            .notifier)
                                                                        .setDataToEmpty();
                                                                    ref
                                                                        .read(VendorAuctionListProvider
                                                                            .notifier)
                                                                        .getData();
                                                                  });
                                                                } else {
                                                                  GoRouter.of(context).pushNamed(
                                                                      VendorRoutes
                                                                          .productPage,
                                                                      pathParameters: {
                                                                        'data':
                                                                            jsonEncode(data[index])
                                                                      }).then(
                                                                      (value) {
                                                                    ref
                                                                        .read(VendorAuctionListProvider
                                                                            .notifier)
                                                                        .setDataToEmpty();
                                                                    ref
                                                                        .read(VendorAuctionListProvider
                                                                            .notifier)
                                                                        .getData();
                                                                  });
                                                                }
                                                              },
                                                              child: Text(
                                                                "Bid",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .onPrimaryContainer),
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      })),
                ),
              ],
            ),
    );
  }

  // void openItemModal(BuildContext context, Size size, data) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           return Column(
  //             children: [

  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
}
