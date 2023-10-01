import 'dart:convert';
import 'dart:io';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:http/http.dart' as http;
import 'package:woolify/Model/Animal.dart';
import 'package:woolify/Model/Auction.dart';
import 'package:woolify/Model/Inventory.dart';
import 'dart:developer' as developer;
import 'package:woolify/ServerRoutes/ServerDetails.dart';
import 'package:woolify/ServerRoutes/ServerDetails.dart';
import 'package:woolify/SharedPreference.dart';

class ApiServicersFarmer {
  static Future<Map<String, String>> generateNewQRs(
      {required String count}) async {
    try {
      developer.log("ssss");
      var res = await http.post(
          Uri.parse(ServerDetails.serverRoute + "/api/farmer/generate-qr"),
          headers: {
            'authorization': mySharedPreference.pref.getString('token')!
          },
          body: {
            "count": count
          });

      // developer.log(res.body);
      if (res.statusCode == 200) {
        developer.log(res.body);
        List<String>? list = mySharedPreference.pref.getStringList('pdfUrl');
        if (list == null || list.isEmpty) {
          mySharedPreference.pref
              .setStringList('pdfUrl', [jsonDecode(res.body)['pdfUrl']]);
        } else {
          list.add(jsonDecode(res.body)['pdfUrl']);
          mySharedPreference.pref.setStringList('pdfUrl', list);

          developer.log(
              mySharedPreference.pref.getStringList('pdfUrl').toString(),
              name: "urls list");
        }
        return {"status": "success"};
      } else {
        return {"status": "fail"};
      }
    } catch (e) {
      developer.log(e.toString(), name: "generateQR");
      return {"status": "fail"};
    }
  }

  static Future<Map<String, dynamic>> checkQRData(String url) async {
    try {
      url = url.replaceAll('localhost', ServerDetails.ip);

      var res = await http.get(Uri.parse(url), headers: ServerDetails.token);
      if (res.statusCode == 200) {
        developer.log(res.body);
        var data = jsonDecode(res.body);
        data['url'] = url;

        return {
          "data": data,
          "status": "success",
        };
      } else {
        return {"status": "fail"};
      }
    } catch (e) {
      developer.log(e.toString(), name: "in checkQR data");
      return {"status": "fail"};
    }
  }

  static Future<Map<String, dynamic>> updateAnimalDetails(
      String url, AnimalData data) async {
    try {
      developer.log(data.toJson().toString(), name: "See here data");
      var res = await http.put(Uri.parse(url),
          headers: ServerDetails.token, body: data.toJson());
      developer.log(res.body, name: "2222");
      if (res.statusCode == 200) {
        developer.log(res.body);
        return {"status": "success"};
      } else {
        developer.log(res.body, name: "update Animal");
        return {"status": "fails"};
      }
    } catch (e) {
      developer.log(e.toString(), name: "Upadate Animal");
      return {'status': 'fail'};
    }
  }

  static Future<Map<String, dynamic>> getAnimalData(String url) async {
    try {
      var res = await http.get(Uri.parse(url), headers: ServerDetails.token);
      developer.log(res.body, name: "get Data");
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);

        return {"status": "success", "data": jsonDecode(res.body), 'url': url};
      } else {
        developer.log(res.body, name: "getShipData");
        return {
          "status": "fail",
        };
      }
    } catch (e) {
      developer.log(e.toString(), name: "getShipData");
      return {
        "status": "fail",
      };
    }
  }

  static Future<Map<String, dynamic>> deleteAnimal(String url) async {
    try {
      var res = await http.delete(Uri.parse(url), headers: ServerDetails.token);
      developer.log(res.body, name: 'delete Animal');
      if (res.statusCode == 200) {
        return {"status": "success"};
      } else {
        return {"status": "fail"};
      }
    } catch (e) {
      developer.log(e.toString());
      return {"status": "fail"};
    }
  }

  static Future<Map<String, dynamic>> addToInventory(
      InventoryModel model) async {
    // try {
    developer.log(model.toJson().toString());
    var data = await http.post(
        Uri.parse(ServerDetails.serverRoute + "/api/farmer/inventory"),
        headers: ServerDetails.token,
        body: model.toJson());
    if (data.statusCode == 200) {
      developer.log(ServerDetails.token.toString(), name: "token");
      developer.log(data.body, name: "Add to inventory");
      return {"status": "success"};
    } else {
      developer.log(data.body, name: "Add To Inventory 404");
      return {"status": "fail"};
    }
    // } catch (e) {
    //   developer.log(e.toString(), name: "Add To Inventory exception");
    //   return {"status": "fail"};
    // }
  }

  static Future<Map<String, dynamic>> getInventory() async {
    try {
      developer.log(ServerDetails.token.toString());
      var res = await http.get(
          Uri.parse(ServerDetails.serverRoute + "/api/farmer/inventory"),
          headers: ServerDetails.token);

      if (res.statusCode == 200) {
        developer.log("Sss");
        developer.log(res.body);

        var data = jsonDecode(res.body);

        InventoryModel.generateInventoryStock(data);
        return {'status': 'success', 'data': data};
      } else {
        developer.log(res.body, name: "getInventory server");
        return {'status': 'fail'};
      }
    } catch (e) {
      developer.log(e.toString(), name: "get Inventory exception");
      return {"status": "fail"};
    }
  }

  static Future<Map<String, dynamic>> raiseAuction(
      AuctionModel data, File image) async {
    try {
      String InventoryId = InventoryModel.getInventoryId(data.typeOfWool!);
      developer.log(data.toJson().toString());
      final multipartFile =
          await http.MultipartFile.fromPath('woolImg', image.path);
      var req = http.MultipartRequest(
          'POST', Uri.parse(ServerDetails.serverRoute + "/api/bid/"));
      req.headers.addAll(ServerDetails.token);
      // req.fields.
      req.fields['basePrice'] = data.basePrice.toString();
      req.fields['quantity'] = data.quantity.toString();
      req.fields['inventory'] = InventoryId.toString();
      req.fields['typeOfWool'] = data.typeOfWool.toString();
      req.fields['descp'] = data.descp.toString();
      req.files.add(multipartFile);
      developer.log(req.fields['quantity'].toString());
      var res = await req.send();

      if (res.statusCode == 200) {
        return {'status': 'success'};
      } else {
        developer.log(await res.stream.bytesToString(),
            name: "raise auction sever fetal");
        return {'status': 'fail'};
      }
    } catch (e) {
      developer.log(e.toString(), name: 'raise Auction exception');
      return {'status': 'fail'};
    }
  }

  static Future<List> getOpenAuction() async {
    try {
      print("fetching");
      var res = await http.get(
          Uri.parse(ServerDetails.serverRoute + "/api/bid/list"),
          headers: ServerDetails.token);
      print("fetched");
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        return data['auctions'];
      } else {
        developer.log(res.body);
        return [];
      }
    } catch (e) {
      developer.log(e.toString(),
          name: "Exception fetal in getAuctionForVendro");
      return [];
    }
  }

  static Future<Map> confrimBid({
    required String auctionId,
    required String bidID,
  }) async {
    try {
      var res = await http.put(
          Uri.parse(ServerDetails.serverRoute + "/api/bid/confirm/$auctionId"),
          body: {'bidId': bidID},
          headers: ServerDetails.token);
      if (res.statusCode == 200) {
        developer.log(res.body);
        return {"status": "success"};
      } else {
        developer.log(res.body, name: "Server Fatal in confrimBid");
        return {'status': "fail"};
      }
    } catch (e) {
      developer.log(e.toString(), name: "Exception Fatal in confrimBid");
      return {'status': "fail"};
    }
  }

  static Future<List> getAuctionListForFarmer({bool result = false}) async {
    try {
      print("fetching");
      var res = await http.get(
          Uri.parse(ServerDetails.serverRoute +
              "/api/farmer/bids/list?status=$result"),
          headers: ServerDetails.token);
      print("fetched");
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        return data['auctions'];
      } else {
        developer.log(res.body);
        return [];
      }
    } catch (e) {
      developer.log(e.toString(),
          name: "Exception fetal in getAuctionForVendro");
      return [];
    }
  }

  static Future<Map> getAllAnimalData() async {
    try {
      developer.log("calal");
      var res = await http.get(
          Uri.parse(ServerDetails.serverRoute + "/api/farmer/animals"),
          headers: ServerDetails.token);
      if (res.statusCode == 200) {
        // developer.log(res.body);
        return jsonDecode(res.body);
      } else {
        return {};
      }
    } catch (e) {
      developer.log(e.toString(), name: "Excep in getanimal");
      return {};
    }
  }
}
