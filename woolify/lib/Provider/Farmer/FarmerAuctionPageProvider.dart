import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woolify/Model/Farmer.dart';
import 'package:woolify/ServerRoutes/ApiServicesFarmer.dart';
import 'package:woolify/ServerRoutes/ApiServicesVendro.dart';
import 'package:woolify/ServerRoutes/Authentication.dart';
import 'dart:developer' as developer;

import 'package:woolify/SharedPreference.dart';

class FarmerAuctionPageNotifier extends StateNotifier<Map> {
  FarmerAuctionPageNotifier() : super({});

  Future<void> getData({required String auctionId}) async {
    state = await ApiServicesVendor.getAuctionData(auctionId: auctionId);
  }

  List getBidsList() {
    // developer.log("in hehe");
    developer.log(state['bids'].toString());
    List data = [];

    for (var e in state['bids']) {
      if (e['bidder'] is String) {
        data.add(e);
      } else if (e['bidder'] is Map) {
        data.add(e);
      }
    }
    developer.log(data.toString());
    return data;
  }

  void setData(data) {
    // developer.log(data.toString());
    state = data;
  }

  void setDataToEmpty() {
    state = {};
  }
}

final FarmerAuctionPageProvider =
    StateNotifierProvider<FarmerAuctionPageNotifier, Map>(
        (ref) => FarmerAuctionPageNotifier());
