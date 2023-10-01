import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class VendorBidCard extends ConsumerStatefulWidget {
  const VendorBidCard({super.key, required this.data, required this.lockedBy});
  final data;
  final lockedBy;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _VendorBidCard();
    throw UnimplementedError();
  }
}

class _VendorBidCard extends ConsumerState<VendorBidCard> {
  String getDate(String date) {
    DateTime dateTime = DateTime.parse(date);

    DateTime istDateTime = dateTime.toLocal();

    // Format the DateTime object in "hh:mm a" format
    return DateFormat('hh:mm a').format(istDateTime);
  }

  Widget build(context) {
    var data = widget.data;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Card(
            color: widget.lockedBy.isNotEmpty
                ? widget.lockedBy == data['_id']
                    ? Colors.green
                    : Theme.of(context).cardColor
                : Theme.of(context).cardColor,
            child: Container(
              // height: 300,
              // width: 300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // color: Colors.amber,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                              width: 60,
                            )
                          ],
                        ),
                        SizedBox(
                          width: 170,
                          child: Text(
                            data['description'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(getDate(data['updatedAt'])),
                              Spacer(),
                              Image.asset(
                                "assets/vendor/read.png",
                                color: Colors.blue,
                                scale: 3,
                              )
                            ],
                          ),
                        )
                      ]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
