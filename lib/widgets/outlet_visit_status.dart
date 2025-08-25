import 'package:flutter/material.dart';
import 'package:polycrome_sales_application/localDb/app_database.dart';
import '../reusableWidgets/reusable_drop_down.dart';
import '../reusableWidgets/text_field.dart';
import '../constants/colors.dart';

Future<bool> showExitConfirmationDialog(
    BuildContext context,
    List<Map<String, dynamic>> outletVisitStatusList,
    String partnerName,
    int itineraryId,
    ) {
  int selectedId = 0;
  String selectedVisitStatus = "";
  Map<String, dynamic>? selectedStatusItem;
  final TextEditingController otherStatusController = TextEditingController();

  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.7),
    builder: (context) => StatefulBuilder(
      builder: (context, setModalState) {
        bool isFormValid() {
          return selectedId != 0 &&
              (selectedVisitStatus != "Other" || otherStatusController.text.trim().isNotEmpty);
        }

        return WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.75,
                maxWidth: 500,
              ),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      _buildHeader(context, partnerName),

                      // Content
                      Flexible(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Visit Status Section
                              _buildSectionTitle("Visit Status", Icons.assignment_turned_in),
                              const SizedBox(height: 12),
                              _buildVisitStatusDropdown(
                                outletVisitStatusList,
                                selectedStatusItem,
                                    (value) {
                                  if (value != null) {
                                    selectedId = value["id"];
                                    selectedVisitStatus = value["name"];
                                    selectedStatusItem = value;
                                    if (selectedVisitStatus != "Other") {
                                      otherStatusController.clear();
                                    }
                                    setModalState(() {});
                                  }
                                },
                              ),

                              // Other Reason Field
                              if (selectedVisitStatus == "Other") ...[
                                const SizedBox(height: 24),
                                _buildSectionTitle("Other Reason", Icons.edit_note),
                                const SizedBox(height: 12),
                                _buildOtherReasonField(otherStatusController, setModalState),
                              ],

                              const SizedBox(height: 32),

                              // Action Buttons
                              _buildActionButtons(
                                context,
                                isFormValid(),
                                selectedVisitStatus,
                                otherStatusController,
                                itineraryId,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  ).then((value) => value ?? false);
}

Widget _buildHeader(BuildContext context, String partnerName) {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).primaryColor.withOpacity(0.8),
        ],
      ),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.assignment_turned_in,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Visit Status",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                partnerName,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title, IconData icon) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 18,
          color: Colors.grey.shade600,
        ),
      ),
      const SizedBox(width: 12),
      Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade800,
        ),
      ),
    ],
  );
}

Widget _buildVisitStatusDropdown(
    List<Map<String, dynamic>> outletVisitStatusList,
    Map<String, dynamic>? selectedItem,
    Function(Map<String, dynamic>?) onChanged,
    ) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
      color: Colors.grey.shade50,
    ),
    child: ReusableDropdown(
      dataList: outletVisitStatusList,
      hintText: "Select Visit Status",
      selectedItem: selectedItem,
      onChange: onChanged,
    ),
  );
}

Widget _buildOtherReasonField(
    TextEditingController otherStatusController,
    StateSetter setModalState,
    ) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
      color: Colors.grey.shade50,
    ),
    child: ReusableTextField(
      controller: otherStatusController,
      labelText: "Enter other reason here...",
      maxLines: 3,
      onChanged: (value) {
        setModalState(() {});
      },
    ),
  );
}

Widget _buildActionButtons(
    BuildContext context,
    bool isFormValid,
    String selectedVisitStatus,
    TextEditingController otherStatusController,
    int itineraryId,
    ) {
  return Row(
    children: [
      Expanded(
        child: _buildButton(
          onPressed: () => Navigator.pop(context, false),
          icon: Icons.close_rounded,
          label: "Cancel",
          isPrimary: false,
          context: context,
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: _buildButton(
          onPressed: isFormValid
              ? () async {
            try {
              final visitStatus = selectedVisitStatus == "Other"
                  ? "Other Reason: ${otherStatusController.text.trim()}"
                  : selectedVisitStatus;

              await AppDatabase.instance.updateVisitStatusSalesPersonData(
                itinerary_line_id: itineraryId,
                visit_status: visitStatus,
              );

              Navigator.pop(context, true);

              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white, size: 20),
                      SizedBox(width: 12),
                      Text("Visit status updated successfully"),
                    ],
                  ),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  duration: const Duration(seconds: 3),
                ),
              );
            } catch (e) {
              print("Error updating visit status: $e");

              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.white, size: 20),
                      const SizedBox(width: 12),
                      Expanded(child: Text("Error: ${e.toString()}")),
                    ],
                  ),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  duration: const Duration(seconds: 4),
                ),
              );
            }
          }
              : null,
          icon: Icons.check_rounded,
          label: "Confirm",
          isPrimary: true,
          context: context,
        ),
      ),
    ],
  );
}

Widget _buildButton({
  required VoidCallback? onPressed,
  required IconData icon,
  required String label,
  required bool isPrimary,
  required BuildContext context,
}) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      boxShadow: onPressed != null
          ? [
        BoxShadow(
          color: isPrimary
              ? Theme.of(context).primaryColor.withOpacity(0.25)
              : Colors.grey.withOpacity(0.15),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ]
          : null,
    ),
    child: ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary
            ? Theme.of(context).primaryColor
            : Colors.grey.shade100,
        foregroundColor: isPrimary
            ? Colors.white
            : Colors.grey.shade700,
        disabledBackgroundColor: Colors.grey.shade200,
        disabledForegroundColor: Colors.grey.shade400,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: isPrimary
              ? BorderSide.none
              : BorderSide(color: Colors.grey.shade300),
        ),
      ),
    ),
  );
}