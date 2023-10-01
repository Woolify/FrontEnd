import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class buttonRow extends StatelessWidget {
  const buttonRow(
      {super.key,
      required this.HigestBid,
      required this.basePrice,
      required this.marketPrice});
  final String basePrice;
  final String marketPrice;
  final String HigestBid;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        MaterialButton(
          onPressed: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/vendor/tag.png'),
              SizedBox(
                height: 5,
              ),
              Text(
                "₹ " + basePrice,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Text("Base"),
              Text("Price")
            ],
          ),
        ),
        VerticalDivider(
          color: Theme.of(context).dividerColor,
          thickness: 1,
          indent: 40,
          endIndent: 30,
        ),
        MaterialButton(
          onPressed: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/vendor/bid.png'),
              SizedBox(
                height: 5,
              ),
              Text(
                "₹ " + HigestBid,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 3,
              ),
              Text("Higest"),
              Text("Bid")
            ],
          ),
        ),
        VerticalDivider(
          color: Theme.of(context).dividerColor,
          thickness: 1,
          indent: 40,
          endIndent: 30,
        ),
        MaterialButton(
          onPressed: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/vendor/marketPrice.png',
                  width: 40, height: 40),
              SizedBox(
                height: 5,
              ),
              Text(
                "₹ $marketPrice",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 3,
              ),
              Text("Market"),
              Text("Price")
            ],
          ),
        ),
      ]),
    );
  }

  Widget buildButton(BuildContext context, String value, String text,
      {String text2 = ""}) {
    var button = MaterialButton(
      onPressed: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.fire_truck),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 3,
          ),
          Text(text),
          text2 == "" ? Text('') : Text(text2),
        ],
      ),
    );
    return button;
  }
}
