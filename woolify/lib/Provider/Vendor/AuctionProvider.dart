import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woolify/Model/Farmer.dart';
import 'package:woolify/ServerRoutes/ApiServicesFarmer.dart';
import 'package:woolify/ServerRoutes/ApiServicesVendro.dart';
import 'package:woolify/ServerRoutes/Authentication.dart';

class VendorAuctionListNotifier extends StateNotifier<List> {
  VendorAuctionListNotifier() : super([]);

  void getData() async {
    state = await ApiServicesVendor.getAuctionListForMarket();
    if (state.isEmpty) print("is empty");
  }

  void setData(data) async {
    state = data;
  }

  void setDataToEmpty() {
    state = [];
  }
}

final VendorAuctionListProvider =
    StateNotifierProvider<VendorAuctionListNotifier, List>(
        (ref) => VendorAuctionListNotifier());
