import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:polycrome_sales_application/localDb/app_database.dart';
import 'package:provider/provider.dart';

import '../providers/order_return_payment_provider.dart';

class AchievementCard extends StatefulWidget {
  List<Map<String, dynamic>> list = [];
   AchievementCard({
    super.key,
    required this.list
  });

  @override
  State<AchievementCard> createState() => _AchievementCardState();
}

class _AchievementCardState extends State<AchievementCard> {
  final numberFormatter = NumberFormat('#,##0.00');
  List<Map<String, dynamic>> refreshList = [];
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final showOrderReturnProductValidData = Provider.of<OrderReturnPaymentProvider>(context);

    return showOrderReturnProductValidData.isDiscountPress ?  Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Center(
              child: Text(
                "Current Achievements",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const Divider(thickness: 1),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount:widget.list.length,
              itemBuilder: (context, index) => _buildCategoryRow(index),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    ):SizedBox();
  }

  fetchRefreshList(){
    final orderReturnPaymentProvider = Provider.of<OrderReturnPaymentProvider>(context);
    refreshList = orderReturnPaymentProvider.discountDataList;
    setState(() {

    });
  }


  Widget _buildCategoryRow(int index) {
    if (index >= widget.list.length) {
      return const SizedBox.shrink();
    }

    final item = widget.list[index];
    return FutureBuilder(
      future: AppDatabase.instance.getAllDiscountDataFilteredDiscountId(item["discountId"]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(12),
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final discountList = snapshot.data ?? [];
        if (discountList.isEmpty) {
          return const Text("No discount found");
        }

        final discount = discountList.first;
        double difference = item["total"] < discount.minimum_amount
            ? (discount.minimum_amount - item["total"])
            : item["total"] > discount.minimum_amount && item["total"] < discount.maximum_amount
            ? (discount.maximum_amount - item["total"])
            : item["total"] > discount.maximum_amount
            ? (discount.maximum_amount - item["total"])
            : 0;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey, width: 0.5),
                bottom: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(minHeight: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              discount.name,
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Min: ${numberFormatter.format(discount.minimum_amount)}",
                                  style: TextStyle(fontSize: 13, color: (item["total"] > discount.minimum_amount && item["total"] < discount.maximum_amount) ||  difference < 0.0 ? Colors.green  : Colors.grey
                                  ),
                                ),
                                Text(
                                  "Max:${numberFormatter.format(discount.maximum_amount)}",
                                  style:  TextStyle(fontSize: 13, color: (item["total"] > discount.minimum_amount && item["total"] < discount.maximum_amount) ||  difference < 0.0 ? Colors.green  : Colors.grey
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),

                        Text(
                        "Total Amount : ${numberFormatter.format(item["total"])}",
                        style: const TextStyle(fontSize: 13, color: Colors.green),
                        ),
                        Text(
                          "Discount Amount : ${(numberFormatter.format(item["total"]*discount.discount_percentage/100))}",
                          style: const TextStyle(fontSize: 13, color: Colors.deepPurple),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                            "Target to Achieve : ${difference<0.0 ? 0.0 : numberFormatter.format(difference)}",
                            style: const TextStyle(fontSize: 13, color: Colors.deepPurple),
                                                  ),
                            item["total"] > discount.minimum_amount && item["total"] < discount.maximum_amount || difference < 0.0 ? Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.green, width: 2),
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.green,
                                size: 18, // You can adjust size
                              ),
                            ) :SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

  }

}
