import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FarmerProfile extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _FarmerProfile();
  }
}

class _FarmerProfile extends ConsumerState {
  Widget build(context) {
    return Center(
      child: Text("Profile"),
    );
  }
}
