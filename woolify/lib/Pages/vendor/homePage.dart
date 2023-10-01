import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:woolify/Pages/vendor/MarketRouting.dart';
import 'package:woolify/Pages/vendor/marketPlace.dart';
import 'package:woolify/SharedPreference.dart';
import 'package:woolify/Widgets/Farmer/HomePage.dart';
import 'package:woolify/Widgets/Farmer/Management.dart';
import 'package:woolify/Widgets/Farmer/market.dart';
import 'package:woolify/Widgets/Farmer/profile.dart';

class VendorHomePage extends ConsumerStatefulWidget {
  const VendorHomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    //
    return _VendorHomePage();
  }
}

class _VendorHomePage extends ConsumerState<VendorHomePage> {
  List<Widget> screens = [
    FarmerMainPage(),
    FarmerManagement(),
    // VendorMarketPlace(),
    MarketRouting(),
    FarmerProfile()
  ];
  int currentIndex = 0;
  Widget build(context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Vendor"), actions: [
      //   IconButton(
      //       onPressed: () async {
      //         await mySharedPreference.pref.clear();
      //         GoRouter.of(context).pushReplacement('/');
      //       },
      //       icon: Icon(Icons.logout))
      // ]),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 20,
          selectedIconTheme: IconThemeData(size: 30),
          unselectedIconTheme: IconThemeData(size: 20),
          unselectedFontSize: 15,
          // selectedItemColor: Theme.of(context).colorScheme.primary,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/farmer/cotton.png",
                  height: currentIndex == 1 ? 40 : 30,
                  color: currentIndex == 1
                      ? Theme.of(context).colorScheme.primary
                      : Colors.black,
                ),
                label: "Management"),
            BottomNavigationBarItem(
                icon: Icon(Icons.crop_original_outlined), label: "Market"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance), label: "Profile"),
          ]),
    );
  }
}
