import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/colors.dart';
import '../reusableWidgets/action_btn.dart';
import '../widgets/order_taking_tab_bar.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class OrderTaking extends StatefulWidget {
  final List convertLocalDbData;
  final int index;
  final int itineraryId;
  const OrderTaking({super.key,required this.convertLocalDbData,required this.index,required this.itineraryId});

  @override
  State<OrderTaking> createState() => _OrderTakingState();
}

class _OrderTakingState extends State<OrderTaking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1E1E1E),
        leading: IconButton(
          icon:  Icon(Icons.arrow_back,color: kBgColor,),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Partner",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        Text("Date",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        Text("Route",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(': ${widget.convertLocalDbData[widget.index]["partner_name"]}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        Text(': ${widget.convertLocalDbData[widget.index]["date"]}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        Text(': ${widget.convertLocalDbData[widget.index]["route_name"]}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Divider(),
            OrderTakingTabBar(liternary_Id:widget.itineraryId,),
          ],
        ),
      )
    );
  }
}
