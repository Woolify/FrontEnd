import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:developer' as developer;
import 'package:permission_handler/permission_handler.dart';
import 'package:woolify/Router/NamedRoutes.dart';

class ScanQR extends StatefulWidget {
  ScanQR({super.key});
  @override
  State<ScanQR> createState() {
    return _ScanQR();
  }
}

class _ScanQR extends State<ScanQR> {
  bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  String result = "";
  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Scan QR"),
        leading: IconButton(
          icon: Icon(Icons.back_hand),
          onPressed: () {},
        ),
        actions: const [
          const Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(Icons.qr_code),
          )
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          Container(
            height: size.height * 0.7,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(children: [
                  const Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                    child: Text(
                      "QR codes can provide more information about the product or service ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Lottie.asset(
                    "assets/farmer/Animation - 1694799173493.json",
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      var res = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const SimpleBarcodeScannerPage(),
                          ));
                      setState(() {
                        developer.log(res);
                        if (res != "-1") {
                          GoRouter.of(context).pushNamed(FarmerRoutes.QRForm,
                              pathParameters: {"url": res});
                          result = res;
                        }
                      });
                    },
                    child: const Text('Open Scanner'),
                  ),
                ]),
              ),
            ),
          )
        ],
      )),
    );
  }
}
