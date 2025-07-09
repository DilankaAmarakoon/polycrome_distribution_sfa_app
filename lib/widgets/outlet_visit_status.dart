import 'package:flutter/material.dart';
import 'package:polycrome_sales_application/localDb/app_database.dart';
import '../reusableWidgets/drop_down.dart';
import '../reusableWidgets/text_field.dart';

Future<bool> showExitConfirmationDialog(
    BuildContext context,
    List<Map<String, dynamic>> outletVisitStatusList,
    String partnerName,
    int itineraryId
    ) {
  int selectedId = 0;
  String selectedVisitStatus = "";
  TextEditingController otherStatus =TextEditingController();

  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => StatefulBuilder(
       builder: (context, setModalState){
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
            insetPadding: const EdgeInsets.symmetric(horizontal: 24),
            backgroundColor: Colors.white,
            elevation: 5,
            content: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Visit Status",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Divider(),
                  Text(
                    partnerName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  StyledDropdown(
                    dataList: outletVisitStatusList,
                    hintText: "Select Outlet Visit Status",
                    onChange: (value) {
                      print("selectedId,,,,,,,,$selectedId");
                      setModalState(() {});
                      selectedId = value?["id"] ?? 0;
                      selectedVisitStatus = value?["name"] ?? 0;
                    },
                  ),
                  selectedVisitStatus == "Other"  ? NormalTextField(
                    controller: otherStatus,
                    isNoteText: true,
                    label: "Other Reason",
                    onChanged: (value){},
                  ) : SizedBox(),
                  const Spacer(),
                ],
              ),
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context, false),
                icon: const Icon(Icons.close, size: 18),
                label: const Text("Cancel", style: TextStyle(fontSize: 14)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(120, 36),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  print("op...$selectedVisitStatus");
                  print("op...${otherStatus.text.isNotEmpty}");
                  if (selectedId != 0 && selectedVisitStatus != "Other") {
                    AppDatabase.instance.updateVisitStatusSalesPersonData(
                      itinerary_line_id: itineraryId,
                      visit_status: selectedVisitStatus,
                    );
                    Navigator.pop(context, true);
                  }else if(selectedVisitStatus == "Other" && otherStatus.text.isNotEmpty){
                    AppDatabase.instance.updateVisitStatusSalesPersonData(
                      itinerary_line_id: itineraryId,
                      visit_status: "Other Reason : ${otherStatus.text}",
                    );
                    Navigator.pop(context, true);
                  }
                },
                icon: const Icon(Icons.done, size: 18),
                label: const Text("Confirm", style: TextStyle(fontSize: 14)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(120, 36),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        );
       },
    ),
  ).then((value) => value ?? false);
}
