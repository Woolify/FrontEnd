import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:woolify/Router/NamedRoutes.dart';
import 'package:woolify/Widgets/RollCard.dart';

class SelectRoll extends StatelessWidget {
  const SelectRoll({super.key});
  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Column(
          children: [
            Card(
                // Text(
                //   "SIGN-UP !",
                //   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                //       fontSize: 25,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.white),
                // ),
                child: SizedBox(
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Get on  Board !",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ))),
          ],
        ),
        toolbarHeight: 100,
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 3,
                crossAxisSpacing: 0,
                childAspectRatio: 3 / 4),
            children: [
              RollCard(
                  image: "assets/staters/farmer.png",
                  title: "Farmer",
                  subTitle: "It All Begins Here",
                  navigate: () {
                    GoRouter.of(context)
                        .pushNamed(CommonRoutes.farmerRegisteration);
                  }),
              RollCard(
                  image: "assets/staters/consultant.png",
                  title: "Consultant",
                  subTitle: "Any Issues",
                  navigate: () {}),
              RollCard(
                  image: "assets/staters/vendor.png",
                  title: "Vendor",
                  subTitle: "Woo resell this",
                  navigate: () {}),
              RollCard(
                  image: "assets/staters/vendor.png",
                  title: "Transpoter",
                  subTitle: "Let`s move in",
                  navigate: () {}),
              RollCard(
                  image: "assets/staters/artist.png",
                  title: "Artist",
                  subTitle: "Creativity is Here",
                  navigate: () {}),
              RollCard(
                  image: "assets/staters/service.png",
                  title: "Service-provider",
                  subTitle: "Let`s refine !",
                  navigate: () {}),
            ],
          ),
        )
      ]),
    );
  }
}
