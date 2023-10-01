import 'package:flutter/material.dart';

enum sheepCategoryList {
  sheep,
  goat,
  camel,
  yak,
  cashmere,
}

enum woolColor {
  white,
  black,
  grey,
  brown,
  tan,
  beige,
  cream,
  fawn,
  chocolate,
  russet,
  silver
}

class AnimalData {
  String? breed;
  String? nickName;
  String? age;
  String? weight;
  String? lastShread;
  String? type;

  String? descp;
  AnimalData(
      {this.nickName,
      this.age,
      this.weight,
      this.lastShread,
      this.type,
      this.breed,
      this.descp});

  AnimalData.fromJson(Map<String, dynamic> json) {
    nickName = json['nickName'];
    age = json['age'];
    weight = json['weight'];
    lastShread = json['lastShread'];
    type = json['type'];
    breed = json['breed'];
    descp = json['descp'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickName'] = this.nickName;
    data['age'] = this.age;
    data['weight'] = this.weight;
    data['lastShread'] = this.lastShread;
    data['type'] = this.type;
    data['breed'] = this.breed;
    data['descp'] = this.descp;
    return data;
  }

  // static Map<sheepCategoryList, Color> colorSchemeForAnimals = {
  //   sheepCategoryList.LohiSheep: Colors.amber,
  //   sheepCategoryList.GaddiSheep: Colors.green,
  //   sheepCategoryList.Marwari: Colors.blue,
  //   sheepCategoryList.Bonpola: Colors.brown,
  //   sheepCategoryList.Deccani: Colors.red,
  //   sheepCategoryList.Kenguri: Colors.pink
  // };

  // static Map<sheepCategoryList, int> getAllAnimalsList() {
  //   return {
  //     sheepCategoryList.LohiSheep: 70,
  //     sheepCategoryList.GaddiSheep: 60,
  //     sheepCategoryList.Marwari: 40,
  //     sheepCategoryList.Bonpola: 50,
  //     sheepCategoryList.Deccani: 10,
  //     sheepCategoryList.Kenguri: 20
  //   };
  // }

  // static int totalAnimals() {
  //   int sum = 0;
  //   getAllAnimalsList().forEach((key, value) {
  //     sum = sum + value;
  //   });
  //   return sum;
  // }
}
