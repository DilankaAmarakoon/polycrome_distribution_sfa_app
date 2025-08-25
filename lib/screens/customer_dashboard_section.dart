import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../localDb/app_database.dart';
import '../providers/handdle_data_provider.dart';
import '../providers/order_return_payment_provider.dart';
import 'customer_outlet_history_table.dart';
import 'order_taking.dart';
import '../constants/colors.dart';

class CustomerDashboard extends StatefulWidget {
  final int index;
  final int itineraryId;

  const CustomerDashboard({
    super.key,
    required this.index,
    required this.itineraryId
  });

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard>
    with TickerProviderStateMixin {
  final localDb = AppDatabase.instance;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final numberFormatter = NumberFormat('#,##0.00');
  bool isLoading = true;
  Map<String, dynamic> customerData = {};

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeData();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
    ));

    _animationController.forward();
  }

  Future<void> _initializeData() async {
    await fetchCreditLimit();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderReturnPaymentProvider = Provider.of<OrderReturnPaymentProvider>(context, listen: false);
    final itineraryDataHandleData = Provider.of<ItineraryDataHandle>(context, listen: false);
    final theme = Theme.of(context);

    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final customerInfo = itineraryDataHandleData.convertItineraryDbData[widget.index];
    final isVisited = customerInfo["isVisited"] == true;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          // Header Section
          FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    kMainColor,
                    kMainColor.withOpacity(0.8),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: kMainColor.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Customer Dashboard',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              customerInfo["partner_name"],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if (isVisited)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.green.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green.shade300,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Visited',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Customer Info Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Icon(
                                Icons.business_outlined,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Customer Information',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    customerInfo["route_name"] ?? 'No route assigned',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Outstanding Amount
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.account_balance_wallet_outlined,
                                color: Colors.white.withOpacity(0.9),
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Outstanding: ',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Rs ${numberFormatter.format(customerInfo["customer_invoice_outstanding_amount"] ?? 0)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Actions Section
          Expanded(
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Available Actions',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: kCartColor,
                        ),
                      ),
                      // Action Cards
                      Row(
                        children: [
                          Expanded(
                            child: _buildActionCard(
                              title: 'History',
                              subtitle: 'View customer history',
                              icon: Icons.history_rounded,
                              color: Colors.blue.shade400,
                              onTap: () => _navigateToHistory(customerInfo),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildActionCard(
                              title: 'Pre Order',
                              subtitle: 'Create new order',
                              icon: Icons.shopping_cart_outlined,
                              color: Colors.green.shade400,
                              isDisabled: isVisited,
                              onTap: () => _navigateToOrderTaking(
                                orderReturnPaymentProvider,
                                itineraryDataHandleData,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Additional Info Section
                      if (customerInfo["credit"] != null || customerInfo["use_partner_credit_limit"] != null)
                        _buildInfoSection(customerInfo),

                      const Spacer(),

                      // Footer Message
                      if (isVisited)
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.green.shade200,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: Colors.green.shade600,
                                size: 24,
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Customer Visited',
                                      style: TextStyle(
                                        color: Colors.green.shade700,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      'This customer has been marked as visited. Order creation is disabled.',
                                      style: TextStyle(
                                        color: Colors.green.shade600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool isDisabled = false,
  }) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: isDisabled
              ? Border.all(color: Colors.grey.shade200)
              : null,
          boxShadow: isDisabled ? null : [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: isDisabled
                    ? Colors.grey.shade100
                    : color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDisabled
                      ? Colors.grey.shade200
                      : color.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Icon(
                icon,
                color: isDisabled ? Colors.grey.shade400 : color,
                size: 32,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDisabled ? Colors.grey.shade400 : kCartColor,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 6),

            Text(
              subtitle,
              style: TextStyle(
                fontSize: 13,
                color: isDisabled ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),

            if (isDisabled) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Disabled',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(Map<String, dynamic> customerInfo) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: kMainColor,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Credit Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: kCartColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          if (customerInfo["credit"] != null)
            _buildInfoRow(
              'Current Credit',
              'Rs ${numberFormatter.format(customerInfo["credit"])}',
              Icons.account_balance_wallet_outlined,
            ),

          if (customerInfo["use_partner_credit_limit"] != null)
            _buildInfoRow(
              'Credit Limit',
              'Rs ${numberFormatter.format(customerInfo["use_partner_credit_limit"])}',
              Icons.credit_card_outlined,
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: kMainColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToHistory(Map<String, dynamic> customerInfo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomerOutletHistoryTable(
          partnerName: customerInfo["partner_name"],
          partnerId: customerInfo["partner_id"],
        ),
      ),
    );
  }

  Future<void> _navigateToOrderTaking(
      OrderReturnPaymentProvider orderReturnPaymentProvider,
      ItineraryDataHandle itineraryDataHandleData,
      ) async {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await orderReturnPaymentProvider.insertPaymentUsageData(widget.itineraryId);
      int partnerId = itineraryDataHandleData.convertItineraryDbData[widget.index]["partner_id"];
      await orderReturnPaymentProvider.fetchPaymentInvoicesDropData(partnerId);
      await orderReturnPaymentProvider.fetchReturnTypeAndActionDropData();

      // Close loading dialog
      Navigator.pop(context);

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderTaking(
            convertLocalDbData: itineraryDataHandleData.convertItineraryDbData,
            index: widget.index,
            itineraryId: widget.itineraryId,
          ),
        ),
      );

      await itineraryDataHandleData.fetchDbItineraryDate();
      setState(() {});
    } catch (e) {
      // Close loading dialog
      Navigator.pop(context);

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load order data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> fetchCreditLimit() async {
    int partnerId = Provider.of<ItineraryDataHandle>(context, listen: false)
        .convertItineraryDbData[widget.index]["partner_id"];

    final creditData = await AppDatabase.instance
        .getAllResPartnerDataLinesFilteredPartnerId(partnerId);

    if (creditData.isNotEmpty) {
      final partner = creditData.first;

      Provider.of<ItineraryDataHandle>(context, listen: false)
          .convertItineraryDbData[widget.index]["use_partner_credit_limit"] =
          partner.use_partner_credit_limit;
      Provider.of<ItineraryDataHandle>(context, listen: false)
          .convertItineraryDbData[widget.index]["credit"] =
          partner.credit;
    } else {
      debugPrint("No partner data found for partner ID $partnerId");
    }
  }
}