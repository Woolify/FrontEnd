import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woolify/Model/Farmer.dart';
import 'package:woolify/ServerRoutes/ApiServicesFarmer.dart';
import 'package:woolify/ServerRoutes/Authentication.dart';

class FarmerIventoryPageNotifier extends StateNotifier<dynamic> {
  FarmerIventoryPageNotifier() : super(null);

  void getData() async {
    state = await ApiServicersFarmer.getInventory();
  }

  void setDataTonull() {
    state = null;
  }
}

final FamarInventoryPageProvider =
    StateNotifierProvider<FarmerIventoryPageNotifier, dynamic>(
        (ref) => FarmerIventoryPageNotifier());
