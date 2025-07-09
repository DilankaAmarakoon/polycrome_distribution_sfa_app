import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:polycrome_sales_application/reusableWidgets/showDialog.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../localDb/app_database.dart';
import '../providers/order_return_payment_provider.dart';

class PaymentCart extends StatelessWidget {
  final List<dynamic> paymentValidData;
  final int index;
  final int liternary_Id;
  final VoidCallback onTap;

  const PaymentCart({
    super.key,
    required this.paymentValidData,
    required this.index,
    required this.liternary_Id,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dataBase = AppDatabase.instance;
    final numberFormatter = NumberFormat('#,##0.00');
    return GestureDetector(
      onTap:onTap,
      child: Dismissible(
        key: UniqueKey(),
        direction: !paymentValidData[index]["isExciteOrNew"] ? DismissDirection.endToStart :DismissDirection.none ,
        confirmDismiss: (direction) async {
          final confirmed = await showConfirmationDialog(
            context,
            "Are you sure you want to delete this payment?",
            actionType: 'delete',
          );
          if ( confirmed! && !paymentValidData[index]["isExciteOrNew"]) {
            await dataBase.deletePaymentUsageByPaymentLineIdIfNotExciteOrNew(paymentValidData[index]["id"]);
            Provider.of<OrderReturnPaymentProvider>(context, listen: false).fetchPaymentValidData(liternary_Id);
            return true;
          } else {
            return false;
          }
        },
        background: Container(
          color: Colors.redAccent,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Container(
            constraints: BoxConstraints(minHeight: 50),
            width: double.infinity,
            decoration: BoxDecoration(
              color: !paymentValidData[index]["isExciteOrNew"] ? Colors.grey.shade200 : Colors.white,
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
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              paymentValidData[index]["invoice_name"],
                              maxLines: 2,
                              style: TextStyle(
                                color: kCartColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "Inv. Due Amount Rs : ${numberFormatter.format(paymentValidData[index]["invoice_amount"])}",
                              style: TextStyle(
                                color: kCartColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              paymentValidData[index]["date"],
                              style: TextStyle(
                                color: kCartColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Amount Rs : ${numberFormatter.format(paymentValidData[index]["amount"])}",
                              style: TextStyle(
                                color: kCartColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
