import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../localDb/app_database.dart';
import '../providers/order_return_provider.dart';
import '../reusableWidgets/order_cart.dart';
import '../widgets/product_dragable_sheet.dart';

class OrdersTabBarDetails extends StatefulWidget {
  final int liternary_Id;
  const OrdersTabBarDetails({super.key,required this.liternary_Id});

  @override
  State<OrdersTabBarDetails> createState() => _OrdersTabBarDetailsState();
}

class _OrdersTabBarDetailsState extends State<OrdersTabBarDetails> {
  @override
  void initState() {
    Provider.of<OrderReturnProvider>(context, listen: false).fetchOrderProductValidData(widget.liternary_Id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final productSheet = ProductDraggableSheet();
    final showOrderProductValidData = Provider.of<OrderReturnProvider>(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.77,
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
                      List<Map<String, dynamic>> list = await fetchDbProductData(showOrderProductValidData.showOrderProductValidData);
                      setState(() {
                        productSheet.openDraggableSheet(
                            context,list,widget.liternary_Id,
                          () {
                            Provider.of<OrderReturnProvider>(context, listen: false).fetchOrderProductValidData(widget.liternary_Id);
                            setState(() {});
                          },
                        );
                      });
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
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () async{},
                    label: const Text(
                      "Free Issue",
                      style: TextStyle(fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
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
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () async{},
                    label: const Text(
                      "Discount",
                      style: TextStyle(fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
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
          const SizedBox(height: 8),
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: showOrderProductValidData.showOrderProductValidData.length,
              itemBuilder: (context, index) => OrderCart(orderValidData:showOrderProductValidData.showOrderProductValidData,index:index,liternary_Id:widget.liternary_Id),
            ),
          ),
          const Divider(),
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
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
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Total Amount  : 25300",
                    style: TextStyle(color: Colors.white,fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // List<dynamic>ShowProductLine(){
  //   // final providerData = Provider.of<OrderReturnProvider>(context,listen: false);
  //   List<dynamic> showData = [];
  //   for(dynamic item in providerData.convertProductDbData){
  //     if(item["adQty"] !=0){
  //       showData.add(item);
  //     }
  //   }
  //   return showData;
  // }

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
      debugPrint("Error fetching product data: $e");
      return [];
    }
  }

}
