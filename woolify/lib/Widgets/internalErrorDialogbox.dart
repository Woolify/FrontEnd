import 'package:flutter/material.dart';

Widget showErrorDailogBox(BuildContext context) {
  return AlertDialog(
    content: SizedBox(
      // height: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(child: Text("Some Sever Internal Error Occured   :-(")),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"))
            ],
          )
        ],
      ),
    ),
  );
}
