import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;

class CommonPageImageSlider extends ConsumerWidget {
  List<String> imageList = [
    "assets/staters/wool1.jpeg",
    "assets/staters/wool4.jpeg",
    "assets/staters/wool5.jpeg"
  ];
  CarouselController _controller = CarouselController();
  Widget build(context, ref) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.8,
        width: size.width * 0.68,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 60,
                color: Color.fromARGB(255, 206, 225, 226)),
          ],
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
        ),
        child: Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 2),
                height: double.infinity,
                viewportFraction: 1,
              ),
              items: imageList
                  .map((e) => ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                      ),
                      child: Image.asset(
                        e,
                        fit: BoxFit.fitHeight,
                      )))
                  .toList(),
            ),
          ],
        ));
  }
}
