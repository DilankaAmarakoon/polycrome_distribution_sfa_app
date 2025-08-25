import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/order_return_payment_provider.dart';
import '../widgets/payment_dragable_sheet.dart';
import '../reusableWidgets/payment_cart.dart';
import '../constants/colors.dart';

class PaymentTabBarDetails extends StatefulWidget {
  final int liternary_Id;
  final int partner_id;

  const PaymentTabBarDetails({
    super.key,
    required this.liternary_Id,
    required this.partner_id,
  });

  @override
  State<PaymentTabBarDetails> createState() => _PaymentTabBarDetailsState();
}

class _PaymentTabBarDetailsState extends State<PaymentTabBarDetails>
    with TickerProviderStateMixin {
  final numberFormatter = NumberFormat('#,##0.00');
  double totalAmount = 0.0;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    Provider.of<OrderReturnPaymentProvider>(context, listen: false)
        .fetchPaymentValidData(widget.liternary_Id);
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paymentDragblesheet = PaymentDraggableSheet();
    final showPaymentValidData = Provider.of<OrderReturnPaymentProvider>(context);
    calOrderReturnTotalAmount(showPaymentValidData);
    final theme = Theme.of(context);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
          // Compact Header Section
          SlideTransition(
            position: _slideAnimation,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  // Compact Add Payment Button
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [kMainColor, kMainColor.withOpacity(0.85)],
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: kMainColor.withOpacity(0.25),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          var paymentLineId = showPaymentValidData.showPaymentValidData.isEmpty
                              ? 0
                              : showPaymentValidData.showPaymentValidData[0]["payment_line_id"];

                          paymentDragblesheet.openDraggableSheet(
                            paymentLineId: paymentLineId,
                            partnerId: widget.partner_id,
                            "newPayment",
                            context,
                            widget.liternary_Id,
                            {},
                                () {
                              Provider.of<OrderReturnPaymentProvider>(context, listen: false)
                                  .fetchPaymentValidData(widget.liternary_Id);
                            },
                          );
                        },
                        icon: const Icon(Icons.add_rounded, size: 16),
                        label: const Text(
                          "Add Payment",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Payment List Section (Maximum space)
          Expanded(
            child: showPaymentValidData.showPaymentValidData.isEmpty
                ? _buildCompactEmptyState()
                : Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: showPaymentValidData.showPaymentValidData.length,
                itemBuilder: (context, index) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0.5, 0),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: _animationController,
                      curve: Interval(
                        (index * 0.05).clamp(0.0, 1.0),
                        ((index * 0.05) + 0.2).clamp(0.0, 1.0),
                        curve: Curves.easeOut,
                      ),
                    )),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: PaymentCart(
                        paymentValidData: showPaymentValidData.showPaymentValidData,
                        index: index,
                        liternary_Id: widget.liternary_Id,
                        onTap: () {
                          paymentDragblesheet.openDraggableSheet(
                            paymentLineId: showPaymentValidData.showPaymentValidData[index]["payment_line_id"],
                            partnerId: widget.partner_id,
                            "updatePayment",
                            context,
                            widget.liternary_Id,
                            showPaymentValidData.showPaymentValidData[index],
                                () {
                              Provider.of<OrderReturnPaymentProvider>(context, listen: false)
                                  .fetchPaymentValidData(widget.liternary_Id);
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Compact Total Amount Footer
          Container(
            margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  kMainColor,
                  kMainColor.withOpacity(0.85),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: kMainColor.withOpacity(0.25),
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
                    Icons.account_balance_wallet_rounded,
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
                        'Total Payment Amount',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Rs ${numberFormatter.format(totalAmount)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                if (showPaymentValidData.showPaymentValidData.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Payment',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(35),
            ),
            child: Icon(
              Icons.payment_outlined,
              size: 35,
              color: Colors.grey.shade400,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            'No Payments Added',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Tap "Add Payment" to get started',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: kMainColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: kMainColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 14,
                  color: kMainColor,
                ),
                const SizedBox(width: 6),
                Text(
                  'Add customer payments here',
                  style: TextStyle(
                    fontSize: 11,
                    color: kMainColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void calOrderReturnTotalAmount(OrderReturnPaymentProvider showProviderData) {
    totalAmount = 0.0;
    List list = showProviderData.showPaymentValidData;
    for (dynamic item in list) {
      totalAmount = totalAmount + (item["amount"] ?? 0);
    }
  }
}