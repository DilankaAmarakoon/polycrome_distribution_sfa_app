import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../localDb/app_database.dart';
import '../providers/order_return_provider.dart';
class ProductCart extends StatefulWidget {
  final List productList;
  final int index;
  final int liternary_Id;

  const ProductCart({
    super.key,
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
  @override
  void initState() {
    qty.text = widget.productList[widget.index]["adQty"].toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
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
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product["productName"] ?? "Unnamed Product",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(product["itemCode"] ?? "No Code"),
                    Text("Rs : ${product["salePrice"] ?? 0.0}"),
                    Container(
                      width: 120,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
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
                                qty.text = currentQty.toString();
                              });
                              addProductUsageTableToData(productId:product["id"],qty:int.parse(qty.text),liternary_Id:widget.liternary_Id);
                            },
                            child: Container(
                              width: 30,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: kMainColor,
                                border: Border(
                                  right: BorderSide(color: Colors.grey),
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(0),
                                  bottomLeft: Radius.circular(0),
                                ),
                              ),
                              child: const Icon(Icons.remove, size: 20),
                            ),
                          ),

                          // Quantity input field, no border, centered text
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: qty,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 8),
                                isDense: true,
                              ),
                              onChanged: (value) async{
                                final parsed = int.tryParse(value);
                                if (parsed != null && parsed >= 0) {
                                  setState(() {
                                    qty.text = parsed.toString();
                                  });
                                  addProductUsageTableToData(productId:product["id"],qty:int.parse(qty.text),liternary_Id:widget.liternary_Id);
                                }
                              },
                            ),
                          ),

                          // Plus button with border on left side only
                          InkWell(
                            onTap: () async{
                              setState(() {
                                int currentQty = qty.text == "" ? 0 : int.parse(qty.text);
                                currentQty++;
                                qty.text = currentQty.toString();
                              });
                              addProductUsageTableToData(productId:product["id"],qty:int.parse(qty.text),liternary_Id:widget.liternary_Id);
                            },
                            child: Container(
                              width: 30,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: kMainColor,
                                border: Border(
                                  left: BorderSide(color: Colors.grey),
                                ),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                ),
                              ),
                              child: const Icon(Icons.add, size: 20),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
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
                    width: 50,
                    height: 50,
                    child: Icon(Icons.broken_image, color: Colors.grey),
                  ),
            ],
          ),
        ),
      ),
    );
  }


  addProductUsageTableToData({required productId, required int qty, required int liternary_Id})async {
    print("mkol.${productId}");
    await dataBase.addOrUpdateOrRemoveProductUsage(
        itineraryLineId: liternary_Id,
        productId: productId,
        adQty: qty
    );
  }
}
