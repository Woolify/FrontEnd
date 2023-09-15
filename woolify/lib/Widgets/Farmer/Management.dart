import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmerManagement extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _FarmerManagement();
  }
}

class _FarmerManagement extends ConsumerState {
  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
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
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: GridView(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 3,
                crossAxisSpacing: 0,
                childAspectRatio: 3 / 4),
            children: [
              Card(
                child: Image.asset(
                  "assets/farmer/Fevents.png",
                  height: size.height * 0.3,
                ),
              ),
              Card(
                child: Image.asset(
                  "assets/farmer/Ftransaction.png",
                  height: size.height * 0.3,
                ),
              ),
              Card(
                child: Image.asset(
                  "assets/farmer/Fsetup.png",
                  height: size.height * 0.3,
                ),
              ),
              Card(
                child: Image.asset(
                  "assets/farmer/Freports.png",
                  height: size.height * 0.3,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
