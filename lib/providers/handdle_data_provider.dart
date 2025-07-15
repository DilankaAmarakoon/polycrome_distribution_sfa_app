import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml_rpc/client_c.dart' as xml_rpc;
import '../constants/staticData.dart';
import '../localDb/app_database.dart';

class ItineraryDataHandle with ChangeNotifier {
  bool _isVisibleCheckIn = false;
  bool _isVisited = false;
  bool get isVisibleCheckIn => _isVisibleCheckIn;
  bool get isVisited => _isVisited;
  int  empId = 0;
  int itineraryIds = 0;
  double _startMileage = 0.0;
  double _endMileage = 0.0;

  double get startMileage => _startMileage;
  double get endMileage => _endMileage;

  List<Map<String, dynamic>> convertItineraryDbData = [];
  List<Map<String, dynamic>> outletVisitStatusList =[];
  List distributionItineraryPartner_ids =[];
  List account_move_move_ids =[];
  DateTime todayDate = DateTime.now();
   // String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String formattedDate = "2025-06-25";
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
    try {
      final pref = await SharedPreferences.getInstance();
      final userId = pref.getInt("user_Id");
      final password = pref.getString("password");
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
          {
            'fields': [
              'id', 'name', 'company_id', 'route_id', 'territory_id', 'credit', 'credit_period'
            ],
          },
        ],
      );
      if (resPartnerData.isEmpty) return [];
      pref.setInt("company_id", resPartnerData[0]["company_id"][0]);
      return resPartnerData;
    } catch (e) {
      print("Error in itineraryDatahhh: $e");
      return [];
    }
  }

  Future<String> itineraryData() async {
     // Clear DB only once at the start
    await Future.wait([
      dataBase.clearAllData(),
      dataBase.clearOrderProductUsage(),
      dataBase.clearReturnProductUsage(),
      dataBase.clearAllInvoiceDataLines(),
      dataBase.clearAllItineraryPaymentLines(),
      dataBase.clearAllPaymentUsageLines(),
      dataBase.clearProductMaster(),
      dataBase.clearAllCategories(),
      dataBase.clearAllLoyaltyFreeIssueData(),
      dataBase.clearAllDiscountData(),
      dataBase.clearAllResPartnerDataLines(),
      dataBase.clearAllVisitStatusData(),
      dataBase.clearAllReturnInvoiceDataLines(),
      dataBase.clearAllReturnTypeData(),
      dataBase.clearAllReturnActionData(),
    ]);
    try {
      final pref = await SharedPreferences.getInstance();
      final userId = pref.getInt("user_Id");
      final password = pref.getString("password");
      final company_id = pref.getInt("company_id");
      if (userId == null || password == null) return "User credentials not found";

      // Fetch employee data
      print("userId..$userId");
      print("company_id..$company_id");
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
      print("Employee Data: $employeeData");
      if (employeeData.isEmpty) return "No employee data found";
       empId = employeeData[0]['id'];

      // Fetch itineraries
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
          {'fields': ['id'], 'limit': 1},
        ],
      );
      if (itineraries.isEmpty) return "No itineraries found";
       itineraryIds = itineraries[0]["id"];

      // Fetch itinerary lines
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
              'route_code', 'date', 'customer_invoice_outstanding_amount', 'itinerary_latitude', 'itinerary_longitude', 'visit_status'
            ],
          },
        ],
      );
      print("testttttttttttttttttttt: $itineraryLines");
      if (itineraryLines.isNotEmpty) {
        final List<Future> inserts = [];
        for (final item in itineraryLines) {
          distributionItineraryPartner_ids.add(item["partner_id"][0]);
          inserts.add(dataBase.insertIternaryData(
            itinerary_line_id: item['id'],
            partner_name: item['partner_name'] == false ? "" : item['partner_name'],
            route_code: item['route_code'] == false ? "" : item['route_code'],
            route_name: item['route_id'][1] == false ? "" : item['route_id'][1],
            date: item['date'] == false ? "" : item['date'],
            cusOutstandingAmount: item['customer_invoice_outstanding_amount'] == false ? "" : item['customer_invoice_outstanding_amount'],
            partner_id: item['partner_id'] == false ? 0 : item['partner_id'][0],
            itinerary_latitude: item['itinerary_latitude'],
            itinerary_longitude: item['itinerary_longitude'],
            visit_status: item["visit_status"] == false ? "" : item["visit_status"],
          ));
        }
        await Future.wait(inserts);
      }

      // Fetch itinerary payment lines
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
      if (itineraryPaymentLines.isNotEmpty) {
        final List<Future> inserts = [];
        for (final item in itineraryPaymentLines) {
          if (item["payment_line_id"] != false) {
            inserts.add(dataBase.insertItineraryPaymentLine(
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
            ));
          }
        }
        await Future.wait(inserts);
      }

      // Fetch itinerary payment invoices line
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
              ['partner_id', 'in', distributionItineraryPartner_ids],
              ['state', '=', "posted"],
              ['move_type', '=', 'out_invoice'],
            ]
          ],
          {
            'fields': [
              'id', 'partner_id',
              'name', 'invoice_date_due', 'date',
              'payment_state', 'move_type', 'state', 'amount_total_in_currency_signed', 'amount_residual'
            ],
          },
        ],
      );
      if (itineraryPaymentInvoicesLine.isNotEmpty) {
        final List<Future> inserts = [];
        for (final item in itineraryPaymentInvoicesLine) {
          account_move_move_ids.add(item["id"]);
          inserts.add(dataBase.insertInvoiceData(
            invoiceDate: item["date"] == false ? "" : item["date"],
            invoice_amount: item["amount_total_in_currency_signed"] == false ? 0 : item["amount_total_in_currency_signed"],
            invoiceDueDate: item["invoice_date_due"] == false ? "" : item["invoice_date_due"],
            invoice_id: item["id"] == false ? "" : item["id"],
            invoiceName: item["name"] == false ? "" : item["name"],
            moveType: item["move_type"] == false ? "" : item["move_type"],
            partnerId: item["partner_id"] == false ? 0 : item["partner_id"][0],
            paymentStatus: item["payment_state"] == false ? "" : item["payment_state"],
            state: item["state"] == false ? "" : item["state"],
            amount_residual: item["amount_residual"] == false ? 0 : item["amount_residual"],
          ));
        }
        await Future.wait(inserts);
      }

      // Fetch account move lines
      final accountMoveLines = await xml_rpc.call(
        Uri.parse("$baseUrl/xmlrpc/2/object"),
        'execute_kw',
        [
          dbName,
          userId,
          password,
          'account.move.line',
          'search_read',
          [
            [
              ['move_id', 'in', account_move_move_ids],
              ['parent_state', '=', "posted"],
              ['move_type', '=', 'out_invoice'],
              ['display_type', '=', 'product'],
            ]
          ],
          {
            'fields': [
              'id', 'product_id', 'move_id', 'return_action_id', 'quantity', 'price_unit', 'price_subtotal', 'price_total'
            ],
          },
        ],
      );
      if (accountMoveLines.isNotEmpty) {
        final List<Future> inserts = [];
        for (final item in accountMoveLines) {
          if (item["product_id"] is List && item["product_id"].length >= 2) {
            inserts.add(dataBase.insertReturnInvoiceData(
              accountMoveLineId: item["id"],
              move_id: item["move_id"][0],
              productId: item["product_id"][0],
              productDisplayName: item["product_id"][1],
              return_reason: "",
              returnQty: (item["quantity"] as num).toInt(),
              unitPrice: item["price_unit"],
            ));
          }
        }
        await Future.wait(inserts);
      }

      // Fetch res.partner data
      final resPartnerDataToItineraryLine = await xml_rpc.call(
        Uri.parse("$baseUrl/xmlrpc/2/object"),
        'execute_kw',
        [
          dbName,
          userId,
          password,
          'res.partner',
          'search_read',
          [[]],
          {
            'fields': [
              'id', 'name', 'company_id', 'route_id', 'territory_id', 'credit', 'credit_period', 'credit_limit'
            ],
          },
        ],
      );
      if (resPartnerDataToItineraryLine.isNotEmpty) {
        final List<Future> inserts = [];
        for (final item in resPartnerDataToItineraryLine) {
          inserts.add(dataBase.insertResPartnerData(
            resPartnerId: item["id"],
            name: item["name"] == false ? "" : item["name"],
            credit: item["credit"] == false ? 0.0 : item["credit"],
            credit_limit: item["credit_limit"] == false ? 0.0 : item["credit_limit"],
            creditPeriod: item["credit_period"] == false ? 0 : item["credit_period"],
          ));
        }
        await Future.wait(inserts);
      }

      // Fetch visit status line
      final visitStatusLine = await xml_rpc.call(
        Uri.parse("$baseUrl/xmlrpc/2/object"),
        'execute_kw',
        [
          dbName,
          userId,
          password,
          'distribution.visit.status',
          'search_read',
          [[]],
          {
            'fields': [
              'id', 'name',
            ],
          },
        ],
      );
      if (visitStatusLine.isNotEmpty) {
        final List<Future> inserts = [];
        for (final item in visitStatusLine) {
          inserts.add(dataBase.insertVisitStatus(
            statusId: item["id"],
            visitStatus: item["name"],
          ));
        }
        await Future.wait(inserts);
      }
      final itineraryData = await dataBase.getAllData();
      print("Data inserted successfully into the database..$itineraryData");
      notifyListeners();
      return "successfully.";
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
              'list_price', 'default_code', 'categ_id', 'is_discount_product'
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
            'fields': ['id', 'display_name', 'itinerary_discount_ids'],
          },
        ],
      );
      final returnTypeData = await xml_rpc.call(
        Uri.parse("$baseUrl/xmlrpc/2/object"),
        'execute_kw',
        [
          dbName,
          userId,
          password,
          'itinerary.return.reason',
          'search_read',
          [[]],
          {
            'fields': ['id', 'name'],
          },
        ],
      );
      final returnActionData = await xml_rpc.call(
        Uri.parse("$baseUrl/xmlrpc/2/object"),
        'execute_kw',
        [
          dbName,
          userId,
          password,
          'itinerary.return.action',
          'search_read',
          [[]],
          {
            'fields': ['id', 'name'],
          },
        ],
      );
      if (returnTypeData.isNotEmpty) {
        final List<Future> inserts = [];
        for (final item in returnTypeData) {
          inserts.add(dataBase.insertReturnTypeData(
            returnTypeId: item["id"],
            returnTypeName: item["name"],
          ));
        }
        await Future.wait(inserts);
      }

      if (returnActionData.isNotEmpty) {
        final List<Future> inserts = [];
        for (final item in returnActionData) {
          inserts.add(dataBase.insertReturnActionData(
            returnActionId: item["id"],
            returnActionName: item["name"],
          ));
        }
        await Future.wait(inserts);
      }

      if (category.isNotEmpty) {
        final List<Future> inserts = [];
        for (final item in category) {
          inserts.add(dataBase.insertCategory(
            categoryId: item["id"],
            displayName: item["display_name"],
            itinerary_discount_ids: jsonEncode(item["itinerary_discount_ids"]),
          ));
        }
        await Future.wait(inserts);
      }

      if (productData.isNotEmpty) {
        final List<Future> inserts = [];
        for (final item in productData) {
          inserts.add(dataBase.insertProductMaster(
            productId: item["id"],
            productName: item["name"] == false ? "" : item["name"],
            imageUrl: item["image_1920"] == false ? "" : item["image_1920"],
            salesPrice: item["list_price"] == false ? 0.0 : item["list_price"],
            itemCode: item["default_code"] == false ? "" : item["default_code"],
            displayName: item["display_name"] == false ? "" : item["display_name"],
            productCategoryId: item["categ_id"][0],
            is_discount_product: item["is_discount_product"],
          ));
        }
        await Future.wait(inserts);
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
    final insertedKeys = <String>{};
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
      // Loyalty free issue batch insert
      final List<Future> loyaltyInserts = [];
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
              loyaltyInserts.add(dataBase.insertLoyaltyFreeIssueData(
                productId: productId,
                displayName: reward["reward_product_id"].length > 1
                    ? reward["reward_product_id"][1]
                    : "",
                minimumQty: rule["minimum_qty"],
                stockLotId: stockLotId,
                rewardProductQty: reward["reward_product_qty"],
              ));
            }
          }
        }
      }
      await Future.wait(loyaltyInserts);

      // Discounts batch insert
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
            ['is_active', '=', true]
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
      if (discounts.isNotEmpty) {
        final List<Future> discountInserts = [];
        for (final item in discounts) {
          discountInserts.add(dataBase.insertDiscountData(
            discount_id: item["id"],
            name: item["name"],
            discount_percentage: item["discount_percentage"],
            end_date: item["end_date"] == false ? "" : item["end_date"],
            start_date: item["start_date"] == false ? "" : item["start_date"],
            discount_product_id: item["discount_product_id"] == false ? 0 : item["discount_product_id"][0],
            discount_product_name: item["discount_product_id"] == false ? "" : item["discount_product_id"][1],
            is_active: item["is_active"],
            minimum_amount: item["minimum_amount"],
            maximum_amount: item["maximum_amount"],
            not_issue_discount_products_ids: jsonEncode(item["not_issue_discount_products_ids"]),
          ));
        }
        await Future.wait(discountInserts);
        return discounts;
      }
      return "successful";
    } catch (e) {
      print("Error in productLoyaltyProgram: $e");
      return "Error: $e";
    }
  }

  Future<dynamic> saveCheckInOutDetails(checkInOrOut, latitude, longitude) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final userId = pref.getInt("user_Id");
      final password = pref.getString("password");
      if (userId == null || password == null) return "User credentials not found";
      final List<dynamic> requestedList = checkInOrOut == "checkIn"
          ? [
              [itineraryIds],
              {
                "check_in_latitude": latitude,
                "check_in_longitude": longitude,
                "start_milage": _startMileage
              }
            ]
          : [
              [itineraryIds],
              {
                "check_out_latitude": latitude,
                "check_out_longitude": longitude,
                "end_mileage": _endMileage
              }
            ];
      await xml_rpc.call(
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
    } catch (e) {
      print("Error in productDatakpp: $e");
      return "Error: $e";
    }
  }

  Future<void> fetchDbItineraryDate() async {
    final itineraryData = await dataBase.getAllData();
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

    print("rtryy.${convertItineraryDbData}");
  }

  Future<void> fetchVisitStatusData() async {
    outletVisitStatusList = [];
    final visitStatusData = await dataBase.getAllVisitStatusData();
    outletVisitStatusList = visitStatusData.map((item) => {
      'id': item.status_id,
      'name': item.visitStatus,
    }).toList();
    notifyListeners();
  }
}
