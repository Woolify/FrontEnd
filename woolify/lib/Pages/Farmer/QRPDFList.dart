import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:woolify/ServerRoutes/ServerDetails.dart';
import 'package:woolify/SharedPreference.dart';

import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class QRpdfList extends StatelessWidget {
  const QRpdfList({super.key});
  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    List<String>? data = mySharedPreference.pref.getStringList('pdfUrl');
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF LIST"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: data == null || data.isEmpty
            ? Center(
                child: Text("NO PDFS CREATED"),
              )
            : Container(
                height: size.height,
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          try {
                            await launchUrl(Uri.parse(data[index]
                                .replaceAll("localhost", ServerDetails.ip)));
                          } catch (e) {
                            print(e.toString());
                          }
                        },
                        child: ListTile(
                          trailing: Icon(Icons.qr_code),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          tileColor: Colors.green,
                          leading: Icon(Icons.report),
                          title: Text("PDF ${index + 1}"),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
