import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmerMainPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _FarmerHomePage();
  }
}

class _FarmerHomePage extends ConsumerState {
  Widget build(context) {
    return Center(
      child: Text("HomeScreen"),
    );
  }
}
