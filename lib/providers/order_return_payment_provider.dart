import 'package:flutter/cupertino.dart';

import '../localDb/app_database.dart';

class OrderReturnPaymentProvider with ChangeNotifier {
  List<Map<String, dynamic>> showOrderProductValidData = [];
  List<Map<String, dynamic>> showReturnProductValidData = [];
  List<Map<String, dynamic>> showPaymentValidData = [];


  Future<void> fetchOrderProductValidData(int liternary_id) async {
    print(" showOrderProductValidData = [];lpp.$liternary_id");
    final AppDatabase dataBase = AppDatabase.instance;
    try {
      final List<JoinedProductUsage> list  = await dataBase.getDetailedOrderProductUsage(liternary_id);

      print("added Db List.$list");
      print("added Db length.$list");
      if(list.isNotEmpty){
        showOrderProductValidData = [];
        for(JoinedProductUsage  item in list){
          print("prId.${item.product.id}");
          showOrderProductValidData.add(
              { "id" : item.product.id,
                'adQty' : item.adQty,
                'productName': item.product.productName,
                "display_name":item.product.displayName,
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
  Future<void> fetchReturnProductValidData(int liternary_id) async {
    print(" showReturnProductValidData pp.$liternary_id");
    final AppDatabase dataBase = AppDatabase.instance;
    try {
      final List<JoinedReturnProductUsage> list  = await dataBase.getDetailedReturnProductUsage(liternary_id);

      print("lenjjj.${list.length}");
      if(list.isNotEmpty){
        showReturnProductValidData = [];
        for(JoinedReturnProductUsage  item in list){
          print("prId.${item.product.id}");
          showReturnProductValidData.add(
              { "id" : item.product.id,
                'adQty' : item.returnQty,
                'productName': item.product.productName,
                "display_name":item.product.displayName,
                'salePrice': item.product.salesPrice,
              }
          );

        }
      }else{
        showReturnProductValidData = [];
      }
      notifyListeners();
      print("return produc valid length.${showReturnProductValidData.length}");

    } catch (e) {
    debugPrint("Error fetching product data: $e");
    }
  }
  Future<void> fetchPaymentValidData(int liternary_id) async {
    final AppDatabase dataBase = AppDatabase.instance;
    try {
      final List<ItineraryPaymentLineData> list  = await dataBase.getItineraryPaymentLinesByPaymentLineId(liternary_id);
    print("lenjjj.${list.length}");
      if(list.isNotEmpty){
        showPaymentValidData = [];
        for(ItineraryPaymentLineData  item in list){
          showPaymentValidData.add(
              {
                "id" : item.itinerary_payment_line_id,
                'payment_line_id' : item.payment_line_id,
                'date': item.date,
                "invoice_id":item.invoice_id,
                "invoice_name":item.invoice_name,
                'invoice_date': item.invoice_date,
                'payment_method': item.payment_method,
                'cheque_number': item.cheque_number,
                'cheque_date': item.cheque_date,
                'amount': item.amount,
                'invoice_amount': item.invoice_amount,
              }
          );

        }
      }else{
        showPaymentValidData = [];
      }
      notifyListeners();
      print("return showPaymentValidData length.${showPaymentValidData.length}");

    } catch (e) {
    debugPrint("Error fetching product data: $e");
    }
  }

}