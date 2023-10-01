import 'package:woolify/Model/Animal.dart';

class myFilters {
  static List<Map<String, bool>> filtesList = sheepCategoryList.values
      .map((sheepCategoryList e) => {e.name: false})
      .toList();
}
