import 'package:flutter/cupertino.dart';

import '../localDb/app_database.dart';

class OrderReturnProvider with ChangeNotifier {
  List<Map<String, dynamic>> showOrderProductValidData = [];

  List<dynamic> addProductList = [];

  Future<void> fetchOrderProductValidData(int liternary_id) async {
    print(" showOrderProductValidData = [];lpp.$liternary_id");
    final AppDatabase dataBase = AppDatabase.instance;
    try {
      final List<JoinedProductUsage> list  = await dataBase.getDetailedProductUsageForItinerary(liternary_id);
      if(list.isNotEmpty){
        showOrderProductValidData = [];
        for(JoinedProductUsage  item in list){
          print("prId.${item.product.id}");
          showOrderProductValidData.add(
              {
                'adQty' : item.adQty,
                'id': item.product.id,
                'productName': item.product.productName,
                'itemCode': item.product.itemCode,
                'salePrice': item.product.salesPrice,
              }
          );

        }
      }else{
        showOrderProductValidData = [];
      }



      notifyListeners();

      print("vbn length.${showOrderProductValidData.length}");

    } catch (e) {
    debugPrint("Error fetching product data: $e");
    }
  }

}