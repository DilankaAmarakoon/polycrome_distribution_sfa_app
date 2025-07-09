import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../localDb/app_database.dart';
import '../providers/order_return_payment_provider.dart';
import '../providers/product_data.provider.dart';
import '../reusableWidgets/drop_down.dart';
import '../reusableWidgets/product_cart.dart';
import '../reusableWidgets/serchField.dart';

class ProductDraggableSheet {
  TextEditingController searchField = TextEditingController();
  String searchText = "";
  int selectedCategoryId = 1;

  Future<void> openDraggableSheet(
      String orderOrReturn,
      BuildContext context,
      List<Map<String, dynamic>> convertProductDbData,
      Map selectedProductList,
      int liternary_Id,
      VoidCallback onPressed,
      ) async {
    final productDataProvider = Provider.of<ProductDataProvider>(context,listen: false);
    final orderReturnPaymentProvider = Provider.of<OrderReturnPaymentProvider>(context, listen: false);
    await Provider.of<ProductDataProvider>(context, listen: false).fetchcatergoryData();
    final DraggableScrollableController sheetController = DraggableScrollableController();
    final TextEditingController searchField = TextEditingController();

    productDataProvider.setProductDataSearchValidData = List.from(convertProductDbData);

    if(selectedProductList.isNotEmpty){
      searchField.text = selectedProductList["display_name"];
      _searchFilter(selectedProductList["display_name"],productDataProvider.ProductDataSearchValidData,convertProductDbData,productDataProvider,selectedCategoryId);
    }

    sheetController.addListener(() {
      final size = sheetController.size;
      if (size <= 0.5) {
        orderReturnPaymentProvider.fetchOrderProductValidData(liternary_Id,context,false);
      }
    });

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext sheetContext) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return DraggableScrollableSheet(
                controller: sheetController,
                initialChildSize: 0.8,
                minChildSize: 0.5,
                maxChildSize: 0.95,
                builder: (context, scrollController) {
                  List<Map<String, dynamic>> showCatergoryList = Provider.of<ProductDataProvider>(context).categoryShowData;
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Column(
                      children: [
                        buildSearchField(
                          context: context,
                          hintText: "Search Product...",
                          controller: searchField,
                          onChanged: (String value) {
                            searchText = value;
                              _searchFilter(value,productDataProvider.ProductDataSearchValidData,convertProductDbData,productDataProvider,selectedCategoryId);
                          },
                        ),
                        StyledDropdown(
                          dataList: showCatergoryList,
                          onChange: (selectValue){
                            selectedCategoryId = selectValue!["id"];
                             _searchFilter(searchText,productDataProvider.ProductDataSearchValidData,convertProductDbData,productDataProvider,selectedCategoryId );
                          },
                        ),
                        const Divider(height: 1),
                        Expanded(
                          flex: 3,
                          child: Consumer<ProductDataProvider>(
                            builder: (context, provider, child) {
                              return ListView.builder(
                                controller: scrollController,
                                itemCount: provider.ProductDataSearchValidData.length,
                                itemBuilder: (context, index) {
                                  return ProductCart(
                                    orderOrReturn: orderOrReturn,
                                    productList: provider.ProductDataSearchValidData,
                                    index: index,
                                    liternary_Id: liternary_Id,
                                  );
                                },
                              );
                            },
                          )

                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    ).then((value) {
      onPressed();
    });
  }
  void _searchFilter(String enteredKeyword, List<Map<String, dynamic>> showList,List<Map<String, dynamic>> allProductList,ProductDataProvider provider,int catergoryId) {
    late List<Map<String, dynamic>> results = [];
    provider.setProductDataSearchValidData = [];
    if (enteredKeyword.isEmpty) {
      if(catergoryId == 1){
        for (dynamic item in allProductList) {
          results.add(item);
        }
      }else{
        for (dynamic item in allProductList) {
          if(catergoryId == item["productCategoryId"]){
            results.add(item);
          }
        }
      }
    }
    else {
      if(catergoryId == 1){
        for (dynamic item in showList) {
          if (item["displayName"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase())) {
            results.add(item);
          }
        }
      }else{
        for (dynamic item in showList) {
          if(catergoryId == item["productCategoryId"]){
            if (item["displayName"]
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase())) {
              results.add(item);
            }
          }
        }
      }
    }
    provider.setProductDataSearchValidData = results;
  }
 }

