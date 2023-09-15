import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:woolify/Widgets/CommonHomePageAppbar.dart';

class CommonHomeScreen extends ConsumerStatefulWidget {
  const CommonHomeScreen({super.key});
  @override
  ConsumerState<CommonHomeScreen> createState() {
    return _CommonHomeScreen();
  }
}

class _CommonHomeScreen extends ConsumerState<CommonHomeScreen> {
  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: size.height*0.89,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(background: CommonHomePageAppBar()),
          )
        ],
      ),
    );
  }
}
