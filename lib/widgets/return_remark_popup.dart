import 'package:flutter/material.dart';
import 'package:polycrome_sales_application/localDb/app_database.dart';
import '../providers/order_return_payment_provider.dart';
import '../reusableWidgets/drop_down.dart';
import '../reusableWidgets/reusable_drop_down.dart';
import '../reusableWidgets/text_field.dart';

Future<bool> showReturnRemarkDialog(
    BuildContext context,
    index,
    OrderReturnPaymentProvider orderReturnProviderData,
    productId,
    itineraryId
    ) {
  TextEditingController remark =TextEditingController();
  remark.text = orderReturnProviderData.showReturnProductValidData[index]["remark"].toString();
  int returnReasonId = orderReturnProviderData.showReturnProductValidData[index]["return_reason_id"];
  int returnActionId = orderReturnProviderData.showReturnProductValidData[index]["return_action_id"];
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => StatefulBuilder(
      builder: (context, setModalState){
        Map<String, dynamic>? getReturnTypeById() {
          if(orderReturnProviderData.showReturnProductValidData[index]["return_reason_id"] !=0){
            return orderReturnProviderData.showReturnTypeDropData.firstWhere(
                  (item) => item['id'] == orderReturnProviderData.showReturnProductValidData[index]["return_reason_id"],
              orElse: () => {},
            );
          }
          return null;
        }
        Map<String, dynamic>? getReturnActionById() {
          if(orderReturnProviderData.showReturnProductValidData[index]["return_action_id"] !=0){
            return orderReturnProviderData.showReturnActionDropData.firstWhere(
                  (item) => item['id'] == orderReturnProviderData.showReturnProductValidData[index]["return_action_id"],
              orElse: () => {},
            );
          }
          return null;
        }
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
              height: MediaQuery.of(context).size.height * 0.5,
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Return Reason",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Divider(),
                  NormalTextField(
                    controller: remark,
                    label: "Remark",
                    maxLine: 2,
                    onChanged: (value){
                      orderReturnProviderData.showReturnProductValidData[index]["remark"] = value;
                      setModalState((){});
                    },
                  ),
                  ReusableDropdown(
                    dataList: orderReturnProviderData.showReturnTypeDropData,
                    hintText: "Return Type",
                    selectedItem: getReturnTypeById(),
                    onChange: (Map<String, dynamic>? value) {
                      if(value != null){
                        returnReasonId = value["id"];
                      }
                    },
                  ),
                  ReusableDropdown(
                    dataList: orderReturnProviderData.showReturnActionDropData,
                    hintText: "Return Action",
                    selectedItem: getReturnActionById(),
                    onChange: (Map<String, dynamic>? value) {
                      if(value != null){
                        returnActionId = value["id"];
                      }
                    },
                  ),
                  Spacer()
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
                  print("sssdddvvv.$returnReasonId");
                    AppDatabase.instance.updateReturnRemarkFieldsByItineraryAndProduct(
                        itineraryLineId: itineraryId,
                        productId: productId,
                        return_reason: remark.text,);
                  AppDatabase.instance.updateReturnReasonIdAndActionFieldsByItineraryAndProduct(
                    itineraryLineId: itineraryId,
                    productId: productId,
                    return_reason_id: returnReasonId,);
                  AppDatabase.instance.updateReturnActionIdAndActionFieldsByItineraryAndProduct(
                    itineraryLineId: itineraryId,
                    productId: productId,
                    return_action_id: returnActionId,);
                    Navigator.pop(context);
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
