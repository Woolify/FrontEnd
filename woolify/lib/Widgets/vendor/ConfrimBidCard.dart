import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfrimBidCard extends ConsumerWidget {
  Widget build(context, ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          child: Card(
            child: Container(
              // height: 300,
              // width: 300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Gaurav Pawar ",
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          "assets/vendor/success.png",
                          height: 50,
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Text(
                          "Gaurav pawar has Comfrimed the Deal !",
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("12:55 pm"),
                          ],
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
