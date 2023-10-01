import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class buttonRow2 extends StatelessWidget {
  const buttonRow2(
      {super.key,
      required this.HigestBid,
      required this.basePrice,
      required this.marketPrice});
  final String basePrice;
  final String marketPrice;
  final String HigestBid;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text("Base",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
            Text("Price",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary))
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
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 3,
            ),
            Text("Higest",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
            Text("Bid",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary))
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
            Image.asset(
              'assets/vendor/marketPrice.png',
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "₹ $marketPrice",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 3,
            ),
            Text("Market",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
            Text("Price",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary))
          ],
        ),
      ),
    ]);
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
