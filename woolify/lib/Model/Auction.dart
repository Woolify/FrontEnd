class AuctionModel {
  String? basePrice;
  String? quantity;
  String? typeOfWool;
  String? descp;
  String? woolImg;

  AuctionModel(
      {this.basePrice,
      this.quantity,
      this.typeOfWool,
      this.descp,
      this.woolImg});

  AuctionModel.fromJson(Map<String, dynamic> json) {
    basePrice = json['basePrice'];
    woolImg = json['woolImg'];
    quantity = json['quantity'];
    typeOfWool = json['typeOfWool'];
    descp = json['descp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['basePrice'] = this.basePrice;
    data['quantity'] = this.quantity;
    data['woolImg'] = this.woolImg;
    data['typeOfWool'] = this.typeOfWool;
    data['descp'] = this.descp;
    return data;
  }
}
