import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:polycrome_sales_application/reusableWidgets/showDialog.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../localDb/app_database.dart';
import '../providers/order_return_payment_provider.dart';

class OrderReturnCart extends StatelessWidget {
  final String orderOrReturn;
  final List<dynamic> orderReturnValidData;
  final int index;
  final int liternary_Id;
  final VoidCallback onTap;

  const OrderReturnCart({
    super.key,
    required this.orderOrReturn,
    required this.orderReturnValidData,
    required this.index,
    required this.liternary_Id,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    print("cbbnn........${orderReturnValidData}");
    final orderReturnProviderData = Provider.of<OrderReturnPaymentProvider>(context);
    final dataBase = AppDatabase.instance;
    final numberFormatter = NumberFormat('#,##0.00');
    return GestureDetector(
      onTap:onTap,
      child: Dismissible(
         direction: orderOrReturn == "Order" && (orderReturnValidData[index]["isFreeProduct"] || orderReturnValidData[index]["is_discount_product"]) ?  DismissDirection.none :DismissDirection.endToStart ,
        key: UniqueKey(),
        // direction: DismissDirection.endToStart,
        confirmDismiss: (direction) async {
          final confirmed = await showConfirmationDialog(
            context,
            "Are you sure you want to delete this product?",
            actionType: 'delete',
          );
          if (confirmed == true){
            if(orderOrReturn == "Order"){
              await dataBase.deleteOrderProductUsageByLineAndProduct(
                itineraryLineId: liternary_Id,
                productId: orderReturnValidData[index]["id"],
              );
              await AppDatabase.instance.deleteDiscountOrderProductUsage(liternary_Id);
              orderReturnProviderData.fetchOrderProductValidData(liternary_Id,context,false);
            }else{
              bool deleted  = await dataBase.deleteReturnProductUsageByLineAndProduct(
                itineraryLineId: liternary_Id,
                productId: orderReturnValidData[index]["id"],
              );
              if (deleted) {
                print("Delete successful.");
              } else {
                print("No record found to delete.");
              }
              orderReturnProviderData.fetchReturnProductValidData(liternary_Id);
            }
            return true;
          }
          return false;
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
              color: Colors.white,
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
                        Text(
                          orderReturnValidData[index]["display_name"],
                          maxLines: 2,
                          style: TextStyle(
                            color: kCartColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Quantity : ${orderReturnValidData[index]["adQty"]}",
                          style: TextStyle(
                            color: kCartColor,
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Unit Price Rs : ${numberFormatter.format(orderReturnValidData[index]["salePrice"])}",
                              style: TextStyle(
                                color: kCartColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Total Rs : ${numberFormatter.format(orderReturnValidData[index]["salePrice"]*orderReturnValidData[index]["adQty"])}",
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
      ),
    );
  }
}
