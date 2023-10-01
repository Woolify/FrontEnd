import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woolify/Router/NamedRoutes.dart';
import 'package:woolify/SharedPreference.dart';
import 'package:woolify/Sockets/Notification.dart';
import 'dart:developer' as developer;

import 'package:woolify/Sockets/SocketsConnect.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});
  @override
  ConsumerState<SplashScreen> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends ConsumerState<SplashScreen> {
  final int time = 2;
  @override
  void initState() {
    splashScreenTimer();
    super.initState();
  }

  void splashScreenTimer() async {
    SharedPreferences pref = await mySharedPreference.initSharedPreference();
    await Future.delayed(Duration(seconds: time));
    if (pref.containsKey("isAlreadyLaunched")) {
      if (pref.containsKey("role")) {
        CustomNotiFication.initilize();
        mySocketConnect.connect();
        if (pref.getString('role') == "farmer") {
          developer.log("logged in as farmer");
          GoRouter.of(context).pushReplacementNamed(FarmerRoutes.homePage);
        } else if (pref.getString('role') == "vendor") {
          developer.log("Logged in as vendor");
          GoRouter.of(context).pushReplacementNamed(VendorRoutes.homePage);
        }
      } else {
        developer.log("to common  homePage");
        GoRouter.of(context).pushReplacementNamed(CommonRoutes.commonHomePage);
      }
    } else {
      pref.setBool("isAlreadyLaunched", true);
      GoRouter.of(context).pushReplacementNamed(CommonRoutes.introSlide);
    }
  }

  @override
  Widget build(context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Positioned(
              right: size.width * 0.5,
              child: ClipOval(
                child: Container(
                  color: Color.fromARGB(255, 56, 103, 128),
                  height: size.height * 0.6,
                  width: size.width * 0.8,
                ),
              )),
          Positioned(
              bottom: 0,
              left: size.width * 0.5,
              child: ClipOval(
                child: Container(
                  color: Color.fromARGB(255, 56, 103, 128),
                  height: size.height * 0.6,
                  width: size.width * 0.8,
                ),
              )),
          Positioned.fill(
            top: 100,
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                'WOOLIFY',
                style: GoogleFonts.irishGrover(
                    fontSize: 55, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Positioned.fill(
            top: 200,
            child: Align(
              alignment: Alignment.topCenter,
              child:
                  AnimatedTextKit(isRepeatingAnimation: false, animatedTexts: [
                TyperAnimatedText(
                    "Woolify: Navigating Wool's Journey with Precision and Profit.",
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 20),
                    textAlign: TextAlign.center,
                    speed: const Duration(milliseconds: 40))
              ]),
            ),
          ),
          Positioned(
              bottom: 0, child: Image.asset("assets/staters/splashshbg.png")),
          Positioned(
              bottom: 200,
              left: size.width * 0.16,
              child: ClipOval(
                child: Container(
                  color: Colors.white,
                  height: 10,
                  width: 10,
                ),
              ))
        ],
      ),
    );
  }
}
