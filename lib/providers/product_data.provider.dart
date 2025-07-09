import 'package:flutter/cupertino.dart';

import '../localDb/app_database.dart';

class ProductDataProvider with ChangeNotifier {
  final AppDatabase dataBase = AppDatabase.instance;
  List<Map<String, dynamic>> categoryShowData = [];
  List<Map<String, dynamic>> _productDataSearchValidData = [];

  List<Map<String, dynamic>> get ProductDataSearchValidData => _productDataSearchValidData;

  set setProductDataSearchValidData(List<Map<String, dynamic>> value) {
    _productDataSearchValidData = value;
    notifyListeners();
  }


  fetchcatergoryData() async {
    categoryShowData = [];
    final List<ProductCategoryData> list  = await dataBase.getAllCategories();
    categoryShowData = list.map((item) => {
      'id': item.categoryId,
      'name' :item.displayName,
    }).toList();
  }
}