import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woolify/Model/Farmer.dart';
import 'package:woolify/ServerRoutes/ApiServicesFarmer.dart';
import 'package:woolify/ServerRoutes/ApiServicesVendro.dart';
import 'package:woolify/ServerRoutes/Authentication.dart';

class VendorBiddedAuctionListNotifier extends StateNotifier<List> {
  VendorBiddedAuctionListNotifier() : super([]);

  void getData() async {
    print("object");
    state = await ApiServicesVendor.getBiddedAuctionListForVendor();
  }

  void setData(data) async {
    state = data;
  }

  void setDataToEmpty() {
    state = [];
  }
}

final VendorBiddedAuctionListProvider =
    StateNotifierProvider<VendorBiddedAuctionListNotifier, List>(
        (ref) => VendorBiddedAuctionListNotifier());
