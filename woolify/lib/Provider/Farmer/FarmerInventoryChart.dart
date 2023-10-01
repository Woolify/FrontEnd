import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woolify/Model/Farmer.dart';
import 'package:woolify/ServerRoutes/Authentication.dart';

class FarmerIventoryChartNotifier extends StateNotifier<int> {
  FarmerIventoryChartNotifier() : super(0);

  void changeIndex(int i) {
    print("current $i");
    state = i;
  }
}

final FamarInventoryCharProvider =
    StateNotifierProvider<FarmerIventoryChartNotifier, int>(
        (ref) => FarmerIventoryChartNotifier());
