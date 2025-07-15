import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../get_live_location.dart';
import '../providers/handdle_data_provider.dart';
import '../reusableWidgets/showDialog.dart';
import '../reusableWidgets/sync_featching_dialog_btn.dart';
import '../reusableWidgets/text_field.dart';

class CheckInOutDraggableSheet {
  TextEditingController vehicleNumber = TextEditingController();
  TextEditingController startMileage = TextEditingController();
  TextEditingController endMileage = TextEditingController();
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  Future<dynamic> openDraggableSheet(
      BuildContext context,
      Map<String, dynamic> resPartnerData,
      ) async {
    final itineraryDataHandle = Provider.of<ItineraryDataHandle>(context, listen: false);
    final DraggableScrollableController sheetController = DraggableScrollableController();
    final SharedPreferences pref = await SharedPreferences.getInstance();
    GetLiveLocation getLiveLocation = GetLiveLocation();
    bool? isChecked = pref.getBool('isCheckedIn') ?? false;

    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext sheetContext) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return DraggableScrollableSheet(
                controller: sheetController,
                initialChildSize: 0.8,
                minChildSize: 0.5,
                maxChildSize: 0.95,
                builder: (context, scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              Center(
                                child: Text(
                                  "Attendance",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: (){
                                    Navigator.of(sheetContext).pop();
                                  },
                                  icon: Icon(Icons.close))
                            ],
                          ),
                          const Divider(),
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.17,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Table(
                                columnWidths: const {
                                  0: IntrinsicColumnWidth(), // Label
                                  1: FixedColumnWidth(10),   // Space before colon
                                  2: FixedColumnWidth(10),   // Colon
                                  3: FlexColumnWidth(),      // Value
                                },
                                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                                children: [
                                  _buildTableRow("Current Date", currentDate),
                                  _buildTableRow("Visit Date", currentDate),
                                  _buildTableRow("Sales Person", resPartnerData["name"]),
                                  _buildTableRow("Distributor", resPartnerData["company_id"][1]),
                                  _buildTableRow("PSA", resPartnerData["route_id"].toString()),
                                  _buildTableRow("Territory", resPartnerData["territory_id"].toString()),
                                ],
                              ),
                            ),
                          ),
                          !isChecked ?    SizedBox(
                            height: 50,
                            child: NormalTextField(
                              controller: startMileage,
                              isNumber: true,
                              label: "Start Mileage",
                              onChanged: (value) => setModalState(() {}),
                            ),
                          ):  SizedBox(
                            height: 50,
                            child: NormalTextField(
                              controller: endMileage,
                              isNumber: true,
                              label: "End Mileage",
                              onChanged: (value) => setModalState(() {}),
                            ),
                          ),
                          !isChecked ?   Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                              onPressed: () async{
                                if (!isChecked) {
                                  // await deleteLocalDatabase();
                                  if(startMileage.text.isEmpty){
                                    await showConfirmationDialog(
                                      context,
                                      "Please fill in the start mileage !",
                                      actionType: 'ok',
                                    );
                                    return;
                                  }
                                  itineraryDataHandle.setIsisVisibleCheckIn(true);
                                  pref.setBool('isCheckedIn', true);
                                  itineraryDataHandle.setStartMileage(double.parse(startMileage.text));
                                  Navigator.of(sheetContext).pop("checkIn");
                                }
                              },
                              icon: const Icon(Icons.location_on_outlined, size: 18),
                              label: const Text(
                                "Check In",
                                style: TextStyle(fontSize: 14),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(500, 36),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ) : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                              onPressed: () async{
                                if(endMileage.text.isEmpty){
                                  await showConfirmationDialog(
                                    context,
                                    "Please fill in the end mileage !",
                                    actionType: 'ok',
                                  );
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
                                Navigator.pop(context);
                                if(position == null){
                                  await showConfirmationDialog(
                                    context,
                                    "Your device's GPS (Location Services) is turned off.\n\nPlease enable it in settings to continue.",
                                    actionType: 'Ok',
                                  );
                                }
                                else{
                                  final confirmed = await showConfirmationDialog(
                                    context,
                                    "Are you sure you want to check out?",
                                    actionType: 'check out',
                                  );
                                  if (confirmed == true) {
                                    itineraryDataHandle.setEndMileage(double.parse(endMileage.text));
                                    Navigator.of(sheetContext).pop(confirmed);
                                  }
                                }
                              },
                              icon: const Icon(Icons.logout, size: 18),
                              label: const Text(
                                "Check Out",
                                style: TextStyle(fontSize: 14),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(500, 36),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(),
        const Text(":", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ],
    );
  }

}
