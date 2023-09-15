import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommonHomePageFeatureCard extends StatelessWidget {
  const CommonHomePageFeatureCard(
      {super.key, required this.image, required this.title});
  final String image;
  final String title;

  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 150,
      width: size.width * 0.9,
      child: Stack(children: [
        Positioned(
            top: 35,
            left: 20,
            child: Material(
              child: Container(
                height: 50,
                width: size.width * 0.4,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.3),
                          offset: const Offset(-10.0, 10),
                          blurRadius: 20.0,
                          spreadRadius: 4.0)
                    ]),
              ),
            )),
        Positioned(
            top: 0,
            left: 0,
            // bottom: 10,
            child: Card(
              // elevation: 10.0,
              // shadowColor: Colors.grey.withOpacity(0.5),
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(15.0)),
              child: Container(
                height: 080,
                width: size.width * 0.15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/staters/$image'))),
              ),
            )),
        Positioned(
            top: 50,
            left: 100,
            child: Container(
              child: Column(children: [Text(title)]),
            ))
      ]),
    );
  }
}
