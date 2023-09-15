import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:woolify/Router/NamedRoutes.dart';
import 'package:woolify/Widgets/CommonHomePageFeatureCard.dart';
import 'package:woolify/Widgets/CommonPageImageSlider.dart';

class CommonHomePageAppBar extends ConsumerWidget {
  const CommonHomePageAppBar({super.key});
  Widget build(context, ref) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("home Page"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: size.height * 0.9,
        child: Stack(
          children: [
            Positioned(
              top: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const CommonHomePageFeatureCard(
                  //     image: "market.png", title: "Market"),
                  // const CommonHomePageFeatureCard(
                  //     image: "prices.png", title: "Prices"),
                  // const CommonHomePageFeatureCard(
                  //     image: "trending.png", title: "Trends"),
                  // const CommonHomePageFeatureCard(
                  //     image: "news.png", title: "News"),
                  // const CommonHomePageFeatureCard(
                  //     image: "news.png", title: "News"),
                  ElevatedButton(
                      onPressed: () {
                        GoRouter.of(context).pushNamed(CommonRoutes.login);
                      },
                      child: const Text("Register"))
                ],
              ),
            ),
            // Positioned(left: size.width * 0.4, child: CommonPageImageSlider())
          ],
        ),
      ),
    );
  }
}
