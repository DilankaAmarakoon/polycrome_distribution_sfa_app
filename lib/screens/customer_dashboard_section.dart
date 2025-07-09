import 'package:flutter/material.dart';
import 'package:polycrome_sales_application/reusableWidgets/sync_btn.dart';
import 'package:provider/provider.dart';
import '../localDb/app_database.dart';
import '../providers/handdle_data_provider.dart';
import '../providers/order_return_payment_provider.dart';
import 'customer_outlet_history_table.dart';
import 'order_taking.dart';

class CustomerDashboard extends StatefulWidget {
  final int index;
  final int itineraryId;
  const CustomerDashboard({super.key, required this.index, required this.itineraryId});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}
class _CustomerDashboardState extends State<CustomerDashboard> {
  final localDb = AppDatabase.instance;
  @override
  void initState() {
    fetchCreditLimit();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final orderReturnPaymentProvider = Provider.of<OrderReturnPaymentProvider>(context, listen: false);
    final itineraryDataHandleData = Provider.of<ItineraryDataHandle>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              itineraryDataHandleData.convertItineraryDbData[widget.index]["partner_name"],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).primaryColor),
            ),
          ),
          actions: [
            itineraryDataHandleData.convertItineraryDbData[widget.index]["isVisited"] ?
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "Visited",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
                ),
        ):SizedBox()
          ],
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SyncDialogButton(
                        icon: Icons.history,
                        lable: "History",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CustomerOutletHistoryTable(partnerName:itineraryDataHandleData.convertItineraryDbData[widget.index]["partner_name"] ,partnerId:itineraryDataHandleData.convertItineraryDbData[widget.index]["partner_id"]),
                            ),
                          );

                        },
                      ),
                      SyncDialogButton(
                        icon: Icons.line_style,
                        lable: "Pre Order",
                        isDisabled: itineraryDataHandleData.convertItineraryDbData[widget.index]["isVisited"],
                        onTap: () async {
                          await orderReturnPaymentProvider.insertPaymentUsageData(widget.itineraryId);
                          int partnerId = Provider.of<ItineraryDataHandle>(context, listen: false).convertItineraryDbData[widget.index]["partner_id"];
                          await Provider.of<OrderReturnPaymentProvider>(context,listen: false).fetchPaymentInvoicesDropData(partnerId,);
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderTaking(
                                convertLocalDbData: itineraryDataHandleData.convertItineraryDbData,
                                index: widget.index,
                                itineraryId: widget.itineraryId,
                              ),
                            ),
                          );
                          await itineraryDataHandleData.fetchDbItineraryDate();
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  fetchCreditLimit() async {
    print("err.${Provider.of<ItineraryDataHandle>(context, listen: false).convertItineraryDbData}");

    int partnerId = Provider.of<ItineraryDataHandle>(context, listen: false)
        .convertItineraryDbData[widget.index]["partner_id"];

    final creditData = await AppDatabase.instance
        .getAllResPartnerDataLinesFilteredPartnerId(partnerId);

    if (creditData.isNotEmpty) {
      final partner = creditData.first;

      Provider.of<ItineraryDataHandle>(context, listen: false)
          .convertItineraryDbData[widget.index]["use_partner_credit_limit"] =
          partner.use_partner_credit_limit;
      Provider.of<ItineraryDataHandle>(context, listen: false)
          .convertItineraryDbData[widget.index]["credit"] =
          partner.credit;
    } else {
      print("No partner data found for partner ID $partnerId");
    }
  }

}
