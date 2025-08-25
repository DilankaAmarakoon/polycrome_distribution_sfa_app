import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order_return_payment_provider.dart';
import '../screens/orders_return_tab_bar.dart';
import '../screens/payment_tab_bar.dart';
import '../constants/colors.dart';

class OrderTakingTabBar extends StatefulWidget {
  final int liternary_Id;
  final int partner_id;

  const OrderTakingTabBar({
    super.key,
    required this.liternary_Id,
    required this.partner_id,
  });

  @override
  State<OrderTakingTabBar> createState() => _OrderTakingTabBarState();
}

class _OrderTakingTabBarState extends State<OrderTakingTabBar>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _setupAnimations();
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

    _animationController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
          // Compact Tab Bar
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: kMainColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: kMainColor.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: const EdgeInsets.all(2),
              dividerColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey.shade600,
              labelStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              tabs: [
                _buildCompactTab(
                  icon: Icons.payment_rounded,
                  label: "Payment",
                  isSelected: _tabController.index == 0,
                ),
                _buildCompactTab(
                  icon: Icons.keyboard_return_rounded,
                  label: "Return",
                  isSelected: _tabController.index == 1,
                ),
                _buildCompactTab(
                  icon: Icons.shopping_cart_rounded,
                  label: "Order",
                  isSelected: _tabController.index == 2,
                ),
              ],
              onTap: (index) {
                setState(() {});
              },
            ),
          ),

          // Maximized Content Area
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildTabContent(
                    child: PaymentTabBarDetails(
                      liternary_Id: widget.liternary_Id,
                      partner_id: widget.partner_id,
                    ),
                  ),
                  _buildTabContent(
                    child: OrdersReturnTabBarDetails(
                      orderOrReturn: "Return",
                      liternary_Id: widget.liternary_Id,
                    ),
                  ),
                  _buildTabContent(
                    child: OrdersReturnTabBarDetails(
                      orderOrReturn: "Order",
                      liternary_Id: widget.liternary_Id,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactTab({
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return Container(
      height: 42,
      child: Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : Colors.grey.shade600,
            ),
            const SizedBox(width: 6),
            Text(label),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent({required Widget child}) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: child,
    );
  }
}

// Enhanced compact tab bar for maximum space utilization
class CompactTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;
  final List<Tab> tabs;
  final Color? indicatorColor;
  final Color? labelColor;
  final Color? unselectedLabelColor;

  const CompactTabBar({
    super.key,
    required this.tabController,
    required this.tabs,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
          color: indicatorColor ?? kMainColor,
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.all(2),
        dividerColor: Colors.transparent,
        labelColor: labelColor ?? Colors.white,
        unselectedLabelColor: unselectedLabelColor ?? Colors.grey.shade600,
        labelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        tabs: tabs,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(45);
}