import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:polycrome_sales_application/localDb/app_database.dart';
import 'package:provider/provider.dart';

import '../providers/order_return_payment_provider.dart';

class AchievementCard extends StatefulWidget {
  List<Map<String, dynamic>> list = [];

  AchievementCard({
    super.key,
    required this.list
  });

  @override
  State<AchievementCard> createState() => _AchievementCardState();
}

class _AchievementCardState extends State<AchievementCard>
    with SingleTickerProviderStateMixin {
  final numberFormatter = NumberFormat('#,##0.00');
  List<Map<String, dynamic>> refreshList = [];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut)
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

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
    final showOrderReturnProductValidData = Provider.of<OrderReturnPaymentProvider>(context);

    return showOrderReturnProductValidData.isDiscountPress
        ? SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colorScheme.primary.withOpacity(0.1),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            children: [
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
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
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
                        Icons.emoji_events_outlined,
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
                            "Current Achievements",
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: theme.colorScheme.onSurface,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Track your progress and targets",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.6),
                              letterSpacing: 0.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Achievement List
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: widget.list.isEmpty
                    ? _buildEmptyState(theme)
                    : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.list.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 24,
                    color: Colors.grey.shade200,
                  ),
                  itemBuilder: (context, index) => _buildCategoryRow(index, theme),
                ),
              ),
            ],
          ),
        ),
      ),
    )
        : const SizedBox();
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.insights_outlined,
            size: 48,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            "No achievements to show",
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Complete orders to see your progress",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(int index, ThemeData theme) {
    if (index >= widget.list.length) {
      return const SizedBox.shrink();
    }

    final item = widget.list[index];
    return FutureBuilder(
      future: AppDatabase.instance.getAllDiscountDataFilteredDiscountId(item["discountId"]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                ),
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFE57373).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFE57373).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: const Color(0xFFE57373),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Error loading data',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFFE57373),
                  ),
                ),
              ],
            ),
          );
        }

        final discountList = snapshot.data ?? [];
        if (discountList.isEmpty) {
          return const SizedBox.shrink();
        }

        final discount = discountList.first;
        final double difference = discount.minimum_amount - item["total"];
        final bool isAchieved = (item["total"] > discount.minimum_amount &&
            item["total"] < discount.maximum_amount) ||
            difference < 0.0;
        final double progressPercentage = (item["total"] / discount.minimum_amount).clamp(0.0, 1.0);

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                isAchieved
                    ? Colors.green.withOpacity(0.05)
                    : Colors.orange.withOpacity(0.05),
                Colors.transparent,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isAchieved
                  ? Colors.green.withOpacity(0.2)
                  : Colors.orange.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "wewewe",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isAchieved ? Colors.green : Colors.orange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      isAchieved ? "ACHIEVED" : "IN PROGRESS",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Progress Bar
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progressPercentage,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isAchieved
                            ? [Colors.green, Colors.green.shade600]
                            : [Colors.orange, Colors.orange.shade600],
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Target Range
              Row(
                children: [
                  Expanded(
                    child: _buildAmountChip(
                      "Min: ${numberFormatter.format(discount.minimum_amount)}",
                      isAchieved ? Colors.green : Colors.grey,
                      theme,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildAmountChip(
                      "Max: ${numberFormatter.format(discount.maximum_amount)}",
                      isAchieved ? Colors.green : Colors.grey,
                      theme,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Current Total
              _buildInfoRow(
                "Total Amount",
                numberFormatter.format(item["total"]),
                Colors.green,
                theme,
              ),

              const SizedBox(height: 8),

              // Discount Amount
              _buildInfoRow(
                "Discount Amount",
                numberFormatter.format(item["total"] * discount.discount_percentage / 100),
                Colors.deepPurple,
                theme,
              ),

              const SizedBox(height: 8),

              // Target to Achieve
              Row(
                children: [
                  Expanded(
                    child: _buildInfoRow(
                      "Target to Achieve",
                      difference < 0.0 ? "0.0" : numberFormatter.format(difference),
                      Colors.deepPurple,
                      theme,
                    ),
                  ),
                  if (isAchieved)
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAmountChip(String text, Color color, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: theme.textTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, Color color, ThemeData theme) {
    return Row(
      children: [
        Text(
          "$label: ",
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  fetchRefreshList() {
    final orderReturnPaymentProvider = Provider.of<OrderReturnPaymentProvider>(context);
    refreshList = orderReturnPaymentProvider.discountDataList;
    setState(() {});
  }
}