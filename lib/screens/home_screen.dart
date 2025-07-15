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
import '../reusableWidgets/check_in_out_btn.dart';
import '../reusableWidgets/showDialog.dart';
import '../reusableWidgets/sync_btn.dart';
import '../reusableWidgets/sync_featching_dialog_btn.dart';
import '../screens/login_screen.dart';
import '../widgets/check_in_out.dragable_sheet.dart';
import '../widgets/itinerary_line.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> resPartnerData = [];

  @override
  void initState() {
    super.initState();
    _loadCheckInStatus();
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
  Widget build(BuildContext context) {
    final itineraryData = Provider.of<ItineraryDataHandle>(context);
    final connectionCheck = Provider.of<ConnectionHandle>(context, listen: false);
    final saveData = Provider.of<SaveDataProvider>(context, listen: false);
    GetLiveLocation getLiveLocation = GetLiveLocation();
    final sheet = CheckInOutDraggableSheet();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Column(
          children: [
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CheckInOutButton(
                          isCheckedIn: itineraryData.isVisibleCheckIn,
                          onPressed: () async {
                            // deleteLocalDatabase();
                            if(itineraryData.isVisibleCheckIn){
                              final isAllVisited = await checkIsVisitedDoneForAllLines(itineraryData);
                              if (!isAllVisited) {
                                await showConfirmationDialog(
                                  context,
                                  "Before proceeding with checkout, please update the visit status in the itinerary line from *Pending* to *Visited*.",
                                  actionType: 'Ok',
                                  isDisableCancel: true,
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
                              await _downloadData(true,getLiveLocation);
                            } else if (result == true) {
                              final bool isConnected = await connectionCheck.checkConnection();
                              if (isConnected) {
                                await _startSync(saveData,true,getLiveLocation);
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
                          },
                        ),
                        SyncDialogButton(
                          icon: Icons.sync,
                          isDisabled: !itineraryData.isVisibleCheckIn,
                          lable: "Update & Sync",
                          onTap: () async {
                            final isConnected = await connectionCheck.checkConnection();
                            if (isConnected) {
                              await _startSync(saveData,false,getLiveLocation,);
                              await _downloadData(false,getLiveLocation);
                            } else {
                              await showConfirmationDialog(
                                context,
                                "Please note that there is no available connection.\n Be sure that when internet is available, CheckOut will resume.",
                                actionType: 'Ok',
                              );
                            }
                          },
                        ),
                        SyncDialogButton(
                          icon: Icons.list,
                          isDisabled: !itineraryData.isVisibleCheckIn,
                          lable: "Visit Details",
                          onTap: () async {
                            await itineraryData.fetchDbItineraryDate();
                            await itineraryData.fetchVisitStatusData();
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ItineraryLines(),
                              ),
                            );

                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SyncDialogButton(
                          icon: Icons.power_settings_new_outlined,
                          lable: "Log Out",
                          onTap: () async {
                            if(itineraryData.isVisibleCheckIn){
                              await showConfirmationDialog(
                                context,
                                "Before logging out, please make sure you have completed the checkout process.",
                                actionType: 'Ok',
                              );
                              return;
                            }
                            final confirmed = await showConfirmationDialog(
                              context,
                              "Are you sure you want to log out?",
                              actionType: 'log out',
                            );
                            if(confirmed!){
                              final pref = await SharedPreferences.getInstance();
                              await pref.clear();
                              itineraryData.setIsisVisibleCheckIn(false);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const LoginScreen()),
                              );
                            }
                          },
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
    );
  }
  Future<void> _downloadData(bool isCheckInOut,GetLiveLocation getLiveLocation) async {
    print("eerr");
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const SyncDialog(message: "Downloading data from the server...", syncType: "download"),
    );
    print("4445555.$isCheckInOut");
      final handler = Provider.of<ItineraryDataHandle>(context, listen: false);
      final position =  await getLiveLocation.getCurrentLocation();
      if(position == null){
        await showConfirmationDialog(
          context,
          "Your device's GPS (Location Services) is turned off.\n\nPlease enable it in settings to continue.",
          actionType: 'Ok',
        );
        return;
      }else{
        print("sss");
        await handler.itineraryData();
        await handler.productData();
        await handler.productLoyaltyProgramAndDiscounts();
        handler.saveCheckInOutDetails("checkIn",position.latitude,position.longitude);
      }
    if (!mounted) return;
    Navigator.pop(context);
  }

  Future<void> _startSync(SaveDataProvider saveData,isCheckInOut,GetLiveLocation getLiveLocation) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const SyncDialog(message: "Sync..........", syncType: 'sync'),
    );
    if(isCheckInOut){
      final handler = Provider.of<ItineraryDataHandle>(context, listen: false);
      final position =  await getLiveLocation.getCurrentLocation();
      if(position == null){
        await showConfirmationDialog(
          context,
          "Your device's GPS (Location Services) is turned off.\n\nPlease enable it in settings to continue.",
          actionType: 'Ok',
        );
        return;
      }else{
        handler.saveCheckInOutDetails("checkOut",position.latitude,position.longitude);
      }
    }
    final isSynced = await saveData.checkConnectionAndSaveData(context, true);
    if (!mounted) return;
    Navigator.pop(context);
    if (isSynced) {
      await ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully synced to the server.', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.fixed,
        ),
      );
    }
  }

  Future<bool>getResPartnerDetails(ItineraryDataHandle itineraryData,ConnectionHandle connectionCheck)async{
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
      Navigator.pop(context);
      return true;
    } else {
      await showConfirmationDialog(
        context,
        "Please note that there is no available connection.\n Be sure that when internet is available, CheckOut will resume.",
        actionType: 'Ok',
      );
      Navigator.pop(context);
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
