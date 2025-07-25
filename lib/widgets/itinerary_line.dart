import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:polycrome_sales_application/providers/order_return_payment_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../get_live_location.dart';
import '../localDb/app_database.dart';
import '../providers/handdle_data_provider.dart';
import '../reusableWidgets/cart_container.dart';
import '../reusableWidgets/showDialog.dart';
import '../screens/customer_dashboard_section.dart';
import '../screens/login_screen.dart';
import '../screens/order_taking.dart';
import 'outlet_visit_status.dart';
class ItineraryLines extends StatefulWidget {
  const ItineraryLines({super.key,});

  @override
  State<ItineraryLines> createState() => _ItineraryLinesState();
}
class _ItineraryLinesState extends State<ItineraryLines> {
  @override
  Widget build(BuildContext context) {
    final  itineraryDataHandleData = Provider.of<ItineraryDataHandle>(context,listen: false);
    GetLiveLocation getLiveLocation = GetLiveLocation();
    return SafeArea(
      child: Scaffold(
        appBar:  AppBar(
          title: Text("Itinerary Lines",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Theme.of(context).primaryColor),),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Divider(),
            Expanded(
              child: Consumer<ItineraryDataHandle>(
                  builder: (context, provider, child) {
                  return ListView.builder(
                      itemCount: itineraryDataHandleData.convertItineraryDbData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CartContainer(
                          partnerName: itineraryDataHandleData.convertItineraryDbData[index]["partner_name"],
                          routeName: itineraryDataHandleData.convertItineraryDbData[index]["route_name"],
                          isVisited: itineraryDataHandleData.convertItineraryDbData[index]["isVisited"],
                          onTap: ()async{
                            Provider.of<OrderReturnPaymentProvider>(context,listen: false).setPartnerId(itineraryDataHandleData.convertItineraryDbData[index]["partner_id"]);
                            int itineraryId =  itineraryDataHandleData.convertItineraryDbData[index]["itinerary_line_id"];
                            await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CustomerDashboard(index: index,itineraryId:itineraryId)),
                            );
                            await itineraryDataHandleData.fetchDbItineraryDate();
                            setState(() {});
                          }, onLongPress: () async{
                            if(itineraryDataHandleData.convertItineraryDbData[index]["isVisited"]){
                              return;
                            }
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => Center(
                              child: LoadingAnimationWidget.progressiveDots(
                                color: Theme.of(context).primaryColor,
                                size: 40,
                              ),
                            ),
                          );
                          final position =  await getLiveLocation.getCurrentLocation();
                          int itineraryId =  itineraryDataHandleData.convertItineraryDbData[index]["itinerary_line_id"];
                          if(position == null){
                            await showConfirmationDialog(
                            context,
                            "Your device's GPS (Location Services) is turned off.\n\nPlease enable it in settings to continue.",
                            actionType: 'Ok',

                            );
                            return;
                          }
                          else{
                            await AppDatabase.instance.updateLocationSalesPersonData(itinerary_line_id: itineraryId,itinerary_latitude: position.latitude,itinerary_longitude:position.longitude);
                          }
                          Navigator.pop(context);
                          final shouldPop = await showExitConfirmationDialog(
                              context,
                              itineraryDataHandleData.outletVisitStatusList,
                              itineraryDataHandleData.convertItineraryDbData[index]["partner_name"],
                              itineraryId
                          );
                          if(shouldPop){
                            await  AppDatabase.instance.updateIsVisitedSalesPersonData(itinerary_line_id: itineraryId, isVisited: true);
                            itineraryDataHandleData.fetchDbItineraryDate();
                            setState(() {

                            });
                          }
                        },
                        );
                      },
                    );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
