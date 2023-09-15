import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmerMarketPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _FarmerMarketPage();
  }
}

class _FarmerMarketPage extends ConsumerState {
  Widget build(context) {
    return Center(
      child: Text("MArket"),
    );
  }
}
