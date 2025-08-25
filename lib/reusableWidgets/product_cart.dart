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

class _ProductCartState extends State<ProductCart> with TickerProviderStateMixin {
  final AppDatabase dataBase = AppDatabase.instance;
  late TextEditingController qty = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool isAddedQty = false;
  final numberFormatter = NumberFormat('#,##0.00');
  bool checkUpdate = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    qty.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    checkUpdate = widget.productList[widget.index]["adQty"] > 0 ? true : false;
    qty.text = widget.productList[widget.index]["adQty"].toString();

    if (widget.productList[widget.index]["adQty"] > 0) {
      isAddedQty = true;
    } else {
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: isAddedQty
                    ? Border.all(color: Theme.of(context).primaryColor, width: 2)
                    : Border.all(color: Colors.grey.shade200, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: isAddedQty
                        ? Theme.of(context).primaryColor.withOpacity(0.15)
                        : Colors.black.withOpacity(0.08),
                    blurRadius: isAddedQty ? 12 : 8,
                    offset: const Offset(0, 4),
                    spreadRadius: isAddedQty ? 2 : 0,
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    _animationController.forward().then((_) {
                      _animationController.reverse();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Product Image
                        _buildProductImage(imageByte),

                        const SizedBox(width: 16),

                        // Product Details
                        Expanded(
                          child: _buildProductDetails(product),
                        ),

                        const SizedBox(width: 12),

                        // Quantity Controls
                        _buildQuantityControls(product),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductImage(Uint8List? imageByte) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: imageByte != null
            ? Image.memory(
          imageByte,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildImagePlaceholder();
          },
        )
            : _buildImagePlaceholder(),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey.shade200,
            Colors.grey.shade300,
          ],
        ),
      ),
      child: Icon(
        Icons.inventory_2_outlined,
        color: Colors.grey.shade500,
        size: 32,
      ),
    );
  }

  Widget _buildProductDetails(Map product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product["displayName"] ?? "Product Name",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
            height: 1.3,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: 8),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            "Rs ${numberFormatter.format(product["salePrice"] ?? 0.0)}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),

        if (isAddedQty) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  "Added to ${widget.orderOrReturn.toLowerCase()}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.green.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildQuantityControls(Map product) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isAddedQty
              ? Theme.of(context).primaryColor
              : Colors.grey.shade300,
          width: 1.5,
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Increment Button
          _buildQuantityButton(
            icon: Icons.add,
            onTap: () async {
              setState(() {
                int currentQty = qty.text == "" ? 0 : int.parse(qty.text);
                currentQty++;
                qty.text = currentQty.toString();
                widget.productList[widget.index]["adQty"] = currentQty;
                whenAddQtyChangeColor(currentQty);
              });
              await addProductUsageTableToData(
                productId: product["id"],
                qty: int.parse(qty.text),
                liternary_Id: widget.liternary_Id,
              );
            },
          ),

          // Quantity Display
          Container(
            width: 60,
            height: 40,
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: TextFormField(
              controller: qty,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isAddedQty
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade700,
              ),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              onChanged: (value) async {
                value = value == "" ? "0" : value;
                final parsed = int.tryParse(value);
                if (parsed != null && parsed >= 0) {
                  widget.productList[widget.index]["adQty"] = parsed;
                  await addProductUsageTableToData(
                    productId: product["id"],
                    qty: parsed,
                    liternary_Id: widget.liternary_Id,
                  );
                  whenAddQtyChangeColor(parsed);
                }
              },
            ),
          ),

          // Decrement Button
          _buildQuantityButton(
            icon: Icons.remove,
            onTap: () async {
              setState(() {
                int currentQty = qty.text == "" ? 0 : int.parse(qty.text);
                if (currentQty > 0) {
                  currentQty--;
                }
                widget.productList[widget.index]["adQty"] = currentQty;
                whenAddQtyChangeColor(currentQty);
                qty.text = currentQty.toString();
              });
              await addProductUsageTableToData(
                productId: product["id"],
                qty: int.parse(qty.text),
                liternary_Id: widget.liternary_Id,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 60,
          height: 36,
          decoration: BoxDecoration(
            color: isAddedQty
                ? Theme.of(context).primaryColor.withOpacity(0.1)
                : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: isAddedQty
                ? Theme.of(context).primaryColor
                : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }

  addProductUsageTableToData({
    required productId,
    required int qty,
    required int liternary_Id,
  }) async {
    if (widget.orderOrReturn == "Order") {
      int? usageId = await dataBase.addOrUpdateOrRemoveOrderProductUsage(
        itineraryLineId: liternary_Id,
        productId: productId,
        adQty: qty,
      );
      if (usageId != null && checkUpdate) {
        await dataBase.updateFalseIsSyncedOrderProductUsage(id: usageId);
      }
    } else {
      int? usageId = await dataBase.addOrUpdateOrRemoveReturnProductUsageForInvoiceItems(
        itineraryLineId: liternary_Id,
        productId: productId,
        returnQty: qty,
      );
      if (usageId != null && checkUpdate) {
        await dataBase.updateFalseIsSyncedReturnProductUsage(id: usageId);
      }
    }
  }

  whenAddQtyChangeColor(int qty) {
    setState(() {
      if (qty > 0) {
        isAddedQty = true;
      } else {
        isAddedQty = false;
      }
    });
  }
}