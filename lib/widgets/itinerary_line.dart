import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:polycrome_sales_application/providers/order_return_payment_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../get_live_location.dart';
import '../localDb/app_database.dart';
import '../providers/handdle_data_provider.dart';
import '../reusableWidgets/showDialog.dart';
import '../screens/customer_dashboard_section.dart';
import '../screens/login_screen.dart';
import '../screens/order_taking.dart';
import '../widgets/outlet_visit_status.dart';
import '../constants/colors.dart';

class ItineraryLines extends StatefulWidget {
  const ItineraryLines({super.key});

  @override
  State<ItineraryLines> createState() => _ItineraryLinesState();
}

class _ItineraryLinesState extends State<ItineraryLines>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  String _searchQuery = '';
  String _filterStatus = 'all'; // all, visited, pending
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setupAnimations();
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

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getFilteredData(
      List<Map<String, dynamic>> data) {
    return data.where((item) {
      final matchesSearch = _searchQuery.isEmpty ||
          item['partner_name']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          item['route_name']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());

      final matchesFilter = _filterStatus == 'all' ||
          (_filterStatus == 'visited' && item['isVisited'] == true) ||
          (_filterStatus == 'pending' && item['isVisited'] != true);

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final itineraryDataHandleData =
    Provider.of<ItineraryDataHandle>(context, listen: false);
    GetLiveLocation getLiveLocation = GetLiveLocation();
    final theme = Theme.of(context);

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

                  // App Bar
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
                              'Itinerary Lines',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Manage your customer visits',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Consumer<ItineraryDataHandle>(
                          builder: (context, provider, child) {
                            final totalCount = provider.convertItineraryDbData.length;
                            final visitedCount = provider.convertItineraryDbData
                                .where((item) => item['isVisited'] == true)
                                .length;
                            return Text(
                              '$visitedCount/$totalCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search customers or routes...',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Colors.grey.shade400,
                          size: 22,
                        ),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                          icon: Icon(
                            Icons.clear_rounded,
                            color: Colors.grey.shade400,
                            size: 20,
                          ),
                        )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Filter Chips
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFilterChip('All', 'all'),
                      _buildFilterChip('Visited', 'visited'),
                      _buildFilterChip('Pending', 'pending'),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Content Section
          Expanded(
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Consumer<ItineraryDataHandle>(
                  builder: (context, provider, child) {
                    final filteredData = _getFilteredData(provider.convertItineraryDbData);

                    if (filteredData.isEmpty) {
                      return _buildEmptyState();
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        final originalIndex = provider.convertItineraryDbData
                            .indexOf(filteredData[index]);

                        return AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            final delay = index * 0.1;
                            final animationValue = Curves.easeOut.transform(
                                ((_animationController.value - delay).clamp(0.0, 1.0))
                            );

                            return Transform.translate(
                              offset: Offset(0, 50 * (1 - animationValue)),
                              child: Opacity(
                                opacity: animationValue,
                                child: _buildCustomerCard(
                                  filteredData[index],
                                  originalIndex,
                                  itineraryDataHandleData,
                                  getLiveLocation,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _filterStatus == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _filterStatus = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? kMainColor : Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 50,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'No customers found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filter',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerCard(
      Map<String, dynamic> data,
      int index,
      ItineraryDataHandle itineraryDataHandleData,
      GetLiveLocation getLiveLocation,
      ) {
    final isVisited = data['isVisited'] == true;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _handleCustomerTap(data, index, itineraryDataHandleData),
          onLongPress: () => _handleCustomerLongPress(
              data, index, itineraryDataHandleData, getLiveLocation),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isVisited ? Colors.green.withOpacity(0.3) : Colors.grey.shade200,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  children: [
                    // Customer Icon
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isVisited
                              ? [Colors.green.shade400, Colors.green.shade600]
                              : [Colors.orange.shade400, Colors.orange.shade600],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        isVisited ? Icons.check_circle_outline : Icons.schedule_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Customer Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['partner_name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1E1E1E),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.route_rounded,
                                size: 16,
                                color: Colors.grey.shade500,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  data['route_name'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Status Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isVisited ? Colors.green.shade50 : Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isVisited ? Colors.green.shade200 : Colors.orange.shade200,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        isVisited ? 'Visited' : 'Pending',
                        style: TextStyle(
                          color: isVisited ? Colors.green.shade700 : Colors.orange.shade700,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Outstanding Amount (if available)
                if (data['customer_invoice_outstanding_amount'] != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet_outlined,
                          size: 18,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Outstanding: ',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Rs ${data['customer_invoice_outstanding_amount']}',
                          style: TextStyle(
                            fontSize: 13,
                            color: kMainColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                ],

                // Action Hint
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: kMainColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.touch_app_rounded,
                        size: 16,
                        color: kMainColor.withOpacity(0.7),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Tap to visit • Long press to mark as visited',
                          style: TextStyle(
                            fontSize: 12,
                            color: kMainColor.withOpacity(0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleCustomerTap(
      Map<String, dynamic> data,
      int index,
      ItineraryDataHandle itineraryDataHandleData,
      ) async {
    Provider.of<OrderReturnPaymentProvider>(context, listen: false)
        .setPartnerId(data['partner_id']);

    int itineraryId = data['itinerary_line_id'];

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomerDashboard(
          index: index,
          itineraryId: itineraryId,
        ),
      ),
    );

    await itineraryDataHandleData.fetchDbItineraryDate();
    setState(() {});
  }

  Future<void> _handleCustomerLongPress(
      Map<String, dynamic> data,
      int index,
      ItineraryDataHandle itineraryDataHandleData,
      GetLiveLocation getLiveLocation,
      ) async {
    if (data['isVisited'] == true) {
      return;
    }

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
    int itineraryId = data['itinerary_line_id'];

    if (position == null) {
      Navigator.pop(context);
      await showConfirmationDialog(
        context,
        "Your device's GPS (Location Services) is turned off.\n\nPlease enable it in settings to continue.",
        actionType: 'Ok',
      );
      return;
    } else {
      await AppDatabase.instance.updateLocationSalesPersonData(
        itinerary_line_id: itineraryId,
        itinerary_latitude: position.latitude,
        itinerary_longitude: position.longitude,
      );
    }

    Navigator.pop(context);

    final shouldPop = await showExitConfirmationDialog(
      context,
      itineraryDataHandleData.outletVisitStatusList,
      data['partner_name'],
      itineraryId,
    );

    if (shouldPop) {
      await AppDatabase.instance.updateIsVisitedSalesPersonData(
        itinerary_line_id: itineraryId,
        isVisited: true,
      );
      itineraryDataHandleData.fetchDbItineraryDate();
      setState(() {});
    }
  }
}