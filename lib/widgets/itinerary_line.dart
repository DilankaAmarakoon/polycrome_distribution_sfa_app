import 'package:flutter/material.dart';
import '../reusableWidgets/cart_container.dart';
import '../screens/order_taking.dart';
class DailyRootTask extends StatefulWidget {
  final convertLocalDbData;
  const DailyRootTask({super.key,required this.convertLocalDbData});

  @override
  State<DailyRootTask> createState() => _DailyRootTaskState();
}
class _DailyRootTaskState extends State<DailyRootTask> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
       height:MediaQuery.of(context).size.height*0.77,
    child: ListView.builder(
        itemCount: widget.convertLocalDbData.length,
        itemBuilder: (BuildContext context, int index) {
          return CartContainer(
            date: widget.convertLocalDbData[index]["date"],
            partnerName: widget.convertLocalDbData[index]["partner_name"],
            routeName: widget.convertLocalDbData[index]["route_name"],
            onTap: (){
              int itineraryId =  widget.convertLocalDbData[index]["itinerary_line_id"];
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderTaking(convertLocalDbData:widget.convertLocalDbData,index: index,itineraryId:itineraryId)),
              );
            },
          );
        },
      ),
    );
  }
}
