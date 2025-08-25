import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:polycrome_sales_application/reusableWidgets/drop_down.dart';
import 'package:polycrome_sales_application/widgets/return_remark_popup.dart';
import 'package:provider/provider.dart';
import '../localDb/app_database.dart';
import '../providers/order_return_payment_provider.dart';
import '../reusableWidgets/achievement_cart.dart';
import '../reusableWidgets/order_return_cart.dart';
import '../widgets/product_dragable_sheet.dart';

class OrdersReturnTabBarDetails extends StatefulWidget {
  final int liternary_Id;
  final String orderOrReturn;
  const OrdersReturnTabBarDetails({super.key, required this.liternary_Id, required this.orderOrReturn});

  @override
  State<OrdersReturnTabBarDetails> createState() => _OrdersReturnTabBarDetailsState();
}

class _OrdersReturnTabBarDetailsState extends State<OrdersReturnTabBarDetails>
    with SingleTickerProviderStateMixin {
  final numberFormatter = NumberFormat('#,##0.00');
  double totalAmount = 0.0;
  List<Map<String, dynamic>> discountDetails = [];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut)
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    if (widget.orderOrReturn == "Order") {
      Provider.of<OrderReturnPaymentProvider>(context, listen: false)
          .fetchOrderProductValidData(widget.liternary_Id, context, false);
    } else {
      Provider.of<OrderReturnPaymentProvider>(context, listen: false)
          .fetchReturnProductValidData(widget.liternary_Id);
    }

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final productSheet = ProductDraggableSheet();
    final showOrderReturnProductValidData = Provider.of<OrderReturnPaymentProvider>(context);
    calOrderReturnTotalAmount(showOrderReturnProductValidData);

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Compact Return Invoice Selection (for Returns only)
            if (widget.orderOrReturn != "Order") ...[
              Container(
                margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      color: theme.colorScheme.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Return Invoice",
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: StyledDropdown(
                  dataList: showOrderReturnProductValidData.showReturnInvoicesDropData,
                  hintText: "Select Invoice",
                  onChange: (value) async {
                    if (value != null) {
                      await showOrderReturnProductValidData.fetchReturnInvoicesLines(
                          value["id"], widget.liternary_Id, value["name"]);
                      Provider.of<OrderReturnPaymentProvider>(context, listen: false)
                          .fetchReturnProductValidData(widget.liternary_Id);
                      setState(() {});
                    }
                  },
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Compact Action Buttons Section
            _buildCompactActionButtonsSection(showOrderReturnProductValidData, productSheet, theme),

            const SizedBox(height: 8),

            // Main Content List Section (Maximum space)
            Consumer<OrderReturnPaymentProvider>(
              builder: (context, provider, _) {
                return provider.outStandingState.isNotEmpty &&
                    widget.orderOrReturn == "Order" &&
                    showOrderReturnProductValidData.showOrderProductValidData.isEmpty
                    ? _buildCompactOutstandingStateError(showOrderReturnProductValidData, theme)
                    : Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: widget.orderOrReturn == "Order"
                          ? showOrderReturnProductValidData.showOrderProductValidData.length + 1
                          : showOrderReturnProductValidData.showReturnProductValidData.length,
                      itemBuilder: (context, index) {
                        final isLast = widget.orderOrReturn == "Order"
                            ? index == showOrderReturnProductValidData.showOrderProductValidData.length
                            : index == showOrderReturnProductValidData.showReturnProductValidData.length;

                        if (isLast) {
                          return AchievementCard(
                              list: showOrderReturnProductValidData.discountDataList);
                        }

                        return OrderReturnCart(
                          orderOrReturn: widget.orderOrReturn,
                          orderReturnValidData: widget.orderOrReturn == "Order"
                              ? showOrderReturnProductValidData.showOrderProductValidData
                              : showOrderReturnProductValidData.showReturnProductValidData,
                          index: index,
                          liternary_Id: widget.liternary_Id,
                          onTap: () async {
                            if (widget.orderOrReturn == "Order" &&
                                showOrderReturnProductValidData.showOrderProductValidData[index]
                                ["is_discount_product"]) {
                              return;
                            }

                            List<Map<String, dynamic>> list = widget.orderOrReturn == "Order"
                                ? await fetchDbProductData(
                                showOrderReturnProductValidData.showOrderProductValidData)
                                : await fetchDbProductData(
                                showOrderReturnProductValidData.showReturnProductValidData);

                            productSheet.openDraggableSheet(
                              widget.orderOrReturn,
                              context,
                              list,
                              widget.orderOrReturn == "Order"
                                  ? showOrderReturnProductValidData.showOrderProductValidData[index]
                                  : showOrderReturnProductValidData.showReturnProductValidData[index],
                              widget.liternary_Id,
                                  () async {
                                widget.orderOrReturn == "Order"
                                    ? await Provider.of<OrderReturnPaymentProvider>(context, listen: false)
                                    .fetchOrderProductValidData(widget.liternary_Id, context, false)
                                    : await Provider.of<OrderReturnPaymentProvider>(context, listen: false)
                                    .fetchReturnProductValidData(widget.liternary_Id);
                              },
                            );
                          },
                          onLongPress: () {
                            if (widget.orderOrReturn == "Order") return;
                            int productId = showOrderReturnProductValidData
                                .showReturnProductValidData[index]["id"];
                            showReturnRemarkDialog(context, index, showOrderReturnProductValidData,
                                productId, widget.liternary_Id)
                                .then((value) async {
                              await Provider.of<OrderReturnPaymentProvider>(context, listen: false)
                                  .fetchReturnProductValidData(widget.liternary_Id);
                            });
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),

            // Compact Total Amount Section
            _buildCompactTotalAmountSection(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactActionButtonsSection(OrderReturnPaymentProvider provider, ProductDraggableSheet productSheet, ThemeData theme) {
    if (widget.orderOrReturn != "Order") {
      // Return view - single compact Add Product button
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        height: 38,
        child: Row(
          children: [
            Expanded(
              child: _buildCompactActionButton(
                icon: Icons.add_outlined,
                label: "Add Product",
                onPressed: () async {
                  List<Map<String, dynamic>> list = await fetchDbProductData(
                      provider.showReturnProductValidData);
                  productSheet.openDraggableSheet(
                    widget.orderOrReturn,
                    context,
                    list,
                    {},
                    widget.liternary_Id,
                        () async {
                      await Provider.of<OrderReturnPaymentProvider>(context, listen: false)
                          .fetchReturnProductValidData(widget.liternary_Id);
                    },
                  );
                  setState(() {});
                },
                theme: theme,
              ),
            ),
          ],
        ),
      );
    } else {
      // Order view - all three buttons in one row
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 0),
        height: 38,
        child: Row(
          children: [
            // Add Product button
            Expanded(
              flex: 2,
              child: _buildCompactActionButton(
                icon: Icons.add_outlined,
                label: "Add Product",
                fontSize: 11,
                onPressed: () async {
                  List<Map<String, dynamic>> list = await fetchDbProductData(
                      provider.showOrderProductValidData);
                  productSheet.openDraggableSheet(
                    widget.orderOrReturn,
                    context,
                    list,
                    {},
                    widget.liternary_Id,
                        () async {
                      await Provider.of<OrderReturnPaymentProvider>(context, listen: false)
                          .fetchOrderProductValidData(widget.liternary_Id, context, false);
                    },
                  );
                  setState(() {});
                },
                theme: theme,
              ),
            ),


            // Free Issue button
            Expanded(
              flex: 1,
              child: _buildCompactActionButton(
                icon: Icons.card_giftcard_outlined,
                label: "Free Issue",
                fontSize: 10,
                onPressed: () async {
                  checkAndAddFreeIssueData(provider);
                  setState(() {});
                },
                theme: theme,
              ),
            ),


            // Discount button
            Expanded(
              flex: 1,
              child: _buildCompactActionButton(
                icon: Icons.discount_outlined,
                label: "Discount",
                fontSize: 10,
                backgroundColor: !provider.isDiscountPress
                    ? theme.colorScheme.primary
                    : Colors.blueGrey,
                onPressed: () async {
                  provider.setIsDiscountState(!provider.isDiscountPress);
                  await Provider.of<OrderReturnPaymentProvider>(context, listen: false)
                      .fetchOrderProductValidData(widget.liternary_Id, context, true);
                },
                theme: theme,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildCompactActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required ThemeData theme,
    Color? backgroundColor,
    double fontSize = 12,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 12),
        label: Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? theme.colorScheme.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }

  Widget _buildCompactOutstandingStateError(OrderReturnPaymentProvider provider, ThemeData theme) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.orange.shade200,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                Icons.warning_outlined,
                size: 24,
                color: Colors.orange.shade600,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              "Credit Limit Warning",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.orange.shade700,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            Text(
              provider.outStandingState,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.orange.shade600,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "Please resolve this issue before proceeding",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.orange.shade700,
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactTotalAmountSection(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withOpacity(0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.calculate_outlined,
              color: Colors.white,
              size: 18,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Total ${widget.orderOrReturn} Amount",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Rs ${numberFormatter.format(totalAmount)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              widget.orderOrReturn,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
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
          'productId': item.productId,
          'imager': item.imageUrl,
          'displayName': item.displayName,
          'salePrice': item.salesPrice,
          'productCategoryId': item.productCategoryId
        });
      }
      return convertProductDbData;
    } catch (e) {
      debugPrint("Error fetching product data 6: $e");
      return [];
    }
  }

  void checkAndAddFreeIssueData(OrderReturnPaymentProvider showOrderReturnProductValidData) async {
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
      for (var item2 in loyaltyFreeIssueData) {
        if (item1["productId"] == item2["productId"]) {
          if (!item1["is_reward"] && item2["minimumQty"] <= item1["adQty"]) {
            AppDatabase.instance.updateIsRewarded(id: item1["orderUsageTableId"], isReward: true);
            item1["is_reward"] = true;
            final result = await AppDatabase.instance.addFreeIssueOrderProductUsage(
              itineraryLineId: widget.liternary_Id,
              productId: item1["id"],
              adQty: (item1["adQty"] * item2["reward_product_qty"]) ?? 1,
              isReward: true,
              rewardAmount: ((item1["adQty"] * item2["reward_product_qty"]) ?? 1) * item1["salePrice"],
              stockLotId: item2["stock_lot_id"],
              isFreeProduct: true,
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
        .fetchOrderProductValidData(widget.liternary_Id, context, false);
  }

  void calOrderReturnTotalAmount(showProviderData) {
    totalAmount = 0.0;
    List list = widget.orderOrReturn == "Order"
        ? showProviderData.showOrderProductValidData
        : showProviderData.showReturnProductValidData;
    for (dynamic item in list) {
      totalAmount = totalAmount + (item["adQty"] * item["salePrice"]);
    }
  }
}