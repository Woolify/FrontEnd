import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:developer' as developer;

class FarmerModel {
  String? firstName;
  String? lastName;
  String? role;
  String? username;
  String? password;
  String? confirmPassword;
  String? phone;

  String? email;

  FarmerModel({
    this.firstName,
    this.lastName,
    this.role,
    this.username,
    this.password,
    this.confirmPassword,
    this.phone,
    this.email,
  });

  FarmerModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    role = json['role'];

    username = json['username'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['role'] = this.role;

    data['username'] = this.username;
    data['password'] = this.password;
    data['confirmPassword'] = this.confirmPassword;
    data['phone'] = this.phone;
    data['email'] = this.email;

    return data;
  }

  static Future<Map<String, dynamic>> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission asked = await Geolocator.requestPermission();
      if (asked == LocationPermission.denied ||
          asked == LocationPermission.deniedForever) {
        developer.log('location permisiion denied');

        return {};
      }
    }
    Position currPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    List<Placemark> placemarks = await placemarkFromCoordinates(
        currPosition.latitude, currPosition.longitude);

    developer.log(currPosition.latitude.toString() +
        " " +
        currPosition.longitude.toString());
    if (placemarks.isNotEmpty) {
      return {
        "latitude": currPosition.latitude.toString(),
        "longitude": currPosition.longitude.toString(),
        'state': placemarks[0].administrativeArea.toString(),
        'city': placemarks[0].locality.toString(),
        'pincode': placemarks[0].postalCode.toString()
      };
    }
    return {"lat": currPosition.latitude, "lon": currPosition.longitude};
  }
}
