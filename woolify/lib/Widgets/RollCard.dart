import 'package:flutter/material.dart';

class RollCard extends StatelessWidget {
  const RollCard(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.navigate});
  final void Function() navigate;
  final String image;
  final String title;
  final String subTitle;
  Widget build(context) {
    return InkWell(
      onTap: navigate,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: CircleAvatar(
                  // backgroundColor: ,
                  radius: 60,
                  backgroundImage: AssetImage(image),
                ),
              ),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 20),
              ),
              Text(
                subTitle,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Center(
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.info,
                        size: 20,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
