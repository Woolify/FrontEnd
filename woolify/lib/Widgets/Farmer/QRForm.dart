import 'package:flutter/material.dart';
import 'package:woolify/ServerRoutes/ApiServicesFarmer.dart';
import 'package:woolify/Widgets/Farmer/ShowShipData.dart';
import 'package:woolify/Widgets/Farmer/updateShipData.dart';

class QRForm extends StatefulWidget {
  const QRForm({super.key, required this.url});
  final String url;
  @override
  State<StatefulWidget> createState() {
    return _ORForm();
    throw UnimplementedError();
  }
}

class _ORForm extends State<QRForm> {
  Map<String, dynamic>? data;
  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  getData() async {
    var res = await ApiServicersFarmer.checkQRData(widget.url);
    if (res['status'] == "success") {
      if (res['data']!['animal']['deleted'] == true) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("QR is Already deleted")));
        Navigator.of(context).pop();
        return;
      }
      setState(() {
        data = res['data'];
      });
    }
  }

  Widget build(context) {
    return data == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : data!['animal']['saveAsDraft'] == true
            ? UpdateShipData(data: data)
            : ShowShipData(data: data);
  }
}
