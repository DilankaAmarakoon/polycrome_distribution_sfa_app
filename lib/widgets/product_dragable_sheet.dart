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
    final productDataProvider = Provider.of<ProductDataProvider>(context, listen: false);
    final orderReturnPaymentProvider = Provider.of<OrderReturnPaymentProvider>(context, listen: false);
    await Provider.of<ProductDataProvider>(context, listen: false).fetchCatergoryData();
    final DraggableScrollableController sheetController = DraggableScrollableController();
    final TextEditingController searchField = TextEditingController();

    productDataProvider.setProductDataSearchValidData = List.from(convertProductDbData);

    if (selectedProductList.isNotEmpty) {
      searchField.text = selectedProductList["display_name"];
      _searchFilter(selectedProductList["display_name"], productDataProvider.ProductDataSearchValidData,
          convertProductDbData, productDataProvider, selectedCategoryId);
    }

    sheetController.addListener(() {
      final size = sheetController.size;
      if (size <= 0.5) {
        orderReturnPaymentProvider.fetchOrderProductValidData(liternary_Id, context, false);
      }
    });

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (BuildContext sheetContext) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: StatefulBuilder(
            builder: (context, setModalState) {
              final theme = Theme.of(context);

              return DraggableScrollableSheet(
                controller: sheetController,
                initialChildSize: 0.85,
                minChildSize: 0.5,
                maxChildSize: 0.95,
                builder: (context, scrollController) {
                  List<Map<String, dynamic>> showCategoryList = Provider.of<ProductDataProvider>(context).categoryShowData;

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, -8),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Drag Handle
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),

                        // Header Section
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                theme.colorScheme.primary.withOpacity(0.05),
                                theme.colorScheme.primary.withOpacity(0.02),
                              ],
                            ),
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade200,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      theme.colorScheme.primary.withOpacity(0.1),
                                      theme.colorScheme.primary.withOpacity(0.05),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: theme.colorScheme.primary.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Icon(
                                  orderOrReturn == "Order"
                                      ? Icons.shopping_cart_outlined
                                      : Icons.assignment_return_outlined,
                                  color: theme.colorScheme.primary,
                                  size: 24,
                                ),
                              ),

                              const SizedBox(width: 16),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      orderOrReturn == "Order"
                                          ? "Select Products for Order"
                                          : "Select Products for Return",
                                      style: theme.textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: theme.colorScheme.onSurface,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Search and add products to your ${orderOrReturn.toLowerCase()}",
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                                        letterSpacing: 0.1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              IconButton(
                                onPressed: () => Navigator.of(sheetContext).pop(),
                                icon: Icon(
                                  Icons.close_rounded,
                                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                                ),
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.grey.shade100,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Search and Filter Section
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              // Search Field
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                    width: 1,
                                  ),
                                ),
                                child: buildSearchField(
                                  context: context,
                                  hintText: "Search products...",
                                  controller: searchField,
                                  onChanged: (String value) {
                                    searchText = value;
                                    _searchFilter(value, productDataProvider.ProductDataSearchValidData,
                                        convertProductDbData, productDataProvider, selectedCategoryId);
                                  },
                                ),
                              ),

                              const SizedBox(height: 12),

                              // Category Dropdown
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: StyledDropdown(
                                  dataList: showCategoryList,
                                  hintText: "Select Category",
                                  onChange: (selectValue) {
                                    selectedCategoryId = selectValue!["id"];
                                    _searchFilter(searchText, productDataProvider.ProductDataSearchValidData,
                                        convertProductDbData, productDataProvider, selectedCategoryId);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Results Header
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: Consumer<ProductDataProvider>(
                            builder: (context, provider, child) {
                              return Row(
                                children: [
                                  Icon(
                                    Icons.inventory_2_outlined,
                                    size: 18,
                                    color: theme.colorScheme.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Products",
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      "${provider.ProductDataSearchValidData.length} items",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),

                        // Divider
                        Container(
                          height: 1,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.grey.shade300,
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),

                        // Product List Section
                        Expanded(
                          child: Consumer<ProductDataProvider>(
                            builder: (context, provider, child) {
                              if (provider.ProductDataSearchValidData.isEmpty) {
                                return _buildEmptyState(theme, searchText, selectedCategoryId);
                              }

                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: ListView.builder(
                                  controller: scrollController,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: provider.ProductDataSearchValidData.length,
                                  itemBuilder: (context, index) {
                                    return ProductCart(
                                      orderOrReturn: orderOrReturn,
                                      productList: provider.ProductDataSearchValidData,
                                      index: index,
                                      liternary_Id: liternary_Id,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
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

  Widget _buildEmptyState(ThemeData theme, String searchText, int categoryId) {
    final bool isSearching = searchText.isNotEmpty;
    final bool isFiltered = categoryId != 1;

    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(
                isSearching ? Icons.search_off : Icons.inventory_outlined,
                size: 40,
                color: Colors.grey.shade400,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              isSearching
                  ? "No products found"
                  : isFiltered
                  ? "No products in this category"
                  : "No products available",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            Text(
              isSearching
                  ? "Try adjusting your search terms"
                  : isFiltered
                  ? "Select a different category or clear filters"
                  : "Products will appear here when available",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),

            if (isSearching || isFiltered) ...[
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isSearching ? "Clear search to see all products" : "Select 'All Categories'",
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _searchFilter(String enteredKeyword, List<Map<String, dynamic>> showList,
      List<Map<String, dynamic>> allProductList, ProductDataProvider provider, int categoryId) {
    late List<Map<String, dynamic>> results = [];
    provider.setProductDataSearchValidData = [];

    if (enteredKeyword.isEmpty) {
      if (categoryId == 1) {
        for (dynamic item in allProductList) {
          results.add(item);
        }
      } else {
        for (dynamic item in allProductList) {
          if (categoryId == item["productCategoryId"]) {
            results.add(item);
          }
        }
      }
    } else {
      if (categoryId == 1) {
        for (dynamic item in showList) {
          if (item["displayName"].toLowerCase().contains(enteredKeyword.toLowerCase())) {
            results.add(item);
          }
        }
      } else {
        for (dynamic item in showList) {
          if (categoryId == item["productCategoryId"]) {
            if (item["displayName"].toLowerCase().contains(enteredKeyword.toLowerCase())) {
              results.add(item);
            }
          }
        }
      }
    }
    provider.setProductDataSearchValidData = results;
  }
}