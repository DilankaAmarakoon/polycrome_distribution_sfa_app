import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:polycrome_sales_application/reusableWidgets/payment_cart.dart';
import 'package:provider/provider.dart';

import '../providers/order_return_payment_provider.dart';
import '../widgets/payment_dragable_sheet.dart';

class PaymentTabBarDetails extends StatefulWidget {
  final int liternary_Id;
  final int partner_id;
  const PaymentTabBarDetails({super.key,required this.liternary_Id,required this.partner_id});

  @override
  State<PaymentTabBarDetails> createState() => _PaymentTabBarDetailsState();
}

class _PaymentTabBarDetailsState extends State<PaymentTabBarDetails> {
  final numberFormatter = NumberFormat('#,##0.00');
  double totalAmount = 0.0;
  @override
  void initState() {
    Provider.of<OrderReturnPaymentProvider>(context, listen: false).fetchPaymentValidData(widget.liternary_Id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    PaymentDraggableSheet  paymentDragblesheet = PaymentDraggableSheet();
    final showPaymentValidData = Provider.of<OrderReturnPaymentProvider>(context);
    calOrderReturnTotalAmount(showPaymentValidData);
    return Container(
      constraints: BoxConstraints(minHeight: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () async{
                      var paymentLineId = showPaymentValidData.showPaymentValidData.isEmpty ? 0 : showPaymentValidData.showPaymentValidData[0]["payment_line_id"];
                      paymentDragblesheet.openDraggableSheet(paymentLineId:paymentLineId,partnerId:widget.partner_id,"newPayment",context,widget.liternary_Id,
                          {},
                              (){
                        Provider.of<OrderReturnPaymentProvider>(context, listen: false).fetchPaymentValidData(widget.liternary_Id);
                      });
                    },
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text(
                      "Add New Payment",
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
              ),
              Expanded(flex:1,child: SizedBox()),
              Expanded(flex:1,child: SizedBox()),
            ],
          ),
          SizedBox(height: 5,),
          Expanded(
            flex: 20,
            child: ListView.builder(
              itemCount: showPaymentValidData.showPaymentValidData.length,
              itemBuilder: (context, index) => PaymentCart(
                  paymentValidData: showPaymentValidData.showPaymentValidData, index: index, liternary_Id: widget.liternary_Id,
                onTap: () {
                    paymentDragblesheet.openDraggableSheet(paymentLineId:showPaymentValidData.showPaymentValidData[index]["payment_line_id"],partnerId:widget.partner_id,"updatePayment",context, widget.liternary_Id, showPaymentValidData.showPaymentValidData[index],
                            (){
                              Provider.of<OrderReturnPaymentProvider>(context, listen: false).fetchPaymentValidData(widget.liternary_Id);
                    });
                },)
            ),
          ),
          SizedBox(height: 5,),
          Expanded(
            flex:2,
            child: Container(
              constraints: BoxConstraints(minHeight: 30),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0,2),
                  ),
                ],
              ),
              child:  Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Total Amount Rs : ${numberFormatter.format(totalAmount)}",
                        style: TextStyle(color: Colors.white,fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Spacer()
        ],
      ),
    );
  }
  calOrderReturnTotalAmount(showProviderData){
    totalAmount = 0.0;
    List list = showProviderData.showPaymentValidData;
    for(dynamic item in list){
      totalAmount = totalAmount + item["amount"];
    }
  }
}
