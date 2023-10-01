import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:woolify/Provider/Farmer/FarmerAuctionPageProvider.dart';
import 'package:woolify/ServerRoutes/ApiServicesFarmer.dart';
import 'package:woolify/Widgets/ShowDailogLoder.dart';

class Farmer_VendorBidOfferCard extends ConsumerStatefulWidget {
  const Farmer_VendorBidOfferCard(
      {super.key,
      required this.lockedBy,
      required this.data,
      required this.auctionId,
      required this.status});
  final lockedBy;
  final status;
  final auctionId;
  final data;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _VendorBidCard();
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _VendorBidCard extends ConsumerState<Farmer_VendorBidOfferCard> {
  late var data;

  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    data = widget.data;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(8, 12, 12, 3),
          child: Card(
            color: widget.lockedBy.isNotEmpty
                ? widget.lockedBy == data['_id']
                    ? Colors.green
                    : Theme.of(context).cardColor
                : Theme.of(context).cardColor,
            child: Container(
              // height: 300,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/vendor/profile.png"),
                            radius: 20,
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                data['bidder']['username'],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        decoration: TextDecoration.underline),
                              ))
                        ],
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '₹',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              data['offeredPrice'].toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 170,
                            child: Text(
                              data['description'],
                              maxLines: 2,
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(getDate(data['updatedAt'])),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      )
                    ]),
              ),
            ),
          ),
        ),
        widget.status == false
            ? IconButton(
                icon: Icon(Icons.reply),
                onPressed: () {
                  ConformBid(context, size);
                },
              )
            : SizedBox(),
      ],
    );
  }

  void ConformBid(BuildContext context, Size size) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Card(
                  color: Theme.of(context).colorScheme.primary,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Make the Deal !",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/vendor/handshake.png", height: 150),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Do you want to sold your goods for '${data['offeredPrice'].toString()}' /Kg to VendorName ?",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () async {
                          showDailogLoder(context: context, size: size);
                          var res = await ApiServicersFarmer.confrimBid(
                              auctionId: widget.auctionId, bidID: data['_id']);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          if (res['status'] == "success") {
                            ref
                                .read(FarmerAuctionPageProvider.notifier)
                                .getData(auctionId: widget.auctionId);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Some internal Error")));
                          }
                        },
                        child: Text("Sell Out",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold))),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold))),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  String getDate(String date) {
    DateTime dateTime = DateTime.parse(date);

    DateTime istDateTime = dateTime.toLocal();

    // Format the DateTime object in "hh:mm a" format
    return DateFormat('hh:mm a').format(istDateTime);
  }
}
