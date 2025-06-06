import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_return_provider.dart';
import '../reusableWidgets/product_cart.dart';

class ProductDraggableSheet {

  Future<void> openDraggableSheet(
      BuildContext context,
      List<Map<String, dynamic>> convertProductDbData,
      int liternary_Id,
      VoidCallback onPressed,
      ) async {
    final orderReturnProvider = Provider.of<OrderReturnProvider>(context, listen: false);
    final DraggableScrollableController sheetController = DraggableScrollableController();

    sheetController.addListener(() {
      final size = sheetController.size;
      if (size <= 0.5) {
        orderReturnProvider.fetchOrderProductValidData(liternary_Id);
      }
      if (size > 0.8) {
      }
    });

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext sheetContext) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: DraggableScrollableSheet(
            controller: sheetController,
            initialChildSize: 0.8,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: convertProductDbData.length,
                  itemBuilder: (context, index) {
                    return ProductCart(
                      productList: convertProductDbData,
                      index: index,
                        liternary_Id:liternary_Id
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    ).then((value) {
     onPressed();
    });
  }
}

