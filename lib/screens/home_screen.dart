import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:polycrome_sales_application/constants/colors.dart';
import 'package:polycrome_sales_application/providers/handdle_data_provider.dart';
import 'package:polycrome_sales_application/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../localDb/app_database.dart';
import '../reusableWidgets/action_btn.dart';
import '../widgets/daily_root_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final localDb = AppDatabase.instance;
  List<Map<String, dynamic>> convertLocalDbData =[];
  String actionBtnLable = 'Day Start';
  bool isDayStartState =false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItineraryDataHandle>(context);
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: kCartColor,
        actions: [
          IconButton(
            icon: Icon(Icons.logout,color: kBgColor,),
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              await pref.clear();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ActionBtn(lable: actionBtnLable,
                    onPressed: ()async{
                    print("bnm.$isDayStartState");
                      if(!isDayStartState){
                        await Provider.of<ItineraryDataHandle>(context,listen: false).itineraryData();
                        await fetchDbItineraryDate();
                        await Provider.of<ItineraryDataHandle>(context,listen: false).productData();
                        isDayStartState = true;
                      }
                    setState(() {});
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ActionBtn(lable: "Day End",
                    onPressed: ()async{
                      provider.setIsVisibleItineraryState(false);
                      setState(() {
                        isDayStartState = false;
                      });
                    },
                  ),
                ),
              )
            ],
          ),
          Divider(),
          provider.isVisibleItineraries ? DailyRootTask(convertLocalDbData:convertLocalDbData) : SizedBox()
        ],
      ),
    );
  }

  fetchDbItineraryDate() async {
    final List<SalesPersonData> localData = await localDb.getAllData();

    print("ccv.${localData.length}");
    convertLocalDbData = localData.map((item) => {
      'id': item.id,
      'itinerary_line_id': item.itinerary_line_id,
      'partner_name': item.partner_name,
      'date': item.date,
      'route_code': item.route_code,
      'route_name': item.route_name,
      'isSynced': item.isSynced,
    }).toList();
    setState(() {});
  }
}
