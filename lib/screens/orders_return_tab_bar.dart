import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:polycrome_sales_application/reusableWidgets/drop_down.dart';
import 'package:provider/provider.dart';
import '../localDb/app_database.dart';
import '../providers/order_return_payment_provider.dart';
import '../reusableWidgets/achievement_cart.dart';
import '../reusableWidgets/order_return_cart.dart';
import '../reusableWidgets/showDialog.dart';
import '../widgets/product_dragable_sheet.dart';

class OrdersReturnTabBarDetails extends StatefulWidget {
  final int liternary_Id;
  final String orderOrReturn;
  const OrdersReturnTabBarDetails({super.key,required this.liternary_Id,required this.orderOrReturn});

  @override
  State<OrdersReturnTabBarDetails> createState() => _OrdersReturnTabBarDetailsState();
}

class _OrdersReturnTabBarDetailsState extends State<OrdersReturnTabBarDetails> {
  final numberFormatter = NumberFormat('#,##0.00');
  double totalAmount = 0.0;
  List<Map<String, dynamic>> discountDetails = [];
  List<Map<String, dynamic>> invoiceList = [];
  @override
  void initState() {
    if(widget.orderOrReturn == "Order"){
      Provider.of<OrderReturnPaymentProvider>(context, listen: false).fetchOrderProductValidData(widget.liternary_Id,context,false);
    }else{
      Provider.of<OrderReturnPaymentProvider>(context, listen: false).fetchReturnProductValidData(widget.liternary_Id);
      invoiceList = Provider.of<OrderReturnPaymentProvider>(context, listen: false).showPaymentInvoicesDropData;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final productSheet = ProductDraggableSheet();
    final showOrderReturnProductValidData = Provider.of<OrderReturnPaymentProvider>(context);
    calOrderReturnTotalAmount(showOrderReturnProductValidData);
    return Container(
      constraints: BoxConstraints(minHeight: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.orderOrReturn != "Order" ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width:double.infinity,
                height: 40,
                child: StyledDropdown(
                    dataList:invoiceList,
                    hintText: "Invoices",
                    onChange: (value){
                  }),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        onPressed: () async{
                          List<Map<String, dynamic>> list =
                          await fetchDbProductData(showOrderReturnProductValidData.showReturnProductValidData);
                          productSheet.openDraggableSheet(
                            widget.orderOrReturn,
                            context,
                            list,
                            {},
                            widget.liternary_Id,
                                () async{
                              await Provider.of<OrderReturnPaymentProvider>(context, listen: false).fetchReturnProductValidData(widget.liternary_Id);
                            },
                          );
                          setState(() {});
                        },
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text(
                          "Add Product",
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
            ],
          ):  Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () async{
                      List<Map<String, dynamic>> list =
                      await fetchDbProductData(showOrderReturnProductValidData.showOrderProductValidData);
                      productSheet.openDraggableSheet(
                        widget.orderOrReturn,
                        context,
                        list,
                        {},
                        widget.liternary_Id,
                            () async{
                          await Provider.of<OrderReturnPaymentProvider>(context, listen: false).fetchOrderProductValidData(widget.liternary_Id,context,false);
                        },
                      );
                      setState(() {});
                    },
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text(
                      "Add Product",
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
              widget.orderOrReturn == "Order" ? Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () async{
                      checkAndAddFreeIssueData(showOrderReturnProductValidData);
                      // discountProvider.setIsFreeIssueState(true);
                      setState(() {

                      });
                    },
                    label: const Text(
                      "Free Issue",
                      style: TextStyle(fontSize: 10),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:   Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(120, 36),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ): Expanded(flex:1,child: SizedBox()),
              widget.orderOrReturn == "Order" ?Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () async{
                      if(!showOrderReturnProductValidData.isDiscountPress){
                        showOrderReturnProductValidData.setIsDiscountState(true);
                      }else{
                        showOrderReturnProductValidData.setIsDiscountState(false);
                      }
                      await Provider.of<OrderReturnPaymentProvider>(context, listen: false).fetchOrderProductValidData(widget.liternary_Id,context,true);
                    },
                    label: const Text(
                      "Discount",
                      style: TextStyle(fontSize: 10),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !showOrderReturnProductValidData.isDiscountPress ?  Theme.of(context).primaryColor : Colors.blueGrey,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(120, 36),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ):Expanded(flex:1,child: SizedBox()),
            ],
          ),
          SizedBox(height: 5,),
          Expanded(
            flex: 20,
            child: ListView.builder(
              itemCount: widget.orderOrReturn == "Order"
                  ? showOrderReturnProductValidData.showOrderProductValidData.length +1
                  : showOrderReturnProductValidData.showReturnProductValidData.length ,
              itemBuilder: (context, index) {
                final isLast = widget.orderOrReturn == "Order"
                    ? index == showOrderReturnProductValidData.showOrderProductValidData.length
                    : index == showOrderReturnProductValidData.showReturnProductValidData.length;

                if (isLast) {
                  return AchievementCard(list:showOrderReturnProductValidData.discountDataList);
                }
                return OrderReturnCart(
                  orderOrReturn: widget.orderOrReturn,
                  orderReturnValidData: widget.orderOrReturn == "Order"
                      ? showOrderReturnProductValidData.showOrderProductValidData
                      : showOrderReturnProductValidData.showReturnProductValidData,
                  index: index,
                  liternary_Id: widget.liternary_Id,
                  onTap: ()async{
                    if(showOrderReturnProductValidData.showOrderProductValidData[index]["is_discount_product"]){
                      return;
                    }
                    List<Map<String, dynamic>> list =
                    widget.orderOrReturn == "Order" ?
                    await fetchDbProductData(showOrderReturnProductValidData.showOrderProductValidData):
                    await fetchDbProductData(showOrderReturnProductValidData.showReturnProductValidData);
                    productSheet.openDraggableSheet(
                      widget.orderOrReturn,
                      context,
                      list,
                      widget.orderOrReturn == "Order" ? showOrderReturnProductValidData.showOrderProductValidData[index] : showOrderReturnProductValidData.showReturnProductValidData[index],
                      widget.liternary_Id,
                          () async{
                        widget.orderOrReturn == "Order" ?
                        await Provider.of<OrderReturnPaymentProvider>(context, listen: false).fetchOrderProductValidData(widget.liternary_Id,context,false):
                        await Provider.of<OrderReturnPaymentProvider>(context, listen: false).fetchReturnProductValidData(widget.liternary_Id);
                      },
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 5,),
          Expanded(
            flex: 2,
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
              child:  Row(
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
          Spacer(),
        ],
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchDbProductData(List<Map<String, dynamic>> validQtyWithList) async {
    final localDb = AppDatabase.instance;
    List<Map<String, dynamic>> convertProductDbData = [];

    try {
      final List<ProductMasterData> localData = await localDb.getAllProductMaster();

      for (final item in localData) {
        final matchedUsage = validQtyWithList.cast<Map<String, dynamic>?>().firstWhere(
              (usage) => usage?["id"] == item.id,
          orElse: () => null,
        );

        convertProductDbData.add({
          'adQty': matchedUsage != null ? matchedUsage["adQty"] : 0,
          'id': item.id,
          'imager': item.imageUrl,
          'displayName': item.displayName,
          'salePrice': item.salesPrice,
          'productCategoryId':item.productCategoryId
        });
      }
      return convertProductDbData;
    } catch (e) {
      debugPrint("Error fetching product data 6: $e");
      return [];
    }
  }

  checkAndAddFreeIssueData(OrderReturnPaymentProvider showOrderReturnProductValidData) async {
    List<Map<String, dynamic>> loyaltyFreeIssueData = [];
    final data = await AppDatabase.instance.getAllLoyaltyFreeIssueData();
    loyaltyFreeIssueData = data.map((item) => {
      'productId': item.productId,
      'displayName': item.displayName,
      'minimumQty': item.minimumQty,
      'stock_lot_id': item.stock_lot_id,
      'reward_product_qty': item.reward_product_qty,
    }).toList();

    for (var item1 in showOrderReturnProductValidData.showOrderProductValidData) {
      print("mkol....$item1");
      for (var item2 in loyaltyFreeIssueData) {
        if (item1["productId"] == item2["productId"]) {
          if (!item1["is_reward"] && item2["minimumQty"] <= item1["adQty"]){
            AppDatabase.instance.updateIsRewarded(id: item1["orderUsageTableId"], isReward: true);
            item1["is_reward"] = true;
          final result = await AppDatabase.instance
              .addFreeIssueOrderProductUsage(
              itineraryLineId: widget.liternary_Id,
              productId: item1["id"],
              adQty: item1["adQty"]*item2["reward_product_qty"] ?? 1,
              isReward: true,
              rewardAmount: (item1["adQty"]*item2["reward_product_qty"] ?? 1)*item1["salePrice"],
              stockLotId: item2["stock_lot_id"],
              isFreeProduct: true
          );
          if (result != null) {
            print("Insert successful. New ID: $result");
          } else {
            print("Insert skipped: Either record exists or adQty <= 0");
          }
        }
      }
      }
    }
    Provider.of<OrderReturnPaymentProvider>(context, listen: false)
        .fetchOrderProductValidData(widget.liternary_Id,context,false);
  }
  calOrderReturnTotalAmount(showProviderData){
     totalAmount = 0.0;
    List list = widget.orderOrReturn == "Order" ? showProviderData.showOrderProductValidData: showProviderData.showReturnProductValidData;
    for(dynamic item in list){
      totalAmount = totalAmount + (item["adQty"]*item["salePrice"]);
    }
    // widget.orderOrReturn == "Order" ?
  }
}
