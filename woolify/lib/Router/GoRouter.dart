import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:woolify/Pages/Authentication/Farmer.dart';
import 'package:woolify/Pages/Authentication/Login.dart';
import 'package:woolify/Pages/CommonPages/HomeScreen.dart';
import 'package:woolify/Pages/CommonPages/SeletcRoll.dart';
import 'package:woolify/Pages/Farmer/HomePage.dart';
import 'package:woolify/Pages/Starters/IntroSlider.dart';
import 'package:woolify/Pages/Starters/SplashScreen.dart';
import 'package:woolify/Router/NamedRoutes.dart';
import 'package:woolify/Widgets/CommonHomePageAppbar.dart';

class MyGoRouter {
  final GoRouter router = GoRouter(routes: [
    GoRoute(
        path: "/",
        name: CommonRoutes.root,
        pageBuilder: (context, state) {
          return MaterialPage(child: SplashScreen(key: state.pageKey));
        }),
    GoRoute(
        path: "/introSlider",
        name: CommonRoutes.introSlide,
        pageBuilder: (context, state) {
          return MaterialPage(child: IntroSlider(key: state.pageKey));
        }),
    GoRoute(
        path: "/commonHomePage",
        name: CommonRoutes.commonHomePage,
        pageBuilder: (context, state) {
          return MaterialPage(child: CommonHomeScreen(key: state.pageKey));
        }),
    GoRoute(
        path: "/selectRoll",
        name: CommonRoutes.selectRoll,
        pageBuilder: (context, state) {
          return MaterialPage(child: SelectRoll(key: state.pageKey));
        }),
    GoRoute(
        path: "/farmerRegisteration",
        name: CommonRoutes.farmerRegisteration,
        pageBuilder: (context, state) {
          return MaterialPage(child: FarmerRegisteration(key: state.pageKey));
        }),
    GoRoute(
        path: "/login",
        name: CommonRoutes.login,
        pageBuilder: (context, state) {
          return MaterialPage(child: Login(key: state.pageKey));
        }),
    GoRoute(
        path: "/farmer/homepage",
        name: FarmerRoutes.homePage,
        pageBuilder: (context, state) {
          return MaterialPage(child: FarmerHomePage(key: state.pageKey));
        }),
  ]);
}
