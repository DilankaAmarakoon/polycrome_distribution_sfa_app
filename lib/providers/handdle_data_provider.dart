import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml_rpc/client_c.dart' as xml_rpc;

import '../constants/staticData.dart';
import '../localDb/app_database.dart';

class ItineraryDataHandle with ChangeNotifier {
  // State variables
  int _notificationCount = 0;
  bool _isVisibleItineraries = false;

  int get notificationCount => _notificationCount;
  bool get isVisibleItineraries => _isVisibleItineraries;

  final AppDatabase dataBase = AppDatabase.instance;

  void setIsVisibleItineraryState(bool value) {
    _isVisibleItineraries = value;
    notifyListeners();
  }

  Future<String> itineraryData() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final int? userId = pref.getInt("user_Id");
      final String? password = pref.getString("password");

      if (userId == null || password == null) {
        return "User credentials not found";
      }

      // Fetch employee data
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
              ['company_id', '=', 4]
            ]
          ],
          {'fields': ['id'], 'limit': 1},
        ],
      );

      if (employeeData.isEmpty) return "No employee data found";
      final int empId = employeeData[0]['id'];

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
              ['sale_person', '=', empId]
            ]
          ],
          {'fields': ['id']},
        ],
      );

      if (itineraries.isEmpty) return "No itineraries found";

      final List<int> itineraryIds =
      itineraries.map<int>((e) => e['id'] as int).toList();

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
              ['itinerary_id', 'in', itineraryIds]
            ]
          ],
          {
            'fields': ['id', 'partner_name', 'route_id', 'route_code', 'date'],
          },
        ],
      );

      if (itineraryLines.isNotEmpty) {
        await dataBase.clearAllData();
        await dataBase.clearProductUsage();
        _isVisibleItineraries = true;
        notifyListeners();
      }

      // Insert into local DB
      for (final item in itineraryLines) {
        await dataBase.insertIternaryData(
          itinerary_line_id: item['id'],
          partner_name: item['partner_name'],
          route_code: item['route_code'],
          route_name: item['route_id'][1],
          date: item['date'],
        );
      }

      return "Itinerary data synced successfully.";
    } catch (e) {
      print("Error in itineraryData: $e");
      return "Error: $e";
    }
  }

  Future<dynamic> productData() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final int? userId = pref.getInt("user_Id");
      final String? password = pref.getString("password");

      if (userId == null || password == null) {
        return "User credentials not found";
      }

      // Fetch products
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
            'fields': ['name', 'image_1920', 'lst_price', 'default_code'],
          },
        ],
      );

      if (productData.isNotEmpty) {
        await dataBase.clearProductMaster();
        for (final item in productData) {
          await dataBase.insertProductMaster(
            productName: item["name"] == false ?  "" :  item["name"],
            imageUrl: item["image_1920"] == false ?  "" :  item["image_1920"],
            salesPrice: item["lst_price"] == false ?  0.0 :  item["lst_price"],
            itemCode: item["default_code"] == false ?  "" :  item["default_code"],
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
}
