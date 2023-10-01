import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:woolify/Router/NamedRoutes.dart';

class MarketRouting extends StatelessWidget {
  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 3,
        mainAxisExtent: 290,
        crossAxisSpacing: 1,
      ),
      children: [
        InkWell(
          onTap: (() {
            GoRouter.of(context).pushNamed(VendorRoutes.MarketPlace);
          }),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              // color: Theme.of(context).colorScheme.inversePrimary,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    "assets/farmer/buy.png",
                    height: 150,
                  ),
                  Spacer(),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Text(
                        " Market",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: (() {
            GoRouter.of(context).pushNamed(VendorRoutes.AuctionBiddedInList);
          }),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              // color: Theme.of(context).colorScheme.inversePrimary,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    "assets/vendor/auctionOpen.png",
                    height: 150,
                  ),
                  Spacer(),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Text(
                        "Auctions ",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: (() {
            print("object");
          }),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              // color: Theme.of(context).colorScheme.inversePrimary,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    "assets/farmer/Ftransaction.png",
                    height: 150,
                  ),
                  Spacer(),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Text(
                        "Transactions",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: (() {}),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              // color: Theme.of(context).colorScheme.inversePrimary,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    "assets/farmer/buy.png",
                    height: 150,
                  ),
                  Spacer(),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Text(
                        "Comming Soon ",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
