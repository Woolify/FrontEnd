import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:woolify/Pages/Authentication/Farmer.dart';
import 'package:woolify/Pages/Authentication/Login.dart';
import 'package:woolify/Pages/Authentication/Vendor.dart';
import 'package:woolify/Pages/CommonPages/HomeScreen.dart';
import 'package:woolify/Pages/CommonPages/SeletcRoll.dart';
import 'package:woolify/Pages/Farmer/FarmerOpenAuctionPage.dart';
import 'package:woolify/Pages/Farmer/FarmerTransaction.dart';
import 'package:woolify/Pages/Farmer/HomePage.dart';
import 'package:woolify/Pages/Farmer/ManageShip.dart';
import 'package:woolify/Pages/Farmer/QRPDFList.dart';
import 'package:woolify/Pages/Starters/IntroSlider.dart';
import 'package:woolify/Pages/Starters/SplashScreen.dart';
import 'package:woolify/Pages/vendor/ProductPage.dart';
import 'package:woolify/Pages/vendor/VendorBiddedAuctionList.dart';
import 'package:woolify/Pages/vendor/VendorBiddingPage.dart';
import 'package:woolify/Pages/vendor/homePage.dart';
import 'package:woolify/Pages/vendor/marketPlace.dart';
import 'package:woolify/Router/NamedRoutes.dart';
import 'package:woolify/Widgets/CommonHomePageAppbar.dart';
import 'package:woolify/Widgets/Farmer/InventoryManagement.dart';
import 'package:woolify/Widgets/Farmer/QRForm.dart';
import 'package:woolify/Widgets/Farmer/ScanQr.dart';
import 'package:woolify/Widgets/Farmer/updateShipData.dart';

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
    GoRoute(
        path: "/farmer/ManageSheep",
        name: FarmerRoutes.manageSheep,
        pageBuilder: (context, state) {
          return MaterialPage(child: ManageSheep(key: state.pageKey));
        }),
    GoRoute(
        path: "/farmer/ScanQr",
        name: FarmerRoutes.scanQr,
        pageBuilder: (context, state) {
          return MaterialPage(child: ScanQR(key: state.pageKey));
        }),
    GoRoute(
        path: "/farmer/QRForm/:url",
        name: FarmerRoutes.QRForm,
        pageBuilder: (context, state) {
          return MaterialPage(
              child: QRForm(
            key: state.pageKey,
            url: state.pathParameters['url']!,
          ));
        }),
    GoRoute(
        path: "/farmer/updateSheepData/:data",
        name: FarmerRoutes.updateAnimalData,
        pageBuilder: (context, state) {
          return MaterialPage(
              child: UpdateShipData(
            key: state.pageKey,
            data: state.pathParameters['data'],
          ));
        }),
    GoRoute(
      path: "/farmer/Inventory",
      name: FarmerRoutes.Inventory,
      pageBuilder: (context, state) {
        return MaterialPage(child: FarmerIventory());
      },
    ),
    GoRoute(
      path: '/vendro/registeration',
      name: VendorRoutes.registeration,
      pageBuilder: (context, state) {
        return MaterialPage(
            child: VendorRegisteration(
          key: state.pageKey,
        ));
      },
    ),
    GoRoute(
      path: '/vendro/HomePage',
      name: VendorRoutes.homePage,
      pageBuilder: (context, state) {
        return MaterialPage(
            child: VendorHomePage(
          key: state.pageKey,
        ));
      },
    ),
    GoRoute(
      path: '/vendro/ProductPage:data',
      name: VendorRoutes.productPage,
      pageBuilder: (context, state) {
        return MaterialPage(
            child: ProductPage(
          key: state.pageKey,
          data: state.pathParameters['data'],
        ));
      },
    ),
    GoRoute(
      path: '/vendro/ProductBiddingPage:data',
      name: VendorRoutes.productBiddingPage,
      pageBuilder: (context, state) {
        return MaterialPage(
            child: VendroBiddingPage(
          key: state.pageKey,
          data: state.pathParameters['data'],
        ));
      },
    ),
    GoRoute(
      path: '/farmer/Transaction',
      name: FarmerRoutes.transaction,
      pageBuilder: (context, state) {
        return MaterialPage(
            child: farmerTransaction(
          key: state.pageKey,
        ));
      },
    ),
    GoRoute(
      path: '/farmer/farmerBiddingPage:data',
      name: FarmerRoutes.farmerBiddingPage,
      pageBuilder: (context, state) {
        return MaterialPage(
            child: FarmerBiddingPage(
          key: state.pageKey,
          data: state.pathParameters['data'],
        ));
      },
    ),
    GoRoute(
      path: '/farmer/QRPDFList',
      name: FarmerRoutes.farmerQRPDFList,
      pageBuilder: (context, state) {
        return MaterialPage(
            child: QRpdfList(
          key: state.pageKey,
        ));
      },
    ),
    GoRoute(
      path: '/vendor/marketPlace',
      name: VendorRoutes.MarketPlace,
      pageBuilder: (context, state) {
        return MaterialPage(
            child: VendorMarketPlace(
          key: state.pageKey,
        ));
      },
    ),
    GoRoute(
      path: '/vendor/auctionsAlreadyBiddedIn',
      name: VendorRoutes.AuctionBiddedInList,
      pageBuilder: (context, state) {
        return MaterialPage(
            child: VendorBiddedAutions(
          key: state.pageKey,
        ));
      },
    ),
  ]);
}
