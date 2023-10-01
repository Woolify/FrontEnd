import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui' as ui;

import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StaterSlider extends ConsumerStatefulWidget {
  @override
  ConsumerState<StaterSlider> createState() {
    return _StaterSlider();
  }
}

List<Widget> slides = [
  Slide1(),
  Slide2(),
  Slide3(),
  Slide4(),
  Slide5(),
  Slide6()
];
int pointer = 0;

class _StaterSlider extends ConsumerState<StaterSlider> {
  final pageController = PageController();
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  List colorLi = [
    Color.fromARGB(255, 226, 159, 55),
    Color.fromARGB(255, 208, 215, 229),
    Color.fromARGB(255, 100, 151, 159),
    Color.fromARGB(255, 131, 97, 74),
    Color.fromARGB(255, 240, 232, 210),
    Color.fromARGB(255, 145, 175, 174)
  ];

  @override
  void initState() {
    super.initState();
  }

  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorLi[pointer],
      body: Column(
        children: [
          SizedBox(
              height: size.height * 0.89,
              child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    // print(value);
                    pointer = value;
                  });
                },
                controller: pageController,
                children: slides.toList(),
              )),
          Center(
              child: SmoothPageIndicator(
            controller: pageController,
            effect: const ExpandingDotsEffect(),
            count: 6,
          ))
        ],
      ),
    );
  }
}

final List<int> list = [1, 2, 3, 4, 5, 6];

class Slide1 extends StatelessWidget {
  const Slide1({
    super.key,
  });

  @override
  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomPaint(
          size: Size(
              size.width,
              (size.width * 0.59)
                  .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: RPSCustomPainter(),
        ),
        Expanded(
          // height: size.height * 0.58,
          child: Stack(
            children: [
              Positioned(
                right: 0,
                child: SvgPicture.asset(
                  'assets/staters/slide1.svg',
                  height: size.height * 0.25,
                ),
              ),
              Positioned(
                  bottom: 60,
                  left: -50,
                  child: ClipOval(
                    child: Container(
                      color: Color.fromARGB(99, 156, 131, 42),
                      height: size.height * 0.37,
                      width: size.width * 0.5,
                    ),
                  )),
              Positioned(
                  left: 50,
                  bottom: 270,
                  child: Text(
                    "PRICES TRENDS &",
                    style: GoogleFonts.irishGrover(fontSize: 30),
                  )),
              Positioned(
                  left: 50,
                  bottom: 230,
                  child: Text(
                    "News",
                    style: GoogleFonts.irishGrover(fontSize: 30),
                  )),
              Positioned(
                width: size.width * 0.87,
                left: 50,
                bottom: 120,
                child: Text(
                  "Welcome to the swankiest, jumpiest, and wooliest platform for real-time wool market information! We give you quick access to the latest wool prices, trends, and news with the stroke of a key.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                  maxLines: 5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Slide2 extends StatelessWidget {
  const Slide2({
    super.key,
  });

  @override
  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomPaint(
          size: Size(
              size.width,
              (size.width * 0.45)
                  .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: RPSCustomPainter(),
        ),
        Expanded(
          child: SizedBox(
            // height: size.height * 0.68,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  child: SvgPicture.asset(
                    'assets/staters/slide2.svg',
                    height: size.height * 0.17,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 100,
                  child: SvgPicture.asset(
                    'assets/staters/slide2a.svg',
                    height: size.height * 0.2,
                  ),
                ),
                Positioned(
                    bottom: 70,
                    left: -50,
                    child: ClipOval(
                      child: Container(
                        color: Color.fromARGB(99, 156, 131, 42),
                        height: size.height * 0.37,
                        width: size.width * 0.5,
                      ),
                    )),
                Positioned(
                    left: 50,
                    bottom: 270,
                    child: Text(
                      "WOOL TRACKING",
                      style: GoogleFonts.irishGrover(fontSize: 30),
                    )),
                Positioned(
                  width: size.width * 0.87,
                  left: 50,
                  bottom: 120,
                  child: Text(
                    "Welcome to the fantastic world of wool tracking! Forget about lost bales and uncertain delivery dates – we‘ve got your back. Start your fabulous journey from your sheep‘s cozy embrace to the bustling marketplace, all in real-time.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                    maxLines: 6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Slide3 extends StatelessWidget {
  const Slide3({
    super.key,
  });

  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomPaint(
          size: Size(
              size.width,
              (size.width * 0.45)
                  .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: RPSCustomPainter(),
        ),
        Expanded(
          child: SizedBox(
            // height: size.height * 0.68,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  child: SvgPicture.asset(
                    'assets/staters/slide3.svg',
                    height: size.height * 0.17,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 100,
                  child: SvgPicture.asset(
                    'assets/staters/slide3a.svg',
                    height: size.height * 0.2,
                  ),
                ),
                Positioned(
                    bottom: 70,
                    left: -50,
                    child: ClipOval(
                      child: Container(
                        color: Color.fromARGB(99, 156, 131, 42),
                        height: size.height * 0.37,
                        width: size.width * 0.5,
                      ),
                    )),
                Positioned(
                    left: 50,
                    bottom: 270,
                    child: Text(
                      "ELEVATE YOUR WOOL",
                      style: GoogleFonts.irishGrover(fontSize: 30),
                    )),
                Positioned(
                    left: 50,
                    bottom: 230,
                    child: Text(
                      "GAME",
                      style: GoogleFonts.irishGrover(fontSize: 30),
                    )),
                Positioned(
                  width: size.width * 0.87,
                  left: 50,
                  bottom: 80,
                  child: Text(
                    "Are you a wool producer looking to conquer the quality assurance game? Look no further! Wool Quality Platform is here to bring every wool producer’s dream to life. Say goodbye to haphazard grading and hello to top-notch methods.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                    maxLines: 7,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Slide4 extends StatelessWidget {
  const Slide4({
    super.key,
  });

  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomPaint(
          size: Size(
              size.width,
              (size.width * 0.45)
                  .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: RPSCustomPainter(),
        ),
        Expanded(
          child: SizedBox(
            // height: size.height * 0.68,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  child: SvgPicture.asset(
                    'assets/staters/slide4.svg',
                    height: size.height * 0.17,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 100,
                  child: SvgPicture.asset(
                    'assets/staters/slide4a.svg',
                    height: size.height * 0.2,
                  ),
                ),
                Positioned(
                    bottom: 70,
                    left: -50,
                    child: ClipOval(
                      child: Container(
                        color: Color.fromARGB(99, 156, 131, 42),
                        height: size.height * 0.37,
                        width: size.width * 0.5,
                      ),
                    )),
                Positioned(
                    left: 50,
                    bottom: 270,
                    child: Text(
                      "WOOL STORAGE &",
                      style: GoogleFonts.irishGrover(fontSize: 30),
                    )),
                Positioned(
                    left: 50,
                    bottom: 230,
                    child: Text(
                      "WAREHOUSING",
                      style: GoogleFonts.irishGrover(fontSize: 30),
                    )),
                Positioned(
                  width: size.width * 0.87,
                  left: 50,
                  bottom: 80,
                  child: Text(
                    "Welcome to Woolify, the future of wool storage and management! Gone are the days of tedious manual labor and disorganized wool bales. With WoolHub, you’ll easily manage your entire wool inventory with just a few clicks.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                    maxLines: 7,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Slide5 extends StatelessWidget {
  const Slide5({
    super.key,
  });

  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomPaint(
          size: Size(
              size.width,
              (size.width * 0.45)
                  .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: RPSCustomPainter(),
        ),
        Expanded(
          child: SizedBox(
            // height: size.height * 0.68,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  child: SvgPicture.asset(
                    'assets/staters/slide5.svg',
                    height: size.height * 0.17,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 100,
                  child: SvgPicture.asset(
                    'assets/staters/slide5a.svg',
                    height: size.height * 0.2,
                  ),
                ),
                Positioned(
                    bottom: 70,
                    left: -50,
                    child: ClipOval(
                      child: Container(
                        color: Color.fromARGB(99, 156, 131, 42),
                        height: size.height * 0.37,
                        width: size.width * 0.5,
                      ),
                    )),
                Positioned(
                    left: 50,
                    bottom: 270,
                    child: Text(
                      "WOOLIFY",
                      style: GoogleFonts.irishGrover(fontSize: 30),
                    )),
                Positioned(
                    left: 50,
                    bottom: 230,
                    child: Text(
                      "MARKETPLACE",
                      style: GoogleFonts.irishGrover(fontSize: 30),
                    )),
                Positioned(
                  width: size.width * 0.87,
                  left: 50,
                  bottom: 80,
                  child: Text(
                    "Dive into the world of wool education and training like never before! Woolify helps wool producers and artisans level up their game by offering region-specific resources and tips to hone their skills.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                    maxLines: 7,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Slide6 extends StatelessWidget {
  const Slide6({
    super.key,
  });

  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomPaint(
          size: Size(
              size.width,
              (size.width * 0.45)
                  .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: RPSCustomPainter(),
        ),
        Expanded(
          child: SizedBox(
            // height: size.height * 0.68,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  child: SvgPicture.asset(
                    'assets/staters/slide6.svg',
                    height: size.height * 0.17,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 100,
                  child: SvgPicture.asset(
                    'assets/staters/slide6a.svg',
                    height: size.height * 0.2,
                  ),
                ),
                Positioned(
                    bottom: 70,
                    left: -50,
                    child: ClipOval(
                      child: Container(
                        color: Color.fromARGB(99, 156, 131, 42),
                        height: size.height * 0.37,
                        width: size.width * 0.5,
                      ),
                    )),
                Positioned(
                    left: 50,
                    bottom: 270,
                    child: Text(
                      "WOOL EDUCATION & ",
                      style: GoogleFonts.irishGrover(fontSize: 30),
                    )),
                Positioned(
                    left: 50,
                    bottom: 230,
                    child: Text(
                      "TRAINNING",
                      style: GoogleFonts.irishGrover(fontSize: 30),
                    )),
                Positioned(
                  width: size.width * 0.87,
                  left: 50,
                  bottom: 80,
                  child: Text(
                    "Dive into the world of wool education and training like never before! WoolWise helps wool producers and artisans level up their game by offering region-specific resources and tips to hone their skills.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                    maxLines: 7,
                  ),
                ),
                Positioned.fill(
                    // left: 170,
                    bottom: 10,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                          onPressed: () {
                            GoRouter.of(context)
                                .pushReplacementNamed("commonHomePage");
                          },
                          child: Text(
                            "Continue",
                            style: Theme.of(context).textTheme.bodyLarge,
                          )),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 98, 223, 223)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0150750, size.height * 0.0010571);
    path_0.lineTo(size.width * 0.2803333, size.height * 0.0041714);
    path_0.lineTo(size.width * 0.6039250, size.height * 0.5479857);
    path_0.lineTo(size.width * -0.0150750, size.height * 0.0010571);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
