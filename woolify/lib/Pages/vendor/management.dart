import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:woolify/Router/NamedRoutes.dart';

class VendorManagement extends ConsumerStatefulWidget {
  @override
  ConsumerState<VendorManagement> createState() {
    return _VendorManagement();
  }
}

class _VendorManagement extends ConsumerState<VendorManagement> {
  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  GoRouter.of(context).pushNamed(FarmerRoutes.manageSheep);
                },
                child: Card(
                  child: Container(
                    width: size.width * 0.96,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/farmer/Fsheep.png",
                          height: size.height * 0.2,
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                            child: Text(
                              "Ship List",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView(
                // physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 0,
                    childAspectRatio: 3 / 4),
                children: [
                  Card(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/farmer/Fevents.png",
                          height: size.height * 0.24,
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: Text(
                              "Events",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/farmer/Ftransaction.png",
                          height: size.height * 0.24,
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: Text(
                              "Transcastions",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      GoRouter.of(context).pushNamed(FarmerRoutes.Inventory);
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/farmer/Fsetup.png",
                            height: size.height * 0.24,
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                              child: Text(
                                "Inventory",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/farmer/Freports.png",
                          height: size.height * 0.24,
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: Text(
                              "Report",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
