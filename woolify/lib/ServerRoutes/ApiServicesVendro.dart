import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:woolify/ServerRoutes/ServerDetails.dart';
import 'dart:developer' as developer;

class ApiServicesVendor {
  static Future<List> getAuctionListForMarket() async {
    try {
      print("fetching");
      developer.log(ServerDetails.serverRoute + "/api/bid/list?status=false");
      var res = await http.get(
          Uri.parse(ServerDetails.serverRoute + "/api/bid/list?status=false"),
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

  static Future<Map> getAuctionData({required String auctionId}) async {
    try {
      var res = await http.get(
          Uri.parse(ServerDetails.serverRoute + "/api/bid/$auctionId"),
          headers: ServerDetails.token);
      if (res.statusCode == 200) {
        developer.log(res.body, name: "Got auction dtata");
        return jsonDecode(res.body);
      } else {
        developer.log(res.body, name: "Serevr fatel in getAutionData");
        return {};
      }
    } catch (e) {
      developer.log(e.toString(), name: "Exception Fetal in GetAuction");
      return {};
    }
  }

  static Future<Map<String, dynamic>> raiseBid(
      Map<String, dynamic> data) async {
    try {
      var res = await http.post(
          Uri.parse(ServerDetails.serverRoute + "/api/bid/add/${data['_id']}"),
          headers: ServerDetails.token,
          body: data);
      if (res.statusCode == 200) {
        developer.log(res.body);
        return {"status": "success"};
      } else {
        developer.log(res.body, name: "Server Fetal raiseBid");
        return {"status": "fail"};
      }
    } catch (e) {
      developer.log(e.toString(), name: "Exception Fetal raiseBid");
      return {"status": "fail"};
    }
  }

  static Future<List> getBiddedAuctionListForVendor() async {
    try {
      print("fetching");
      developer.log(ServerDetails.token.toString());
      var res = await http.get(
          Uri.parse(ServerDetails.serverRoute +
              "/api/vendor/auction/list?status=true"),
          headers: ServerDetails.token);
      print("fetched");
      if (res.statusCode == 200) {
        developer.log(res.body);
        var data = jsonDecode(res.body);
        return data;
      } else {
        developer.log(res.body);
        return [];
      }
    } catch (e) {
      developer.log(e.toString(),
          name: "Exception fetal in getAuctionForVendro f");
      return [];
    }
  }
}
