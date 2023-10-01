import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:woolify/SharedPreference.dart';
import 'package:woolify/Widgets/Farmer/HomePage.dart';
import 'package:woolify/Widgets/Farmer/Management.dart';
import 'package:woolify/Widgets/Farmer/market.dart';
import 'package:woolify/Widgets/Farmer/profile.dart';

class FarmerHomePage extends ConsumerStatefulWidget {
  const FarmerHomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    //
    return _FarmerHomePage();
  }
}

class _FarmerHomePage extends ConsumerState<FarmerHomePage> {
  List<Widget> screens = [
    FarmerMainPage(),
    FarmerManagement(),
    FarmerMarketPage(),
    FarmerProfile()
  ];
  int currentIndex = 0;
  Widget build(context) {
    return Scaffold(
      // appBar: AppBar(actions: [
      //   IconButton(
      //       onPressed: () async {
      //         await mySharedPreference.pref.clear();
      //         GoRouter.of(context).pushReplacement('/');
      //       },
      //       icon: Icon(Icons.logout))
      // ]),
      body: SafeArea(child: screens[currentIndex]),
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
                icon: SvgPicture.asset(
                  "assets/farmer/sheep.svg",
                  height: currentIndex == 1 ? 30 : 20,
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
