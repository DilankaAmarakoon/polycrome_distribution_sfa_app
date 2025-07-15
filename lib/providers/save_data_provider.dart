import 'package:flutter/cupertino.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:polycrome_sales_application/localDb/app_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml_rpc/client_c.dart' as xml_rpc;

import '../constants/staticData.dart';
import '../reusableWidgets/showDialog.dart';

class SaveDataProvider with ChangeNotifier {
  final AppDatabase dataBase = AppDatabase.instance;

  bool isAlreadySynced =false;

  Future<dynamic> checkConnectionAndSaveData(BuildContext context,whenCheckOutAndSyncBtn) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final int? userId = pref.getInt("user_Id");
      final String? password = pref.getString("password");

      if (userId == null || password == null) {
        return false;
      }

      bool hasAnySyncedData = false;

      // Order Data
      final List<JoinedProductUsage> allOrderProductUsageList = await dataBase.getAllDetailedOrderProductUsage();
      final List<OrderProductUsageData> allOrderProductUsageDiscountList = await dataBase.getAllOrderProductUsage();
      int successOrderCount = 0;
      for (JoinedProductUsage usage in allOrderProductUsageList) {
        if (!usage.isSynced) {
          try {
            final String method = usage.odooId == 0 ? 'create' : 'write';
            final List<dynamic> requiredDataSet = usage.odooId == 0
                ? [
              {
                "order_id": usage.itineraryLineId,
                "product_id": usage.product.productId,
                "quantity": usage.adQty,
                "unit_price":usage.isFreeProduct ? 0.0 :  usage.product.salesPrice,
                "is_reward": usage.is_reward,
                "stock_lot_id": usage.stock_lot_id,
                "reward_amount": usage.reward_amount,
              }
            ]
                : [
              [usage.odooId],
              {
                "order_id": usage.itineraryLineId,
                "product_id": usage.product.productId,
                "quantity": usage.adQty,
                "unit_price":usage.isFreeProduct ? 0.0 :  usage.product.salesPrice,
                "is_reward": usage.is_reward,
                "stock_lot_id": usage.reward_amount,}
            ];
            final resultId = await xml_rpc.call(
              Uri.parse("$baseUrl/xmlrpc/2/object"),
              'execute_kw',
              [
                dbName,
                userId,
                password,
                'itinerary.order.line',
                method,
                requiredDataSet
              ],
            );
            print("aaawww..111$resultId");

            if (resultId != null && resultId != false) {
              print("aaacccccccc");
              successOrderCount++;
              hasAnySyncedData = true;
              await dataBase.updateIsSyncedTrueAndOdooIdOrderProductUsage(
                  id: usage.id, odooId: resultId);
            }
          } catch (e) {
            print("Error syncing orderddddd: $e");
          }
        }
      }
      for (OrderProductUsageData usage in allOrderProductUsageDiscountList) {
        if (!usage.isSynced) {
          print("aaa");
          try {
            final String method = usage.odooId == 0 ? 'create' : 'write';
            final List<dynamic> requiredDataSet = usage.odooId == 0
                ? [
              {
                "order_id": usage.itineraryLineId,
                "product_id": usage.productId,
                "quantity": usage.adQty,
                "unit_price": -usage.discountProductPrice,
                "is_reward": usage.is_reward,
                "stock_lot_id": usage.stock_lot_id,
                "discount": usage.discountProductPrice,
                "disount_prsentage": usage.discountPercentage,
                "is_discount": usage.isDiscountProduct,

              }
            ]
                : [
              [usage.odooId],
              {
                "order_id": usage.itineraryLineId,
                "product_id": usage.productId,
                "quantity": usage.adQty,
                "unit_price": -usage.discountProductPrice,
                "is_reward": usage.is_reward,
                "stock_lot_id": usage.stock_lot_id,
                "discount": usage.discountProductPrice,
                "disount_prsentage": usage.discountPercentage,
                "is_discount": usage.isDiscountProduct,
              }
            ];
            final resultId = await xml_rpc.call(
              Uri.parse("$baseUrl/xmlrpc/2/object"),
              'execute_kw',
              [
                dbName,
                userId,
                password,
                'itinerary.order.line',
                method,
                requiredDataSet
              ],
            );
            print("aaawww..111$resultId");

            if (resultId != null && resultId != false) {
              print("aaacccccccc");
              successOrderCount++;
              hasAnySyncedData = true;
              await dataBase.updateIsSyncedTrueAndOdooIdOrderProductUsage(
                  id: usage.id, odooId: resultId);
            }
          } catch (e) {
            print("Error syncing orderddddd: $e");
          }
        }
      }
      // Return Data
      // Return Data
      final List<JoinedReturnProductUsage> allReturnProductUsageList = await dataBase.getAllDetailedReturnProductUsage();
      int successReturnCount = 0;
      for (JoinedReturnProductUsage usage in allReturnProductUsageList) {
          if (!usage.isSynced) {
            print("return reason ....${usage.return_reason_id}");
            print("return reason ....${usage.return_action_id}");
            print("return reason ....${usage.return_reason}");
            try {
              final String method = usage.odooId == 0 ? 'create' : 'write';
              final List<dynamic> requiredDataSet = usage.odooId == 0
                  ? [
                {
                  "return_line_id": usage.itineraryLineId,
                  "product_id": usage.product.productId,
                  "quantity": usage.returnQty,
                  "total":  usage.product.salesPrice * usage.returnQty,
                  "return_action_id":usage.return_action_id,
                  "return_reason_id":usage.return_reason_id,
                  "return_reason":usage.return_reason,
                }
              ]
                  : [
                [usage.odooId],
                {
                  "return_line_id": usage.itineraryLineId,
                  "product_id": usage.product.productId,
                  "quantity": usage.returnQty,
                  "total":  usage.product.salesPrice * usage.returnQty,
                  "return_action_id":usage.return_action_id,
                  "return_reason_id":usage.return_reason_id,
                  "return_reason":usage.return_reason,
                }
              ];
              final resultId = await xml_rpc.call(
                Uri.parse("$baseUrl/xmlrpc/2/object"),
                'execute_kw',
                [
                  dbName,
                  userId,
                  password,
                  'itinerary.return.line',
                  method,
                  requiredDataSet
                ],
              );
              if (resultId != null && resultId != false) {
                successReturnCount++;
                hasAnySyncedData = true;
                await dataBase.updateIsSyncedTrueAndOdooIdReturnProductUsage(
                    id: usage.id, odooId: resultId);
              }
            } catch (e) {
              print("Error syncing returnsss: $e");
            }
          }
      }
      // Payment Data
      final List<PaymentUsageData> allPaymentUsageList = await dataBase
          .getAllPaymentUsageLines();
      int successPaymentCount = 0;
      for (PaymentUsageData usage in allPaymentUsageList) {
        if (!usage.isSynced) {
          try {
            final String method = usage.odooId == 0 ? 'create' : 'write';
            print("methodmethod..$method");
            final List<dynamic> requiredDataSet = usage.odooId == 0
                ? [
              {
                "payment_line_id": usage.payment_line_id,
                "payment_method": usage.payment_method,
                "invoice_id": usage.invoice_id,
                "invoice_amount": usage.invoice_amount,
                "date": usage.date,
                "cheque_number": usage.cheque_number,
                "cheque_date": usage.cheque_date == "" ? false : usage
                    .cheque_date,
                "amount": usage.amount,
              }
            ]
                : [
              [usage.odooId],
              {
                "payment_line_id": usage.payment_line_id,
                "payment_method": usage.payment_method,
                "invoice_id": usage.invoice_id,
                "invoice_amount": usage.invoice_amount,
                "date": usage.date,
                "cheque_number": usage.cheque_number,
                "cheque_date": usage.cheque_date == "" ? false : usage
                    .cheque_date,
                "amount": usage.amount,
              }
            ];
            final resultId = await xml_rpc.call(
              Uri.parse("$baseUrl/xmlrpc/2/object"),
              'execute_kw',
              [
                dbName,
                userId,
                password,
                'itinerary.payment.line',
                method,
                requiredDataSet
              ],
            );
            print("aaawww..555$resultId");
            if (resultId == true) {
              successPaymentCount++;
              hasAnySyncedData = true;
              await dataBase.updateIsSyncedTrueAndOdooIdPaymentProductUsage(
                id: usage.id,
                isSynced: true,
                odooId: null,
              );
            } else if (resultId is int && resultId != 0) {
              successPaymentCount++;
              hasAnySyncedData = true;
              await dataBase.updateIsSyncedTrueAndOdooIdPaymentProductUsage(
                id: usage.id,
                isSynced: true,
                odooId: resultId,
              );
            }
          } catch (e) {
            print("Error syncing payment: $e");
          }
        }
      }
      // location data
      final List<SalesPersonData> salesPersonDataIsVisitedList = await dataBase.getVisitedSalesPersonData();
         print("llllkk......$salesPersonDataIsVisitedList");
      for (SalesPersonData usage in salesPersonDataIsVisitedList) {
        print("noww...${usage.isSynced}");
        print("llllkk..hhhh....${usage.itinerary_line_id}");

        if (!usage.isSynced){
          try {
            final resultId = await xml_rpc.call(
              Uri.parse("$baseUrl/xmlrpc/2/object"),
              'execute_kw',
              [
                dbName,
                userId,
                password,
                'distribution.itinerary.line',
                'write',
                [
                  [usage.itinerary_line_id],
                  {
                    "itinerary_latitude": usage.itinerary_latitude,
                    "itinerary_longitude": usage.itinerary_longitude,
                    "visit_status": usage.visit_status,
                  }
                ]
              ],
            );
            print("resultIdresultId,,,,,$resultId");
            if(resultId == true){
              await AppDatabase.instance.updateIsSyncedSalesPersonData(itinerary_line_id: usage.itinerary_line_id,isSynced: true);
            }
          } catch (e) {
            print("Error syncing orderddddd: $e");
          }
      }
    }
      return true;
    } catch (e) {
      print("Error in saveData: $e");
      return false;
    }
  }
}
