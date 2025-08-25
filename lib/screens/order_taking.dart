import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../get_live_location.dart';
import '../localDb/app_database.dart';
import '../providers/connection_handle.provider.dart';
import '../providers/handdle_data_provider.dart';
import '../providers/order_return_payment_provider.dart';
import '../providers/save_data_provider.dart';
import '../reusableWidgets/showDialog.dart';
import '../reusableWidgets/sync_featching_dialog_btn.dart';
import '../widgets/order_taking_tab_bar.dart';
import '../widgets/outlet_visit_status.dart';
import '../constants/colors.dart';

class OrderTaking extends StatefulWidget {
  final List convertLocalDbData;
  final int index;
  final int itineraryId;

  const OrderTaking({
    super.key,
    required this.convertLocalDbData,
    required this.index,
    required this.itineraryId,
  });

  @override
  State<OrderTaking> createState() => _OrderTakingState();
}

class _OrderTakingState extends State<OrderTaking>
    with TickerProviderStateMixin {
  final AppDatabase dataBase = AppDatabase.instance;
  final numberFormatter = NumberFormat('#,##0.00');

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  List<Map<String, dynamic>> outletVisitStatusList = [];
  bool isDatePeriodOkay = false;
  bool isOrderValid = false;
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkCreditLimit();
    });
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
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
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
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
    final saveDataProvider = Provider.of<SaveDataProvider>(context, listen: false);
    final connectionCheckProvider = Provider.of<ConnectionHandle>(context, listen: false);
    final orderReturnPaymentProvider = Provider.of<OrderReturnPaymentProvider>(context, listen: true);
    final itineraryDataHandleData = Provider.of<ItineraryDataHandle>(context, listen: false);
    GetLiveLocation getLiveLocation = GetLiveLocation();
    final theme = Theme.of(context);

    final customerData = widget.convertLocalDbData[widget.index];

    return WillPopScope(
      onWillPop: () => _handleBackPress(
        getLiveLocation,
        itineraryDataHandleData,
        orderReturnPaymentProvider,
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: Column(
          children: [
            // Compact Header Section
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 40, 16, 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      kMainColor,
                      kMainColor.withOpacity(0.85),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: kMainColor.withOpacity(0.25),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Compact App Bar
                    Row(
                      children: [
                        IconButton(
                          onPressed: isProcessing ? null : () => _handleBackPress(
                            getLiveLocation,
                            itineraryDataHandleData,
                            orderReturnPaymentProvider,
                          ),
                          icon: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(8),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                customerData["partner_name"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Order Management',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.green.shade400, Colors.green.shade600],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.25),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
                            onPressed: isProcessing ? null : () => _handleConfirm(
                              connectionCheckProvider,
                              saveDataProvider,
                              orderReturnPaymentProvider,
                              itineraryDataHandleData,
                              getLiveLocation,
                            ),
                            icon: isProcessing
                                ? SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                                : const Icon(Icons.check_rounded, size: 16),
                            label: Text(
                              isProcessing ? 'Processing...' : 'Confirm',
                              style: const TextStyle(
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
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Compact Customer Info
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Info Section
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                _buildCompactInfoRow(
                                  'Date',
                                  customerData["date"] ?? '',
                                  Icons.today_outlined,
                                ),
                                const SizedBox(height: 6),
                                _buildCompactInfoRow(
                                  'Route',
                                  customerData["route_name"] ?? '',
                                  Icons.route_outlined,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 16),

                          // Outstanding Amount
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.account_balance_wallet_outlined,
                                        color: Colors.white.withOpacity(0.9),
                                        size: 16,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Outstanding',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Rs ${numberFormatter.format(customerData["customer_invoice_outstanding_amount"] ?? 0)}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Credit Warning (if exists)
                    Consumer<OrderReturnPaymentProvider>(
                      builder: (context, provider, child) {
                        if (provider.outStandingState.isNotEmpty) {
                          return Container(
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.orange.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.warning_amber_rounded,
                                  color: Colors.orange.shade200,
                                  size: 14,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    provider.outStandingState,
                                    style: TextStyle(
                                      color: Colors.orange.shade100,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Expanded Tab Bar Section
            Expanded(
              child: SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 15,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: OrderTakingTabBar(
                        liternary_Id: widget.itineraryId,
                        partner_id: customerData["partner_id"],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(width: 6),
        Text(
          '$label: ',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Future<bool> _handleBackPress(
      GetLiveLocation getLiveLocation,
      ItineraryDataHandle itineraryDataHandleData,
      OrderReturnPaymentProvider orderReturnPaymentProvider,
      ) async {
    if (isProcessing) return false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: LoadingAnimationWidget.progressiveDots(
          color: kMainColor,
          size: 40,
        ),
      ),
    );

    final position = await getLiveLocation.getCurrentLocation();
    if (position == null) {
      Navigator.pop(context);
      await showConfirmationDialog(
        context,
        "Your device's GPS (Location Services) is turned off.\n\nPlease enable it in settings to continue.",
        actionType: 'Ok',
      );
      return false;
    } else {
      await AppDatabase.instance.updateLocationSalesPersonData(
        itinerary_line_id: widget.itineraryId,
        itinerary_latitude: position.latitude,
        itinerary_longitude: position.longitude,
      );
    }

    Navigator.pop(context);

    final shouldPop = await showExitConfirmationDialog(
      context,
      itineraryDataHandleData.outletVisitStatusList,
      widget.convertLocalDbData[widget.index]["partner_name"],
      widget.itineraryId,
    );

    if (shouldPop) {
      orderReturnPaymentProvider.setIsDiscountState(false);
      await AppDatabase.instance.updateIsVisitedSalesPersonData(
        itinerary_line_id: widget.itineraryId,
        isVisited: true,
      );
    }

    return shouldPop;
  }

  Future<void> _handleConfirm(
      ConnectionHandle connectionCheckProvider,
      SaveDataProvider saveDataProvider,
      OrderReturnPaymentProvider orderReturnPaymentProvider,
      ItineraryDataHandle itineraryDataHandleData,
      GetLiveLocation getLiveLocation,
      ) async {
    setState(() => isProcessing = true);

    try {
      final checkReturnTypeActionOk = await checkReturnTypeAndReturnAction(orderReturnPaymentProvider);
      if (!checkReturnTypeActionOk) {
        await showConfirmationDialog(
          context,
          "Please make sure the return type and return action are selected for all return lines before proceeding",
          actionType: 'Ok',
        );
        return;
      }

      await AppDatabase.instance.updateIsVisitedSalesPersonData(
        itinerary_line_id: widget.itineraryId,
        isVisited: true,
      );

      final bool isConnectedInternet = await connectionCheckProvider.checkConnection();
      final position = await getLiveLocation.getCurrentLocation();

      if (position == null) {
        await showConfirmationDialog(
          context,
          "Your device's GPS (Location Services) is turned off.\n\nPlease enable it in settings to continue.",
          actionType: 'Ok',
        );
        return;
      } else {
        await AppDatabase.instance.updateLocationSalesPersonData(
          itinerary_line_id: widget.itineraryId,
          itinerary_latitude: position.latitude,
          itinerary_longitude: position.longitude,
        );
      }

      if (isConnectedInternet) {
        await _startSync(context, saveDataProvider);
        final shouldPop = await showExitConfirmationDialog(
          context,
          itineraryDataHandleData.outletVisitStatusList,
          widget.convertLocalDbData[widget.index]["partner_name"],
          widget.itineraryId,
        );

        if (shouldPop) {
          orderReturnPaymentProvider.setIsDiscountState(false);
          Navigator.pop(context);
        }
      } else {
        await showConfirmationDialog(
          context,
          "Please note that there is no available connection.\nBe sure that when internet is available, sync will resume.",
          actionType: 'Ok',
        );

        final shouldPop = await showExitConfirmationDialog(
          context,
          itineraryDataHandleData.outletVisitStatusList,
          widget.convertLocalDbData[widget.index]["partner_name"],
          widget.itineraryId,
        );

        if (shouldPop) {
          orderReturnPaymentProvider.setIsDiscountState(false);
          Navigator.pop(context);
        }
      }
    } finally {
      if (mounted) {
        setState(() => isProcessing = false);
      }
    }
  }

  Future<void> _startSync(BuildContext context, SaveDataProvider saveDataProvider) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const SyncDialog(
        message: "Synchronizing data...",
        syncType: 'sync',
      ),
    );

    final bool syncComplete = await saveDataProvider.checkConnectionAndSaveData(context, false);

    if (context.mounted) {
      Navigator.of(context).pop();
    }

    if (syncComplete && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text(
                'Successfully synced to the server.',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  bool checkReturnTypeAndReturnAction(OrderReturnPaymentProvider orderReturnPaymentProvider) {
    for (dynamic item in orderReturnPaymentProvider.showReturnProductValidData) {
      if (item["return_reason_id"] == 0 || item["return_action_id"] == 0) {
        return false;
      }
    }
    return true;
  }

  void checkCreditLimit() async {
    final showPaymentInvoicesDropData = Provider.of<OrderReturnPaymentProvider>(context, listen: false);
    final List<Map<String, dynamic>> invoiceList = showPaymentInvoicesDropData.showPaymentInvoicesDropData;

    if (invoiceList.isEmpty) {
      return;
    }

    Map<String, dynamic> oldestInvoice = invoiceList.first;
    DateTime oldestDate = DateTime.parse(oldestInvoice["invoice_date"]);

    for (var invoice in invoiceList) {
      DateTime dueDate = DateTime.parse(invoice["invoice_date"]);
      if (dueDate.isBefore(oldestDate)) {
        oldestDate = dueDate;
        oldestInvoice = invoice;
      }
    }

    String formattedDate = oldestDate.toIso8601String().split("T").first;
    isDatePeriodOkay = isTodayWithin60DaysFrom(formattedDate);

    if (!isDatePeriodOkay) {
      showPaymentInvoicesDropData.setOutStandingState("Not in the Period");
    } else if (widget.convertLocalDbData[widget.index]["use_partner_credit_limit"] <
        widget.convertLocalDbData[widget.index]["credit"]) {
      showPaymentInvoicesDropData.setOutStandingState(
          "Credit limit of LKR ${widget.convertLocalDbData[widget.index]["use_partner_credit_limit"]} has been exceeded");
    } else {
      showPaymentInvoicesDropData.setOutStandingState("");
    }

    if (mounted) {
      setState(() {});
    }
  }

  bool isTodayWithin60DaysFrom(String selectedDateStr) {
    DateTime selectedDate = DateTime.parse(selectedDateStr);
    DateTime today = DateTime.now();
    DateTime endDate = selectedDate.add(const Duration(days: 60));

    return today.isAfter(selectedDate.subtract(const Duration(days: 1))) &&
        today.isBefore(endDate.add(const Duration(days: 1)));
  }
}