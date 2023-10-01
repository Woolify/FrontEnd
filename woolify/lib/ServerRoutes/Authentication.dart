import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woolify/Model/Farmer.dart';
import 'package:http/http.dart' as http;
import 'package:woolify/Router/NamedRoutes.dart';
import 'package:woolify/ServerRoutes/ServerDetails.dart';
import 'package:woolify/SharedPreference.dart';

class ServerAuthenticationRoutes {
  static Future<FarmerModel?> farmerRegisteration(
      FarmerModel model, Map<String, dynamic> location) async {
    try {
      Map<String, dynamic> body = model.toJson();
      body.addAll(location);

      developer.log(body.toString());
      var data = await http.post(
          Uri.parse(ServerDetails.serverRoute + "/api/user/auth/register"),
          body: body);
      print("heheh");
      developer.log(data.body.toString(), name: "see here");
      if (data.statusCode == 200) {
        await http.post(
            Uri.parse(ServerDetails.serverRoute + "/api/user/auth/send-otp"),
            body: {"phone": model.phone});
      }

      if (data.statusCode == 404) {
        developer.log(data.body.toString() + "   null");
        return null;
      }
      ;
      return FarmerModel.fromJson(jsonDecode(data.body));
    } catch (e) {
      developer.log(e.toString(), name: "Error");
      return null;
    }
  }

  static Future<String> verifyOtp(
      {required String phone, required String pin}) async {
    try {
      developer.log("message");
      var res = await http.post(
          Uri.parse(ServerDetails.serverRoute + "/api/user/auth/verify-otp"),
          body: {"phone": phone, "otp": pin});
      if (res.statusCode == 404) {
        return "error";
      } else if (res.statusCode == 200) {
        return "success";
      }
      developer.log(res.body);

      return "";
    } catch (e) {
      return "";
    }
  }

  static Future<Map<String, String>> login(
      String username, String password) async {
    try {
      developer.log(username + " " + password);
      var data = await http.post(
          Uri.parse(ServerDetails.serverRoute + "/api/user/auth/login"),
          body: {"username": username, "password": password});
      Map<String, dynamic> res = jsonDecode(data.body);
      if (data.statusCode == 404 || res['success'] != true) {
        developer.log("wrong creds");
        return {"status": "fail", "res": "wrong creds"};
      }

      if (res['user']['role'] == "farmer") {
        await mySharedPreference.pref.setString("token", res['token']!);
        print(mySharedPreference.pref.getString('token').toString());
        await mySharedPreference.pref.setString("id", res['user']['_id']!);
        await mySharedPreference.pref.setString("role", "farmer");
      } else if (res['user']['role'] == "vendor") {
        await mySharedPreference.pref.setString("token", res['token']!);
        await mySharedPreference.pref.setString("id", res['user']['_id']!);
        await mySharedPreference.pref.setString("role", "vendor");
      }
      // Add Other Roles Here
      //
      return {"status": "success", "role": res['user']['role']};
    } catch (e) {
      developer.log(e.toString(), name: "login");
      return {"status": "fail", "res": e.toString()};
    }
  }

  static void redirectUser(BuildContext context, String role) {
    if (role == "farmer") {
      print("heh");
      GoRouter.of(context).pushReplacementNamed(FarmerRoutes.homePage);
    } else if (role == "vendor") {
      print('object');
      // Navigator.of
      GoRouter.of(context).pushReplacementNamed(VendorRoutes.homePage);
    }
  }
}
