import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../get_live_location.dart';
import '../localDb/app_database.dart';
import '../providers/connection_handle.provider.dart';
import '../providers/handdle_data_provider.dart';
import '../providers/order_return_payment_provider.dart';
import '../providers/save_data_provider.dart';
import '../reusableWidgets/showDialog.dart';
import '../reusableWidgets/sync_featching_dialog_btn.dart';
import '../widgets/order_taking_tab_bar.dart';
import '../widgets/outlet_visit_status.dart';

class OrderTaking extends StatefulWidget {
  final List convertLocalDbData;
  final int index;
  final int itineraryId;
  const OrderTaking({super.key,required this.convertLocalDbData,required this.index,required this.itineraryId});

  @override
  State<OrderTaking> createState() => _OrderTakingState();
}

class _OrderTakingState extends State<OrderTaking> {
  final AppDatabase dataBase = AppDatabase.instance;
  final numberFormatter = NumberFormat('#,##0.00');
  List<Map<String, dynamic>> outletVisitStatusList =[];
  bool isDatePeriodOkay = false;
  bool isOrderValid = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkCreditLimit(); // Safe now
    });
  }
  @override
  Widget build(BuildContext context) {
    final saveDataProvider =  Provider.of<SaveDataProvider>(context,listen: false);
    final connectionCheckProvider =  Provider.of<ConnectionHandle>(context,listen: false);
    final orderReturnPaymentProvider = Provider.of<OrderReturnPaymentProvider>(context,listen: true);
    final itineraryDataHandleData = Provider.of<ItineraryDataHandle>(context, listen: false);
    GetLiveLocation getLiveLocation = GetLiveLocation();
    return WillPopScope(
      onWillPop: () async {
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
        if(position == null){
          await showConfirmationDialog(
            context,
            "Your device's GPS (Location Services) is turned off.\n\nPlease enable it in settings to continue.",
            actionType: 'Ok',
          );
          return false;
        }
        else{
          await AppDatabase.instance.updateLocationSalesPersonData(itinerary_line_id: widget.itineraryId,itinerary_latitude: position.latitude,itinerary_longitude:position.longitude );
        }
        Navigator.pop(context);
        final shouldPop = await showExitConfirmationDialog(
          context,
            itineraryDataHandleData.outletVisitStatusList,
          widget.convertLocalDbData[widget.index]["partner_name"],
            widget.itineraryId
        );
        if(shouldPop){
          orderReturnPaymentProvider.setIsDiscountState(false);
          // discountProviderData.setIsFreeIssueState(false);
          await  AppDatabase.instance.updateIsVisitedSalesPersonData(itinerary_line_id: widget.itineraryId, isVisited: true);
        }
        return shouldPop;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Center(
              child: Text(widget.convertLocalDbData[widget.index]["partner_name"],
                style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Theme.of(context).primaryColor),),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () async{
                    final checkReturnTypeActionOk = await checkReturnTypeAndReturnAction(orderReturnPaymentProvider);
                    if (!checkReturnTypeActionOk) {
                      await showConfirmationDialog(
                        context,
                        "Please make sure the return type and return action are selected for all return lines before proceeding",
                        actionType: 'Ok',
                        isDisableCancel: true,
                      );
                      return;
                    }
                    await AppDatabase.instance.updateIsVisitedSalesPersonData(itinerary_line_id: widget.itineraryId,isVisited: true);
                    final bool isConnectedInternet = await connectionCheckProvider.checkConnection();
                    final position =  await getLiveLocation.getCurrentLocation();
                    if(position == null){
                      await showConfirmationDialog(
                        context,
                        "Your device's GPS (Location Services) is turned off.\n\nPlease enable it in settings to continue.",
                        actionType: 'Ok',
                      );
                      return;
                    }
                    else{
                      print("latitude.${position.latitude}");
                      print("longitude.${position.longitude}");
                      await AppDatabase.instance.updateLocationSalesPersonData(itinerary_line_id: widget.itineraryId,itinerary_latitude: position.latitude,itinerary_longitude:position.longitude);
                    }
                    if(isConnectedInternet){
                      await _startSync(context,saveDataProvider);
                      final shouldPop = await showExitConfirmationDialog(
                        context,
                          itineraryDataHandleData.outletVisitStatusList,
                        widget.convertLocalDbData[widget.index]["partner_name"],
                          widget.itineraryId
                      );
                      if(shouldPop){
                        orderReturnPaymentProvider.setIsDiscountState(false);
                        // discountProviderData.setIsFreeIssueState(false);
                        Navigator.pop(context);
                      }
                    }else{
                      await showConfirmationDialog(
                        context,
                        "Please note that there is no available connection.\n Be sure that when internet is available, sync will resume.",
                        actionType: 'Ok',
                        isDisableCancel:true
                      );
                      final shouldPop = await showExitConfirmationDialog(
                        context,
                          itineraryDataHandleData.outletVisitStatusList,
                        widget.convertLocalDbData[widget.index]["partner_name"],
                          widget.itineraryId
                      );
                      if(shouldPop){
                         orderReturnPaymentProvider.setIsDiscountState(false);
                        // discountProviderData.setIsFreeIssueState(false);
                        Navigator.pop(context);
                      }
                    }
                  },
                  icon: const Icon(Icons.done, size: 18),
                  label: const Text(
                    "Confirm",
                    style: TextStyle(fontSize: 14),
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
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.85,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
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
                                0: IntrinsicColumnWidth(), // for label
                                1: FixedColumnWidth(10),   // spacing before colon
                                2: FixedColumnWidth(10),   // colon
                                3: FlexColumnWidth(),      // for value
                              },
                              defaultVerticalAlignment: TableCellVerticalAlignment.top,
                              children: [
                                _buildTableRow("Partner", widget.convertLocalDbData[widget.index]["partner_name"]),
                                _buildTableRow("Date", widget.convertLocalDbData[widget.index]["date"]),
                                _buildTableRow("Route", widget.convertLocalDbData[widget.index]["route_name"]),
                                _buildTableRow("Outstanding Rs", numberFormatter.format(widget.convertLocalDbData[widget.index]["customer_invoice_outstanding_amount"])),
                              ],
                            )
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(),
                          Expanded(
                              flex:4,
                              child: OrderTakingTabBar(liternary_Id:widget.itineraryId,partner_id:widget.convertLocalDbData[widget.index]["partner_id"])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ),
      ),
    );
  }
  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(),
        const Text(
          ":",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            value,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            softWrap: true,
          ),
        ),
      ],
    );
  }

  checkCreditLimit()async{
    final showPaymentInvoicesDropData =  Provider.of<OrderReturnPaymentProvider>(context,listen: false);
    final List<Map<String, dynamic>> invoiceList = showPaymentInvoicesDropData.showPaymentInvoicesDropData;
    print("what is the invoice list.....${invoiceList}");
      if (invoiceList.isEmpty) {
        print("No invoices available");
        return;
      }
      Map<String, dynamic> oldestInvoice = invoiceList.first;
      DateTime oldestDate = DateTime.parse(oldestInvoice["invoice_date"]);

      for (var invoice in invoiceList) {
        DateTime dueDate = DateTime.parse(invoice["invoice_date"]);

        if (dueDate.isBefore(oldestDate)) {
          oldestDate = dueDate;
          oldestInvoice = invoice;
        }
      }

    String formattedDate = oldestDate.toIso8601String().split("T").first;
     isDatePeriodOkay = isTodayWithin60DaysFrom(formattedDate);;
    if (!isDatePeriodOkay){
      showPaymentInvoicesDropData.setOutStandingState("Not in the Period");
    }else if(widget.convertLocalDbData[widget.index]["use_partner_credit_limit"]< widget.convertLocalDbData[widget.index]["credit"]){
      showPaymentInvoicesDropData.setOutStandingState("Credit limit of LKR ${widget.convertLocalDbData[widget.index]["use_partner_credit_limit"]} has been exceeded");
    }else{
      showPaymentInvoicesDropData.setOutStandingState("");
    }
    setState(() {

    });
  }
  bool isTodayWithin60DaysFrom(String selectedDateStr) {
    DateTime selectedDate = DateTime.parse(selectedDateStr);
    DateTime today = DateTime.now();
    DateTime endDate = selectedDate.add(Duration(days: 60));

    return today.isAfter(selectedDate.subtract(Duration(days: 1))) &&
        today.isBefore(endDate.add(Duration(days: 1)));
  }

  Future<void> _startSync(BuildContext context, SaveDataProvider saveDataProvider) async {
    // Open dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const SyncDialog(
        message: "Sync..........",
        syncType: 'sync',
      ),
    );
    final bool syncComplete = await saveDataProvider.checkConnectionAndSaveData(context, false);
    if (context.mounted) {
      Navigator.of(context).pop();
    }
    if (syncComplete && context.mounted) {
      await _showSuccessSnackBar(context);
    }
  }
   _showSuccessSnackBar(BuildContext context) async {
   await ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Successfully synced to the server.',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.fixed,
      ),
    );

  }
  checkReturnTypeAndReturnAction(OrderReturnPaymentProvider orderReturnPaymentProvider){
    for(dynamic item in orderReturnPaymentProvider.showReturnProductValidData){
      if (item["return_reason_id"] == 0 || item["return_action_id"] == 0) {
        return false;
      }
    }
    return true;
  }
}

