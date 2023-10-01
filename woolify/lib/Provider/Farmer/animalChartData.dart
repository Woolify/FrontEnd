import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woolify/Model/Farmer.dart';
import 'package:woolify/ServerRoutes/ApiServicesFarmer.dart';
import 'package:woolify/ServerRoutes/Authentication.dart';

class AnimalChartDataNotifier extends StateNotifier<Map> {
  AnimalChartDataNotifier() : super({});

  void getData() async {
    state = await ApiServicersFarmer.getAllAnimalData();
    print("starae is");
    print(state);
  }

  void setDataTonull() {
    state = {};
  }
}

final AnimalChartProvider = StateNotifierProvider<AnimalChartDataNotifier, Map>(
    (ref) => AnimalChartDataNotifier());
