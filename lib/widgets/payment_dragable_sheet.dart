import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:polycrome_sales_application/localDb/app_database.dart';
import 'package:polycrome_sales_application/providers/order_return_payment_provider.dart';
import 'package:provider/provider.dart';
import '../reusableWidgets/date_picker.dart';
import '../reusableWidgets/reusable_drop_down.dart';
import '../reusableWidgets/showDialog.dart';
import '../reusableWidgets/text_field.dart';

class PaymentDraggableSheet {
  TextEditingController searchField = TextEditingController();

  Future<void> openDraggableSheet(
      String paymentType,
      BuildContext context,
      int liternary_Id,
      Map<String, dynamic> paymentValidData,
      VoidCallback onPressed,
      {required paymentLineId, required partnerId}
      )async {

      await Provider.of<OrderReturnPaymentProvider>(context,listen: false).fetchPaymentInvoicesDropData(partnerId,);
      final showPaymentInvoicesDropData =  Provider.of<OrderReturnPaymentProvider>(context,listen: false);
    final DraggableScrollableController sheetController = DraggableScrollableController();
    final TextEditingController paymentDate = TextEditingController();
    final TextEditingController invoiceDate = TextEditingController();
    final TextEditingController invoiceAmount = TextEditingController();
    final TextEditingController chequeNumber = TextEditingController();
    final TextEditingController chequeDate = TextEditingController();
    final TextEditingController amount = TextEditingController();

    final List<Map<String, dynamic>> invoiceList = showPaymentInvoicesDropData.showPaymentInvoicesDropData;

    Map<String,dynamic>  currentUpdateChangeMap ={};
    Map<String,dynamic>  currentAddNewChangeMap ={};
      bool isChequeVisible =false;
      if(paymentValidData["payment_method"] == "cheque"){
        isChequeVisible =true;
      }

    final List<Map<String, dynamic>> paymentMethodList = [
      {"id": 1, "name": "cash"},
      {"id": 2, "name": "cheque"},
    ];
      Map<String, dynamic>?selectedInvoice = null;
      Map<String, dynamic>? selectedPaymentMethod = setFieldsValue(
        paymentValidData,
        paymentDate,
        invoiceDate,
        chequeNumber,
        chequeDate,
        invoiceAmount,
        amount,
        paymentMethodList,
        invoiceList,
        currentUpdateChangeMap,
            (value) => selectedInvoice = value,
      );


      await showModalBottomSheet(
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(),
                                Center(
                                  child: Text(
                                    paymentType == "updatePayment"
                                        ? "Update Payment Line"
                                        : "Create Payment Line",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
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
                            SizedBox(
                              height: 60,
                              child: ReusableDropdown(
                                dataList: invoiceList,
                                hintText: "Select Invoice",
                                selectedItem: selectedInvoice,
                                isEnabled: paymentType == "updatePayment" ? false : true,
                                onChange: (Map<String, dynamic>? value) {
                                  if(value != null){
                                    currentAddNewChangeMap = value;
                                    final now = DateTime.now();
                                    final formatter = DateFormat('yyyy-MM-dd');
                                    paymentDate.text = formatter.format(now);
                                    invoiceDate.text = value["invoice_date"];
                                    invoiceAmount.text = value["invoice_amount"].toString();
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              child: DatePickerFormField(
                                controller: invoiceDate,
                                label: "Invoice Date",
                                isEnable: false,
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              child: ReusableTextField(
                                controller: invoiceAmount,
                                labelText: "Invoice Amount",
                                keyboardType: TextInputType.number,
                                readOnly: false,
                                onChanged: (value){
                                  currentUpdateChangeMap["invoiceAmount"] = value;
                                  setModalState((){});
                                },
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              child: ReusableDropdown(
                                dataList: paymentMethodList,
                                hintText: "Payment Method",
                                selectedItem: selectedPaymentMethod,
                                onChange: (Map<String, dynamic>? value) {
                                  if(value != null ){
                                    currentUpdateChangeMap["paymentMethod"] = value["name"];
                                    currentAddNewChangeMap["paymentMethod"] = value["name"];
                                      isChequeVisible = value["name"] == "cheque" ? true : false;
                                  }
                                  selectedPaymentMethod = value!;
                                  setModalState(() {});
                                },
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              child: DatePickerFormField(
                                controller: paymentDate,
                                label: "Payment Date",
                                 isEnable: true,
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              child: ReusableTextField(
                                controller: chequeNumber,
                                labelText: "Cheque Number",
                                readOnly: !isChequeVisible,
                                onChanged: (value){
                                  currentUpdateChangeMap["chequeNumber"] = value;
                                  setModalState((){});
                                },
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              child: DatePickerFormField(
                                controller: chequeDate,
                                label: "Cheque Date",
                                isEnable:  isChequeVisible,
                                onChanged: (value){
                                  currentUpdateChangeMap["chequeDate"] = value;
                                  setModalState((){});
                                },
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              child: ReusableTextField(
                                controller: amount,
                                labelText: "Amount",
                                keyboardType: TextInputType.number,
                                onChanged: (value){
                                  currentUpdateChangeMap["amount"] = value;
                                  setModalState((){});
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    if( paymentType == "updatePayment"){
                                      updatePaymentLineData(
                                          paymentValidData,
                                        currentUpdateChangeMap,
                                      );
                                    }else{
                                      if(currentUpdateChangeMap["paymentMethod"] != null || currentUpdateChangeMap["id"] != null){
                                        addNewPaymentLineData(
                                            paymentLineId,
                                            currentAddNewChangeMap,
                                            paymentDate,
                                            chequeNumber,
                                            chequeDate,
                                            amount,
                                            liternary_Id
                                        );
                                      }else{
                                        await showConfirmationDialog(
                                          context,
                                          "Please fill the required field !",
                                          actionType: 'Ok',
                                        );
                                        return;
                                      }
                                    }
                                    Navigator.of(sheetContext).pop();
                                  },
                                  icon: const Icon(Icons.create_outlined, size: 18),
                                  label: Text(
                                    paymentType == "updatePayment"
                                        ? "Update Payment"
                                        : "Create Payment",
                                    style: const TextStyle(fontSize: 14),
                                  ),
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );

                },
              );
            },
          ),
        );
      },
    ).then((value) {
      onPressed();
    });
  }

  updatePaymentLineData(Map<String, dynamic> paymentValidData,
      Map<String,dynamic>  currentChangeMap,
      )async{
    AppDatabase dataBase = AppDatabase.instance;
    dataBase.updatePaymentUsageData(
        itinerary_line_id: paymentValidData["id"],
        id: paymentValidData["id"],
        paymentLineId: paymentValidData["payment_line_id"],
        itineraryPaymentLineId: paymentValidData["id"],
        date: paymentValidData["date"],
        invoiceId: paymentValidData["invoice_id"],
        invoiceName: paymentValidData["invoice_name"],
        invoiceDate: paymentValidData["invoice_date"],
        paymentMethod: currentChangeMap["paymentMethod"] ?? paymentValidData["payment_method"],
        amount:  double.parse(currentChangeMap["amount"].toString() ?? "0"),
        invoiceAmount: double.parse(currentChangeMap["invoiceAmount"].toString()),
        chequeNumber: currentChangeMap["chequeNumber"] ?? paymentValidData["cheque_number"],
        chequeDate: currentChangeMap["chequeDate"] ?? paymentValidData["cheque_date"],
        isSynced: false,
    );
  }

  addNewPaymentLineData(
      int paymentLineId,
      Map<String,dynamic>  currentChangeMap,
      TextEditingController paymentDate,
      TextEditingController chequeNumber,
      TextEditingController chequeDate,
      TextEditingController amount,
      int liternary_Id
      )async{
    AppDatabase dataBase = AppDatabase.instance;
    await dataBase.insertPaymentUsageData(
      itinerary_line_id: 0,
      odooId: 0,
      paymentLineId:liternary_Id,
      date: paymentDate.text,
      invoiceId:  currentChangeMap["id"],
      invoice_name: currentChangeMap["name"],
      invoiceDate: currentChangeMap["invoice_date"],
      paymentMethod:  currentChangeMap["paymentMethod"],
      chequeDate: chequeDate.text,
      chequeNumber: chequeNumber.text,
      amount: amount.text == "" ? 0 : double.parse(amount.text),
      invoice_amount: currentChangeMap["invoice_amount"],
      isExciteOrNew: false,
    );
  }

  Map<String, dynamic>? setFieldsValue(
      Map<String, dynamic> paymentValidData,
      TextEditingController paymentDate,
      TextEditingController invoiceDate,
      TextEditingController chequeNumber,
      TextEditingController chequeDate,
      TextEditingController invoiceAmount,
      TextEditingController amount,
      List<Map<String, dynamic>> paymentMethodList,
      List<Map<String, dynamic>> invoiceList,
      Map<String, dynamic> currentUpdateChangeMap,
      void Function(Map<String, dynamic>?) onSetSelectedInvoice,
      ) {
    if (paymentValidData.isNotEmpty) {
      currentUpdateChangeMap["invoiceAmount"] = paymentValidData['invoice_amount'];
      currentUpdateChangeMap["chequeNumber"] = paymentValidData['cheque_number'];
      currentUpdateChangeMap["chequeDate"] = paymentValidData['cheque_date'];
      currentUpdateChangeMap["amount"] = paymentValidData['invoice_amount'];

      paymentDate.text = paymentValidData['date'].toString();
      invoiceDate.text = paymentValidData['invoice_date'].toString();
      chequeNumber.text = paymentValidData['cheque_number'].toString();
      chequeDate.text = paymentValidData['cheque_date'].toString();
      invoiceAmount.text = paymentValidData['invoice_amount'].toString();
      amount.text = paymentValidData['amount'].toString();

      Map<String, dynamic>? matchedInvoice;
      try {
        matchedInvoice = invoiceList.firstWhere(
              (item) => item["name"] == paymentValidData['invoice_name'],
        );
      } catch (e) {
        matchedInvoice = null;
      }

      Map<String, dynamic>? matchedPaymentMethod;
      try {
        matchedPaymentMethod = paymentMethodList.firstWhere(
              (item) => item["name"] == paymentValidData['payment_method'],
        );
      } catch (e) {
        matchedPaymentMethod = null;
      }

      onSetSelectedInvoice(matchedInvoice);
      return matchedPaymentMethod;
    }

    return null;
  }


}
