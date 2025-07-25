import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../get_live_location.dart';
import '../providers/handdle_data_provider.dart';
import '../reusableWidgets/showDialog.dart';
import '../reusableWidgets/sync_featching_dialog_btn.dart';
import '../reusableWidgets/text_field.dart';

class CheckInOutDraggableSheet {
  TextEditingController vehicleNumber = TextEditingController();
  TextEditingController startMileage = TextEditingController();
  TextEditingController endMileage = TextEditingController();
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  Future<dynamic> openDraggableSheet(
      BuildContext context,
      Map<String, dynamic> resPartnerData,
      ) async {
    final itineraryDataHandle = Provider.of<ItineraryDataHandle>(context, listen: false);
    final DraggableScrollableController sheetController = DraggableScrollableController();
    final SharedPreferences pref = await SharedPreferences.getInstance();
    GetLiveLocation getLiveLocation = GetLiveLocation();
    bool? isChecked = pref.getBool('isCheckedIn') ?? false;

    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: true,
      builder: (BuildContext sheetContext) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: StatefulBuilder(
            builder: (context, setModalState) {
              final theme = Theme.of(context);

              return DraggableScrollableSheet(
                controller: sheetController,
                initialChildSize: 0.75,
                minChildSize: 0.5,
                maxChildSize: 0.9,
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, -8),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Drag Handle
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),

                        // Header Section
                        Padding(
                          padding: const EdgeInsets.all(20),
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
                                  isChecked ? Icons.logout_rounded : Icons.login_rounded,
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
                                      "Attendance",
                                      style: theme.textTheme.headlineSmall?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      isChecked ? "Ready to check out?" : "Ready to check in?",
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              IconButton(
                                onPressed: () => Navigator.of(sheetContext).pop(),
                                icon: Icon(
                                  Icons.close_rounded,
                                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                                ),
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.grey.shade100,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Content Section
                        Expanded(
                          child: SingleChildScrollView(
                            controller: scrollController,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Info Card
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        theme.colorScheme.primary,
                                        theme.colorScheme.primary.withOpacity(0.8),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: theme.colorScheme.primary.withOpacity(0.3),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      _buildInfoRow("Current Date", currentDate, theme),
                                      const SizedBox(height: 12),
                                      _buildInfoRow("Visit Date", currentDate, theme),
                                      const SizedBox(height: 12),
                                      _buildInfoRow("Sales Person", resPartnerData["name"] ?? "", theme),
                                      const SizedBox(height: 12),
                                      _buildInfoRow("Distributor", resPartnerData["company_id"]?[1] ?? "", theme),
                                      const SizedBox(height: 12),
                                      _buildInfoRow("PSA", resPartnerData["route_id"]?.toString() ?? "", theme),
                                      const SizedBox(height: 12),
                                      _buildInfoRow("Territory", resPartnerData["territory_id"]?.toString() ?? "", theme),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 24),

                                // Input Section
                                if (!isChecked) ...[
                                  Text(
                                    "Vehicle Information",
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  // ReusableTextField(
                                  //   controller: vehicleNumber,
                                  //   labelText: "Vehicle Number",
                                  //   hintText: "Enter vehicle number",
                                  //   prefixIcon: Icons.directions_car_outlined,
                                  //   textCapitalization: TextCapitalization.characters,
                                  // ),
                                  const SizedBox(height: 12),
                                  ReusableTextField(
                                    controller: startMileage,
                                    labelText: "Start Mileage",
                                    hintText: "Enter starting mileage",
                                    prefixIcon: Icons.speed_outlined,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) => setModalState(() {}),
                                  ),
                                ] else ...[
                                  Text(
                                    "End Mileage",
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ReusableTextField(
                                    controller: endMileage,
                                    labelText: "End Mileage",
                                    hintText: "Enter ending mileage",
                                    prefixIcon: Icons.speed_outlined,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) => setModalState(() {}),
                                  ),
                                ],

                                const SizedBox(height: 32),
                              ],
                            ),
                          ),
                        ),

                        // Action Button Section
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            border: Border(
                              top: BorderSide(
                                color: Colors.grey.shade200,
                                width: 1,
                              ),
                            ),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                if (!isChecked) {
                                  // Check In Logic
                                  if (startMileage.text.isEmpty) {
                                    await showConfirmationDialog(
                                      context,
                                      "Please fill in the start mileage !",
                                      actionType: 'ok',
                                    );
                                    return;
                                  }
                                  itineraryDataHandle.setIsisVisibleCheckIn(true);
                                  pref.setBool('isCheckedIn', true);
                                  itineraryDataHandle.setStartMileage(double.parse(startMileage.text));
                                  Navigator.of(sheetContext).pop("checkIn");
                                } else {
                                  // Check Out Logic
                                  if (endMileage.text.isEmpty) {
                                    await showConfirmationDialog(
                                      context,
                                      "Please fill in the end mileage !",
                                      actionType: 'ok',
                                    );
                                    return;
                                  }

                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) => Center(
                                      child: LoadingAnimationWidget.progressiveDots(
                                        color: theme.colorScheme.primary,
                                        size: 40,
                                      ),
                                    ),
                                  );

                                  final position = await getLiveLocation.getCurrentLocation();
                                  Navigator.pop(context);

                                  if (position == null) {
                                    await showConfirmationDialog(
                                      context,
                                      "Your device's GPS (Location Services) is turned off.\n\nPlease enable it in settings to continue.",
                                      actionType: 'Ok',
                                    );
                                  } else {
                                    final confirmed = await showConfirmationDialog(
                                      context,
                                      "Are you sure you want to check out?",
                                      actionType: 'check out',
                                    );
                                    if (confirmed == true) {
                                      itineraryDataHandle.setEndMileage(double.parse(endMileage.text));
                                      Navigator.of(sheetContext).pop(confirmed);
                                    }
                                  }
                                }
                              },
                              icon: Icon(
                                isChecked ? Icons.logout_rounded : Icons.login_rounded,
                                size: 20,
                              ),
                              label: Text(
                                isChecked ? "Check Out" : "Check In",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.3,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isChecked ? const Color(0xFFE57373) : Colors.green,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                elevation: 2,
                                shadowColor: (isChecked ? const Color(0xFFE57373) : Colors.green).withOpacity(0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value, ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 13,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
            ),
          ),
        ),
        Text(
          " : ",
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ],
    );
  }
}