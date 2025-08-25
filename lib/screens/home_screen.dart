import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../get_live_location.dart';
import '../localDb/app_database.dart';
import '../providers/handdle_data_provider.dart';
import '../providers/connection_handle.provider.dart';
import '../providers/save_data_provider.dart';
import '../reusableWidgets/showDialog.dart';
import '../reusableWidgets/sync_featching_dialog_btn.dart';
import '../screens/login_screen.dart';
import '../widgets/check_in_out.dragable_sheet.dart';
import '../widgets/itinerary_line.dart';
import '../constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<dynamic> resPartnerData = [];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  String? userName;
  String? userCompany;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadCheckInStatus();
    _loadUserInfo();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
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

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString("userName");
      userCompany = "Polycrome Distribution";
    });
  }

  Future<void> _loadCheckInStatus() async {
    final handle = Provider.of<ItineraryDataHandle>(context, listen: false);
    final pref = await SharedPreferences.getInstance();
    final isChecked = pref.getBool('isCheckedIn');
    if (isChecked != null) {
      handle.setIsisVisibleCheckIn(isChecked);
    }
  }

  @override
  void dispose() {
    _animationController.stop();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itineraryData = Provider.of<ItineraryDataHandle>(context);
    final connectionCheck = Provider.of<ConnectionHandle>(context, listen: false);
    final saveData = Provider.of<SaveDataProvider>(context, listen: false);
    GetLiveLocation getLiveLocation = GetLiveLocation();
    final sheet = CheckInOutDraggableSheet();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          // Header Section
          FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              padding: const EdgeInsets.all(24),
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
                  // App Bar Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome!',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            userName ?? 'Sales Person',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.person_outline,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Status Card
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
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: itineraryData.isVisibleCheckIn
                                ? Colors.green.withOpacity(0.2)
                                : Colors.orange.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            itineraryData.isVisibleCheckIn
                                ? Icons.check_circle_outline
                                : Icons.schedule_outlined,
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
                                itineraryData.isVisibleCheckIn
                                    ? 'Checked In'
                                    : 'Not Checked In',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                itineraryData.isVisibleCheckIn
                                    ? 'You are ready to visit customers'
                                    : 'Please check in to start your day',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14,
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

          // Main Actions Section
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
                        'Quick Actions',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: kCartColor,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Primary Actions Row
                      Row(
                        children: [
                          Expanded(
                            child: _buildActionCard(
                              title: itineraryData.isVisibleCheckIn ? 'Check Out' : 'Check In',
                              subtitle: itineraryData.isVisibleCheckIn
                                  ? 'End your workday'
                                  : 'Start your workday',
                              icon: itineraryData.isVisibleCheckIn
                                  ? Icons.logout_rounded
                                  : Icons.login_rounded,
                              color: itineraryData.isVisibleCheckIn
                                  ? Colors.red.shade400
                                  : Colors.green.shade400,
                              onTap: () => _handleCheckInOut(
                                  itineraryData,
                                  connectionCheck,
                                  saveData,
                                  getLiveLocation,
                                  sheet
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildActionCard(
                              title: 'Update & Sync',
                              subtitle: 'Sync with server',
                              icon: Icons.sync_rounded,
                              color: Colors.blue.shade400,
                              isDisabled: !itineraryData.isVisibleCheckIn,
                              onTap: () => _handleSync(connectionCheck, saveData, getLiveLocation),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Secondary Actions Row
                      Row(
                        children: [
                          Expanded(
                            child: _buildActionCard(
                              title: 'Visit Details',
                              subtitle: 'View itinerary',
                              icon: Icons.assignment_outlined,
                              color: Colors.purple.shade400,
                              isDisabled: !itineraryData.isVisibleCheckIn,
                              onTap: () => _handleVisitDetails(itineraryData),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildActionCard(
                              title: 'Log Out',
                              subtitle: 'Sign out',
                              icon: Icons.power_settings_new_rounded,
                              color: Colors.grey.shade400,
                              onTap: () => _handleLogout(itineraryData),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Quick Stats Section
                      Container(
                        padding: const EdgeInsets.all(24),
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
                                  Icons.analytics_outlined,
                                  color: kMainColor,
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Today\'s Overview',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: kCartColor,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildStatItem(
                                    title: 'Status',
                                    value: itineraryData.isVisibleCheckIn ? 'Active' : 'Inactive',
                                    icon: Icons.circle,
                                    iconColor: itineraryData.isVisibleCheckIn
                                        ? Colors.green
                                        : Colors.orange,
                                  ),
                                ),
                                Expanded(
                                  child: _buildStatItem(
                                    title: 'Company',
                                    value: userCompany ?? 'Loading...',
                                    icon: Icons.business_outlined,
                                    iconColor: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // Footer
                      Center(
                        child: Text(
                          '© 2025 Polycrome Sales Force Automation  Application',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade500,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
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
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isDisabled ? Colors.grey.shade200 : color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDisabled ? Colors.grey.shade300 : color.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Icon(
                icon,
                color: isDisabled ? Colors.grey.shade400 : color,
                size: 30,
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

            const SizedBox(height: 4),

            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: isDisabled ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 16),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: kCartColor,
          ),
        ),
      ],
    );
  }

  // Action Handlers
  Future<void> _handleCheckInOut(
      ItineraryDataHandle itineraryData,
      ConnectionHandle connectionCheck,
      SaveDataProvider saveData,
      GetLiveLocation getLiveLocation,
      CheckInOutDraggableSheet sheet,
      ) async {
    if (itineraryData.isVisibleCheckIn) {
      final isAllVisited = await checkIsVisitedDoneForAllLines(itineraryData);
      if (!isAllVisited) {
        await showConfirmationDialog(
          context,
          "Before proceeding with checkout, please update the visit status in the itinerary line from *Pending* to *Visited*.",
          actionType: 'Ok',
        );
        return;
      }
    }

    final bool hasConnection = await getResPartnerDetails(itineraryData, connectionCheck);
    if (!hasConnection) return;

    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("isCheckedIn", pref.getBool('isCheckedIn') ?? false);

    final dynamic result = await sheet.openDraggableSheet(context, resPartnerData[0]);

    if (result == 'checkIn') {
      await _downloadData(true, getLiveLocation);
    } else if (result == true) {
      final bool isConnected = await connectionCheck.checkConnection();
      if (isConnected) {
        await _startSync(saveData, true, getLiveLocation);
        itineraryData.setIsisVisibleCheckIn(false);
        pref.setBool('isCheckedIn', false);
      } else {
        await showConfirmationDialog(
          context,
          "Please note that there is no available connection.\nBe sure that when internet is available, CheckOut will resume.",
          actionType: 'Ok',
        );
      }
    }
  }

  Future<void> _handleSync(
      ConnectionHandle connectionCheck,
      SaveDataProvider saveData,
      GetLiveLocation getLiveLocation,
      ) async {
    final isConnected = await connectionCheck.checkConnection();
    if (isConnected) {
      await _startSync(saveData, false, getLiveLocation);
      await _downloadData(false, getLiveLocation);
    } else {
      await showConfirmationDialog(
        context,
        "Please note that there is no available connection.\nBe sure that when internet is available, CheckOut will resume.",
        actionType: 'Ok',
      );
    }
  }

  Future<void> _handleVisitDetails(ItineraryDataHandle itineraryData) async {
    await itineraryData.fetchDbItineraryDate();
    await itineraryData.fetchVisitStatusData();
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ItineraryLines()),
    );
  }

  Future<void> _handleLogout(ItineraryDataHandle itineraryData) async {
    // if (itineraryData.isVisibleCheckIn) {
    //   await showConfirmationDialog(
    //     context,
    //     "Before logging out, please make sure you have completed the checkout process.",
    //     actionType: 'Ok',
    //   );
    //   return;
    // }

    final confirmed = await showConfirmationDialog(
      context,
      "Are you sure you want to log out?",
      actionType: 'log out',
    );

    if (confirmed!) {
      final pref = await SharedPreferences.getInstance();
      await pref.clear();
      itineraryData.setIsisVisibleCheckIn(false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  // Helper Methods
  Future<void> _downloadData(bool isCheckInOut, GetLiveLocation getLiveLocation) async {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const SyncDialog(message: "Downloading data from the server...", syncType: "download"),
    );

    final handler = Provider.of<ItineraryDataHandle>(context, listen: false);
    final position = await getLiveLocation.getCurrentLocation();

    if (position == null) {
      if (mounted) {
        Navigator.pop(context);
        await showConfirmationDialog(
          context,
          "Your device's GPS (Location Services) is turned off.\n\nPlease enable it in settings to continue.",
          actionType: 'Ok',
        );
      }
      return;
    } else {
      await handler.itineraryData();
      await handler.productData();
      await handler.productLoyaltyProgramAndDiscounts();
      handler.saveCheckInOutDetails("checkIn", position.latitude, position.longitude);
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  Future<void> _startSync(SaveDataProvider saveData, isCheckInOut, GetLiveLocation getLiveLocation) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const SyncDialog(message: "Sync..........", syncType: 'sync'),
    );

    if (isCheckInOut) {
      final handler = Provider.of<ItineraryDataHandle>(context, listen: false);
      final position = await getLiveLocation.getCurrentLocation();
      if (position == null) {
        if (mounted) {
          Navigator.pop(context);
          await showConfirmationDialog(
            context,
            "Your device's GPS (Location Services) is turned off.\n\nPlease enable it in settings to continue.",
            actionType: 'Ok',
          );
        }
        return;
      } else {
        handler.saveCheckInOutDetails("checkOut", position.latitude, position.longitude);
      }
    }

    final isSynced = await saveData.checkConnectionAndSaveData(context, true);

    if (!mounted) return;
    Navigator.pop(context);

    if (isSynced) {
      if (!mounted) return;
      scaffoldMessenger.showSnackBar( // 👈 Safe to use now
        const SnackBar(
          content: Text('Successfully synced to the server.', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.fixed,
        ),
      );
    }
  }


  Future<bool> getResPartnerDetails(ItineraryDataHandle itineraryData, ConnectionHandle connectionCheck) async {
    if (!mounted) return false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const SyncDialog(message: "Downloading data from the server...", syncType: "download"),
    );

    final isConnected = await connectionCheck.checkConnection();
    if (isConnected) {
      resPartnerData = await itineraryData.salesPersonData();
      resPartnerData[0]["route_id"] = resPartnerData[0]["route_id"] == false ? "" : resPartnerData[0]["route_id"];
      resPartnerData[0]["territory_id"] = resPartnerData[0]["territory_id"] == false ? "" : resPartnerData[0]["territory_id"];

      if (mounted) {
        Navigator.pop(context);
      }
      return true;
    } else {
      if (mounted) {
        Navigator.pop(context);
        await showConfirmationDialog(
          context,
          "Please note that there is no available connection.\nBe sure that when internet is available, CheckOut will resume.",
          actionType: 'Ok',
        );
      }
      return false;
    }
  }

  Future<void> deleteLocalDatabase() async {
    await AppDatabase.instance.close();
    final dir = await getApplicationDocumentsDirectory();
    final path = p.join(dir.path, 'sales_person.db');
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<bool> checkIsVisitedDoneForAllLines(ItineraryDataHandle itineraryDataHandleData) async {
    for (var item in itineraryDataHandleData.convertItineraryDbData) {
      if (item["isVisited"] != true) {
        return false;
      }
    }
    return true;
  }
}