import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml_rpc/client_c.dart' as xml_rpc;
import '../constants/staticData.dart';
import '../localDb/app_database.dart';

class ItineraryDataHandle with ChangeNotifier {
  bool _isVisibleCheckIn = false;
  bool _isVisited = false;
  bool get isVisibleCheckIn => _isVisibleCheckIn;
  bool get isVisited => _isVisited;
  int company_id = 0;
  int  empId = 0;
  int itineraryIds = 0;
  double _startMileage = 0.0;
  double _endMileage = 0.0;

  double get startMileage => _startMileage;
  double get endMileage => _endMileage;

  List<Map<String, dynamic>> convertItineraryDbData = [];
  List<Map<String, dynamic>> outletVisitStatusList =[];
  DateTime todayDate = DateTime.now();
   // String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String formattedDate = "2025-06-26";
  final AppDatabase dataBase = AppDatabase.instance;


  void setIsisVisibleCheckIn(bool value) {
    _isVisibleCheckIn = value;
    notifyListeners();
  }
  void setIsVisited(bool value, int index) {
    convertItineraryDbData[index]["isVisited"] = value;
    notifyListeners();
  }
  void setStartMileage(double startMileage) {
    _startMileage = startMileage;
    notifyListeners();
  }

  void setEndMileage(double endMileage) {
    _endMileage = endMileage;
    notifyListeners();
  }


  Future<List<dynamic>> salesPersonData() async {
    print("userIduserId..ssssss.$formattedDate");
    try {
      final pref = await SharedPreferences.getInstance();
      final userId = pref.getInt("user_Id");
      final password = pref.getString("password");
      print("userIduserId..$userId");
      if (userId == null || password == null) return [];

      final resPartnerData = await xml_rpc.call(
        Uri.parse("$baseUrl/xmlrpc/2/object"),
        'execute_kw',
        [
          dbName,
          userId,
          password,
          'res.partner',
          'search_read',
          [
            [
               ['user_ids', '=', userId],
            ]
          ],
          {'fields': ['id', 'name', 'company_id', 'route_id', 'territory_id','credit','credit_period'],},
        ],
      );
      for(dynamic item in resPartnerData){
        if(item["user_ids"].toString() == userId.toString()){
          print("qrrttt...$item");
        }
      }
      if (resPartnerData.isEmpty) return [];
      company_id = resPartnerData[0]["company_id"][0];
      return resPartnerData;
    } catch (e) {
      print("Error in itineraryDatahhh: $e");
      return [];
    }
  }

  Future<String> itineraryData() async {
     dataBase.clearAllData();
     dataBase.clearOrderProductUsage();
     dataBase.clearReturnProductUsage();
     dataBase.clearAllInvoiceDataLines();
     dataBase.clearAllItineraryPaymentLines();
     dataBase.clearAllPaymentUsageLines();
     dataBase.clearProductMaster();
     dataBase.clearAllCategories();
     dataBase.clearAllLoyaltyFreeIssueData();
     dataBase.clearAllDiscountData();
     dataBase.clearAllResPartnerDataLines();
     dataBase.clearAllVisitStatusData();
    try {
      final pref = await SharedPreferences.getInstance();
      final userId = pref.getInt("user_Id");
      final password = pref.getString("password");
      if (userId == null || password == null) return "User credentials not found";
      final employeeData = await xml_rpc.call(
        Uri.parse("$baseUrl/xmlrpc/2/object"),
        'execute_kw',
        [
          dbName,
          userId,
          password,
          'hr.employee',
          'search_read',
          [
            [
              ['user_id', '=', userId],
              ['company_id', '=', company_id],
            ]
          ],
          {'fields': ['id'], 'limit': 1},
        ],
      );

      if (employeeData.isEmpty) return "No employee data found";
       empId = employeeData[0]['id'];

      final itineraries = await xml_rpc.call(
        Uri.parse("$baseUrl/xmlrpc/2/object"),
        'execute_kw',
        [
          dbName,
          userId,
          password,
          'distribution.itinerary',
          'search_read',
          [
            [
              ['sale_person', '=', empId],
              ['date', '=', formattedDate]
            ]
          ],
          {'fields': ['id'],'limit': 1},
        ],
      );
      print("itinerariesitineraries.4$itineraries");
      if (itineraries.isEmpty) return "No itineraries found";
       itineraryIds = itineraries[0]["id"];

      final itineraryLines = await xml_rpc.call(
        Uri.parse("$baseUrl/xmlrpc/2/object"),
        'execute_kw',
        [
          dbName,
          userId,
          password,
          'distribution.itinerary.line',
          'search_read',
          [
            [
              ['itinerary_id', '=', itineraryIds],
              ['state', '=', 'draft']
            ]
          ],
          {
            'fields': [
              'state', 'partner_id', 'partner_name', 'route_id',
              'route_code', 'date', 'customer_invoice_outstanding_amount','itinerary_latitude','itinerary_longitude','visit_status'
            ],
          },
        ],
      );
      if (itineraryLines.isNotEmpty) {
        for (final item in itineraryLines) {
          await dataBase.insertIternaryData(
            itinerary_line_id: item['id'],
            partner_name: item['partner_name'] == false ? "" : item['partner_name'],
            route_code: item['route_code'] == false ? "" : item['route_code'],
            route_name: item['route_id'][1] == false ? "" : item['route_id'][1],
            date: item['date'] == false ? "" : item['date'],
            cusOutstandingAmount: item['customer_invoice_outstanding_amount'] == false ? "" : item['customer_invoice_outstanding_amount'],
            partner_id: item['partner_id'] == false ? 0 : item['partner_id'][0],
            itinerary_latitude: item['itinerary_latitude'],
            itinerary_longitude:item['itinerary_longitude'],
            visit_status: item["visit_status"] == false ? "" : item["visit_status"],
          );
        }
      }
      final itineraryPaymentLines = await xml_rpc.call(
        Uri.parse("$baseUrl/xmlrpc/2/object"),
        'execute_kw',
        [
          dbName,
          userId,
          password,
          'itinerary.payment.line',
          'search_read',
          [[]],
          {
            'fields': [
              'id', 'payment_line_id', 'partner_id', 'date', 'invoice_id',
              'invoice_amount', 'invoice_date', 'payment_method',
              'cheque_number', 'cheque_date', 'amount'
            ],
          },
        ],
      );
      print("lllmmmm");
      if (itineraryPaymentLines.isNotEmpty) {
        for (final item in itineraryPaymentLines) {
          if (item["payment_line_id"] != false) {
            await dataBase.insertItineraryPaymentLine(
              itinerary_line_id: item["id"],
              paymentLineId: item["payment_line_id"][0],
              date: item["date"] == false ? "" : item["date"],
              invoiceId: item["invoice_id"] == false ? 0 : item["invoice_id"][0],
              invoice_name: item["invoice_id"] == false ? "" : item["invoice_id"][1],
              invoiceDate: item["invoice_date"] == false ? "" : item["invoice_date"],
              paymentMethod: item["payment_method"] == false ? "" : item["payment_method"],
              chequeDate: item["cheque_date"] == false ? "" : item["cheque_date"],
              chequeNumber: item["cheque_number"] == false ? "" : item["cheque_number"],
              amount: item["amount"] == false ? "" : item["amount"],
              invoice_amount: item["invoice_amount"] == false ? "" : item["invoice_amount"],
            );
          }
        }
      }
    print("bbnnn");
      final itineraryPaymentInvoicesLine = await xml_rpc.call(
        Uri.parse("$baseUrl/xmlrpc/2/object"),
        'execute_kw',
        [
          dbName,
          userId,
          password,
          'account.move',
          'search_read',
          [
            [
              ['state', '=', "posted"],
              ['move_type', '=', 'out_invoice'],
              ['amount_residual', '!=', 0]
            ]
          ],
          {
            'fields': [
              'id', 'partner_id', 'name', 'invoice_date_due', 'date',
              'payment_state', 'move_type', 'state', 'amount_total_in_currency_signed','itinerary_return_id'
            ],
          },
        ],
      );
      if (itineraryPaymentInvoicesLine.isNotEmpty) {
        for (final item in itineraryPaymentInvoicesLine) {
          await dataBase.insertInvoiceData(
            invoiceDate: item["date"] == false ? "" : item["date"],
            invoice_amount: item["amount_total_in_currency_signed"] == false ? 0 : item["amount_total_in_currency_signed"],
            invoiceDueDate: item["invoice_date_due"] == false ? "" : item["invoice_date_due"],
            invoice_id: item["id"] == false ? "" : item["id"],
            invoiceName: item["name"] == false ? "" : item["name"],
            moveType: item["move_type"] == false ? "" : item["move_type"],
            partnerId: item["partner_id"] == false ? 0 : item["partner_id"][0],
            paymentStatus: item["payment_state"] == false ? "" : item["payment_state"],
            state: item["state"] == false ? "" : item["state"],
          );
        }
      }
      final resPartnerDataToItineraryLine = await xml_rpc.call(
        Uri.parse("$baseUrl/xmlrpc/2/object"),
        'execute_kw',
        [
          dbName,
          userId,
          password,
          'res.partner',
          'search_read',
          [
            [
            ]
          ],
          {'fields': ['id', 'name', 'company_id', 'route_id', 'territory_id','credit','credit_period','credit_limit'],},
        ],
      );

      print("kolp.${resPartnerDataToItineraryLine}");
      if (resPartnerDataToItineraryLine.isNotEmpty) {
        for (final item in resPartnerDataToItineraryLine) {
          await dataBase.insertResPartnerData(
            resPartnerId: item["id"],
            name:item["name"] == false  ? "" : item["name"] ,
            credit: item["credit"] == false ? 0.0 :item["credit"]  ,
            credit_limit: item["credit_limit"] == false ? 0.0 : item["credit_limit"],
            creditPeriod: item["credit_period"] == false ? 0 :item["credit_period"],
          );
        }
      }
      final visitStatusLine = await xml_rpc.call(
        Uri.parse("$baseUrl/xmlrpc/2/object"),
        'execute_kw',
        [
          dbName,
          userId,
          password,
          'distribution.visit.status',
          'search_read',
          [
            [
            ]
          ],
          {
            'fields': [
              'id','name',
            ],
          },
        ],
      );

      if (visitStatusLine.isNotEmpty) {
        for (final item in visitStatusLine) {
          await dataBase.insertVisitStatus(
           statusId: item["id"],
            visitStatus:item["name"],
          );
        }
      }
      print( "visitStatus................$visitStatusLine.");
      notifyListeners();
      return " successfully.";
    } catch (e) {
      print("Error in itineraryDatakkkkk: $e");
      return "Error: $e";
    }
  }

  Future<dynamic> productData() async {
    try {
      final pref = await SharedPreferences.getInstance();
      final userId = pref.getInt("user_Id");
      final password = pref.getString("password");
      if (userId == null || password == null) return "User credentials not found";

      final productData = await xml_rpc.call(
        Uri.parse("$baseUrl/xmlrpc/2/object"),
        'execute_kw',
        [
          dbName,
          userId,
          password,
          'product.product',
          'search_read',
          [[]],
          {
            'fields': [
              'id', 'name', 'display_name', 'image_1920',
              'list_price', 'default_code', 'categ_id','is_discount_product'
            ],
          },
        ],
      );

      final category = await xml_rpc.call(
        Uri.parse("$baseUrl/xmlrpc/2/object"),
        'execute_kw',
        [
          dbName,
          userId,
          password,
          'product.category',
          'search_read',
          [[]],
          {
            'fields': ['id', 'display_name','itinerary_discount_ids'],
          },
        ],
      );

      if (category.isNotEmpty) {
        for (final item in category) {
          String encodedIds = jsonEncode(item["itinerary_discount_ids"]);
          await dataBase.insertCategory(
            categoryId: item["id"],
            displayName: item["display_name"],
            itinerary_discount_ids: encodedIds,
          );
        }
      }
      if (productData.isNotEmpty) {
        for (final item in productData) {
          await dataBase.insertProductMaster(
            productId: item["id"],
            productName: item["name"] == false ? "" : item["name"],
            imageUrl: item["image_1920"] == false ? "" : item["image_1920"],
            salesPrice: item["list_price"] == false ? 0.0 : item["list_price"],
            itemCode: item["default_code"] == false ? "" : item["default_code"],
            displayName: item["display_name"] == false ? "" : item["display_name"],
            productCategoryId: item["categ_id"][0],
            is_discount_product: item["is_discount_product"],
          );
        }
        return productData;
      } else {
        return [];
      }
    } catch (e) {
      print("Error in productData: $e");
      return "Error: $e";
    }
  }
  Future<dynamic> productLoyaltyProgramAndDiscounts() async {
    List loyaltyReward = [];
    List loyaltyRules = [];
    final insertedKeys = <String>{}; // Set to track inserted combinations

    try {
      final pref = await SharedPreferences.getInstance();
      final userId = pref.getInt("user_Id");
      final password = pref.getString("password");
      if (userId == null || password == null) return "User credentials not found";

      loyaltyRules = await xml_rpc.call(
        Uri.parse("$baseUrl/xmlrpc/2/object"),
        'execute_kw',
        [
          dbName,
          userId,
          password,
          'loyalty.rule',
          'search_read',
          [[]],
          {
            'fields': [
              'id',
              'product_ids',
              'minimum_qty'
            ],
          },
        ],
      );

      loyaltyReward = await xml_rpc.call(
        Uri.parse("$baseUrl/xmlrpc/2/object"),
        'execute_kw',
        [
          dbName,
          userId,
          password,
          'loyalty.reward',
          'search_read',
          [[]],
          {
            'fields': [
              'id',
              'reward_product_id',
              'display_name',
              'stock_lot_id',
              'reward_product_qty',
            ],
          },
        ],
      );

      print("Loyalty Rules: $loyaltyRules");
      print("Loyalty Program: $loyaltyReward");

      for (dynamic rule in loyaltyRules) {
        for (dynamic reward in loyaltyReward) {
          if (rule["product_ids"] != null &&
              rule["product_ids"].isNotEmpty &&
              reward["reward_product_id"] != null &&
              reward["reward_product_id"].isNotEmpty &&
              rule["product_ids"][0].toString() == reward["reward_product_id"][0].toString()) {

            final productId = rule["product_ids"][0];
            final stockLotId = reward["stock_lot_id"] == false ? 0 : reward["stock_lot_id"][0];
            final uniqueKey = "$productId-$stockLotId";

            if (!insertedKeys.contains(uniqueKey)) {
              insertedKeys.add(uniqueKey);

              await dataBase.insertLoyaltyFreeIssueData(
                productId: productId,
                displayName: reward["reward_product_id"].length > 1
                    ? reward["reward_product_id"][1]
                    : "",
                minimumQty: rule["minimum_qty"],
                stockLotId: stockLotId,
                rewardProductQty: reward["reward_product_qty"],
              );
            }
          }
        }
      }

      final discounts = await xml_rpc.call(
        Uri.parse("$baseUrl/xmlrpc/2/object"),
        'execute_kw',
        [
          dbName,
          userId,
          password,
          'itinerary.discount',
          'search_read',
          [[
            ['is_active','=',true]
          ]],
          {
            'fields': [
              'id',
              'name',
              'discount_percentage',
              'start_date',
              'end_date',
              'discount_product_id',
              'is_active',
              'minimum_amount',
              'maximum_amount',
              'not_issue_discount_products_ids',
            ],
          },
        ],
      );
      print("discounts..$discounts");
      if (discounts.isNotEmpty) {
        for (final item in discounts) {
          String encodedIds = jsonEncode(item["not_issue_discount_products_ids"]);
          await dataBase.insertDiscountData(
              discount_id: item["id"],
              name: item["name"],
              discount_percentage: item["discount_percentage"],
              end_date: item["start_date"],
              start_date: item["end_date"],
              discount_product_id:item["discount_product_id"][0],
              discount_product_name: item["discount_product_id"][1],
              is_active:item["is_active"],
              minimum_amount: item["minimum_amount"],
              maximum_amount: item["maximum_amount"],
              not_issue_discount_products_ids: encodedIds,
          );
        }
        return productData;
      }
      return "successful";
    } catch (e) {
      print("Error in productLoyaltyProgram: $e");
      return "Error: $e";
    }
  }


  Future<dynamic> saveCheckInOutDetails(checkInOrOut , latitude, longitude) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final userId = pref.getInt("user_Id");
      final password = pref.getString("password");
      if (userId == null || password == null) return "User credentials not found";
      final List<dynamic> requestedList = checkInOrOut == "checkIn"  ?
      [
      [itineraryIds],
    {
    "check_in_latitude":latitude,
    "check_in_longitude":longitude,
    "start_milage":  _startMileage
    }
    ] :  [
        [itineraryIds],
        {
          "check_out_latitude":latitude,
          "check_out_longitude":longitude,
          "end_mileage":  _endMileage
        }
      ];
      final itineraryLineUpdate = await xml_rpc.call(
        Uri.parse("$baseUrl/xmlrpc/2/object"),
        'execute_kw',
        [
          dbName,
          userId,
          password,
          'distribution.itinerary',
          'write',
           requestedList
        ],
      );
      print("itineraryLineUpdateitineraryLineUpdate.$itineraryLineUpdate");
    } catch (e) {
      print("Error in productDatakpp: $e");
      return "Error: $e";
    }
  }
  Future<void> fetchDbItineraryDate() async {
    final itineraryData = await dataBase.getAllData();
    print("nnoo..${itineraryData}");
    convertItineraryDbData = itineraryData.map((item) => {
      'id': item.id,
      'itinerary_line_id': item.itinerary_line_id,
      'partner_id': item.partner_id,
      'partner_name': item.partner_name,
      'date': item.date,
      'route_code': item.route_code,
      'route_name': item.route_name,
      'isSynced': item.isSynced,
      'isVisited': item.isVisited,
      'customer_invoice_outstanding_amount': item.cusOutstandingAmount,
    }).toList();
  }

  fetchVisitStatusData()async{
    outletVisitStatusList = [];
    final visitStatusData = await dataBase.getAllVisitStatusData();
    outletVisitStatusList = visitStatusData.map((item) => {
      'id': item.status_id,
      'name': item.visitStatus,
    }).toList();
    notifyListeners();
  }
}
