import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woolify/Model/Farmer.dart';
import 'package:woolify/ServerRoutes/ApiServicesFarmer.dart';
import 'package:woolify/ServerRoutes/ApiServicesVendro.dart';
import 'package:woolify/ServerRoutes/Authentication.dart';

class FarmerAuctionListNotifier extends StateNotifier<List> {
  FarmerAuctionListNotifier() : super([]);

  void getData() async {
    print("object");
    state = await ApiServicersFarmer.getAuctionListForFarmer();
  }

  void setData(data) async {
    state = data;
  }

  void setDataToEmpty() {
    state = [];
  }
}

final FarmerAuctionListProvider =
    StateNotifierProvider<FarmerAuctionListNotifier, List>(
        (ref) => FarmerAuctionListNotifier());
