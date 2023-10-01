class InventoryModel {
  String? quantity;
  String? typeOfWool;
  String? color;
  String? inventoryId;

  InventoryModel(
      {this.quantity, this.typeOfWool, this.color, this.inventoryId});

  InventoryModel.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    typeOfWool = json['typeOfWool'];
    color = json['color'];
    inventoryId = json['inventoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['typeOfWool'] = this.typeOfWool;
    data['inventoryId'] = this.inventoryId;
    data['color'] = this.color;
    return data;
  }

  static List<Map<String, dynamic>> inventoryStock = [];
  static double totalInventoryQuantity = 0;
  static double totalListedWool = 0;
  static int totalTypeOfWool = 0;

  static String getInventoryId(String type) {
    if (inventoryStock.isNotEmpty) {
      for (var e in inventoryStock) {
        if (e['typeOfWool'] == type) {
          return e['inventoryId'];
        }
      }
    }
    return '';
  }

  static void generateInventoryStock(dynamic data) {
    if (data.isNotEmpty) {
      inventoryStock = [
        {'typeOfWool': 'All', 'totalQuantity': data[0]['totalQuantity']}
      ];
      totalTypeOfWool = 0;
      totalInventoryQuantity = 0;
      totalListedWool = 0;
      for (Map<String, dynamic> element in data[0]['inventoryData']) {
        inventoryStock.add(element);
      }
      // }
      totalInventoryQuantity = data[0]['totalQuantity'].toDouble();
      totalTypeOfWool = data[0]['totalTypeOfWool'];
      totalListedWool = data[0]['totalListed'].toDouble();
    }

    print(inventoryStock);
  }
}
