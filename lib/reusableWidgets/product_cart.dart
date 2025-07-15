import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../localDb/app_database.dart';
class ProductCart extends StatefulWidget {
  final String orderOrReturn;
  final List productList;
  final int index;
  final int liternary_Id;

  const ProductCart({
    super.key,
    required this.orderOrReturn,
    required this.productList,
    required this.index,
    required this.liternary_Id,
  });

  @override
  State<ProductCart> createState() => _ProductCartState();
}
class _ProductCartState extends State<ProductCart> {
  final AppDatabase dataBase = AppDatabase.instance;
  late TextEditingController qty = TextEditingController();
  bool isAddedQty = false;
  final numberFormatter = NumberFormat('#,##0.00');
  bool checkUpdate = false;
  @override
  Widget build(BuildContext context) {
    checkUpdate = widget.productList[widget.index]["adQty"] >0 ? true :false;
    qty.text = widget.productList[widget.index]["adQty"].toString();
    if(widget.productList[widget.index]["adQty"] > 0){
      isAddedQty = true;
    }else{
      isAddedQty = false;
    }
    final product = widget.productList[widget.index];
    String? base64String = product["imager"];
    Uint8List? imageByte;

    if (base64String != null && base64String.isNotEmpty) {
      if (base64String.contains(',')) {
        base64String = base64String.split(',').last;
      }
      try {
        imageByte = base64Decode(base64String);
      } catch (e) {
        debugPrint("Image decode error: $e");
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isAddedQty ? Theme.of(context).primaryColor : Colors.white,
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
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product["displayName"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isAddedQty ? Colors.white : Colors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text("Unit Price Rs : ${numberFormatter.format(product["salePrice"] ?? 0.0)}",
                        style: TextStyle(
                          color: isAddedQty ? Colors.white : Colors.black,
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color:isAddedQty ? Colors.white :  Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () async{
                                setState(() {
                                  int currentQty = qty.text == "" ? 0 : int.parse(qty.text);
                                  if (currentQty > 0) {
                                    currentQty--;
                                  }
                                  widget.productList[widget.index]["adQty"] = currentQty;
                                  whenAddQtyChangeColor(currentQty);
                                  qty.text = currentQty.toString();
                                });
                                addProductUsageTableToData(productId:product["id"],qty:int.parse(qty.text),liternary_Id:widget.liternary_Id,);
                              },
                              child: Container(
                                width: 30,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: isAddedQty ?  Colors.white : Theme.of(context).primaryColor,
                                  border: Border(
                                    right: BorderSide(color:isAddedQty ? Colors.white :  Theme.of(context).primaryColor),
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                  ),
                                ),
                                child:  Icon(Icons.remove, size: 20,
                                  color: isAddedQty ?  Theme.of(context).primaryColor :Colors.white,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                cursorHeight: 20.0,
                                controller: qty,
                                style:  TextStyle(
                                  color: isAddedQty ?  Colors.white : Theme.of(context).primaryColor,
                                  fontSize: 20
                                ),
                                cursorColor: isAddedQty ?  Colors.white : Theme.of(context).primaryColor,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                                  isDense: true,
                                ),
                                onChanged: (value) async{
                                 value = value == "" ? 0.toString() : value;
                                  final parsed = int.tryParse(value);
                                  // if (parsed != null && parsed >= 0) {
                                  //   setState(() {
                                  //     // qty.text = parsed.toString();/
                                  //   });
                                  // }
                                  addProductUsageTableToData(productId:product["id"],qty:qty.text == "" ? 0 :int.parse(qty.text),liternary_Id:widget.liternary_Id,);

                                  whenAddQtyChangeColor(parsed!);
                                },
                              ),
                            ),
                            InkWell(
                              onTap: () async{
                                setState(() {
                                  int currentQty = qty.text == "" ? 0 : int.parse(qty.text);
                                  currentQty++;
                                  qty.text = currentQty.toString();
                                  widget.productList[widget.index]["adQty"] = currentQty;
                                  whenAddQtyChangeColor(currentQty);
                                });
                                addProductUsageTableToData(productId:product["id"],qty:int.parse(qty.text),liternary_Id:widget.liternary_Id,);
                              },
                              child: Container(
                                width: 30,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: isAddedQty ?  Colors.white : Theme.of(context).primaryColor,
                                  border: Border(
                                    left: BorderSide(color:isAddedQty ? Colors.white :  Theme.of(context).primaryColor),
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                  ),
                                ),
                                child:  Icon(Icons.add, size: 20,
                                  color: isAddedQty ?  Theme.of(context).primaryColor :Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ), // Add some spacing between text and image
              imageByte != null
                  ? Expanded(
                flex: 1,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.memory(
                        imageByte,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                  : const SizedBox(
                    width: 100,
                    height: 100,
                    child: Icon(Icons.broken_image, color: Colors.grey),
                  ),
            ],
          ),
        ),
      ),
    );
  }


  addProductUsageTableToData({required productId,  required int qty, required int liternary_Id})async {
    // print("mkol.qty${updateCurrentQty["adQty"]}");
    if(widget.orderOrReturn == "Order"){
      int? usageId = await dataBase.addOrUpdateOrRemoveOrderProductUsage(
          itineraryLineId: liternary_Id,
          productId: productId,
          adQty: qty
      );
      if(usageId != null && checkUpdate){
        await dataBase.updateFalseIsSyncedOrderProductUsage(id: usageId);
      }
    }else{
      int? usageId = await dataBase.addOrUpdateOrRemoveReturnProductUsageForInvoiceItems(
          itineraryLineId: liternary_Id,
          productId: productId,
          returnQty: qty
      );
      if(usageId != null && checkUpdate){
        await dataBase.updateFalseIsSyncedReturnProductUsage(id: usageId);
      }
    }
  }
  whenAddQtyChangeColor(int qty){
    if(qty>0){
      isAddedQty = true;
    }else{
      isAddedQty = false;
    }
  }
}
