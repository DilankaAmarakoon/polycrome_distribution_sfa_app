import 'package:flutter/material.dart';
import 'package:polycrome_sales_application/localDb/app_database.dart';
import '../providers/order_return_payment_provider.dart';
import '../reusableWidgets/drop_down.dart';
import '../reusableWidgets/reusable_drop_down.dart';
import '../reusableWidgets/text_field.dart';

Future<bool> showReturnRemarkDialog(
    BuildContext context,
    index,
    OrderReturnPaymentProvider orderReturnProviderData,
    productId,
    itineraryId
    ) {
  TextEditingController remark = TextEditingController();
  remark.text = orderReturnProviderData.showReturnProductValidData[index]["remark"].toString();
  int returnReasonId = orderReturnProviderData.showReturnProductValidData[index]["return_reason_id"];
  int returnActionId = orderReturnProviderData.showReturnProductValidData[index]["return_action_id"];

  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.7),
    builder: (context) => StatefulBuilder(
      builder: (context, setModalState) {
        Map<String, dynamic>? getReturnTypeById() {
          if (orderReturnProviderData.showReturnProductValidData[index]["return_reason_id"] != 0) {
            return orderReturnProviderData.showReturnTypeDropData.firstWhere(
                  (item) => item['id'] == orderReturnProviderData.showReturnProductValidData[index]["return_reason_id"],
              orElse: () => {},
            );
          }
          return null;
        }

        Map<String, dynamic>? getReturnActionById() {
          if (orderReturnProviderData.showReturnProductValidData[index]["return_action_id"] != 0) {
            return orderReturnProviderData.showReturnActionDropData.firstWhere(
                  (item) => item['id'] == orderReturnProviderData.showReturnProductValidData[index]["return_action_id"],
              orElse: () => {},
            );
          }
          return null;
        }

        bool isFormValid() {
          return remark.text.trim().isNotEmpty &&
              returnReasonId != 0 &&
              returnActionId != 0;
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
                      _buildHeader(context),

                      // Content
                      Flexible(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Remark Section
                              _buildSectionTitle("Remark", Icons.comment_outlined),
                              const SizedBox(height: 12),
                              _buildRemarkField(
                                  remark,
                                  orderReturnProviderData,
                                  index,
                                  setModalState
                              ),

                              const SizedBox(height: 24),

                              // Return Type Section
                              _buildSectionTitle("Return Type", Icons.category_outlined),
                              const SizedBox(height: 12),
                              _buildReturnTypeDropdown(
                                orderReturnProviderData,
                                getReturnTypeById(),
                                    (value) {
                                  if (value != null) {
                                    returnReasonId = value["id"];
                                    orderReturnProviderData.showReturnProductValidData[index]["return_reason_id"] = returnReasonId;
                                    setModalState(() {});
                                  }
                                },
                              ),

                              const SizedBox(height: 24),

                              // Return Action Section
                              _buildSectionTitle("Return Action", Icons.settings_outlined),
                              const SizedBox(height: 12),
                              _buildReturnActionDropdown(
                                orderReturnProviderData,
                                getReturnActionById(),
                                    (value) {
                                  if (value != null) {
                                    returnActionId = value["id"];
                                    orderReturnProviderData.showReturnProductValidData[index]["return_action_id"] = returnActionId;
                                    setModalState(() {});
                                  }
                                },
                              ),

                              const SizedBox(height: 32),

                              // Action Buttons
                              _buildActionButtons(
                                context,
                                isFormValid(),
                                remark,
                                itineraryId,
                                productId,
                                returnReasonId,
                                returnActionId,
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

Widget _buildHeader(BuildContext context) {
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
            Icons.assignment_return,
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
                "Return Reason",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Provide return information details",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w400,
                ),
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

Widget _buildRemarkField(
    TextEditingController remark,
    OrderReturnPaymentProvider orderReturnProviderData,
    int index,
    StateSetter setModalState,
    ) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
      color: Colors.grey.shade50,
    ),
    child: ReusableTextField(
      controller: remark,
      labelText: "Enter your remark here...",
      maxLines: 3,
      onChanged: (value) {
        orderReturnProviderData.showReturnProductValidData[index]["remark"] = value;
        setModalState(() {});
      },
    ),
  );
}

Widget _buildReturnTypeDropdown(
    OrderReturnPaymentProvider orderReturnProviderData,
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
      dataList: orderReturnProviderData.showReturnTypeDropData,
      hintText: "Select Return Type",
      selectedItem: selectedItem,
      onChange: onChanged,
    ),
  );
}

Widget _buildReturnActionDropdown(
    OrderReturnPaymentProvider orderReturnProviderData,
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
      dataList: orderReturnProviderData.showReturnActionDropData,
      hintText: "Select Return Action",
      selectedItem: selectedItem,
      onChange: onChanged,
    ),
  );
}

Widget _buildActionButtons(
    BuildContext context,
    bool isFormValid,
    TextEditingController remark,
    int itineraryId,
    int productId,
    int returnReasonId,
    int returnActionId,
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
              print("Saving return details - ReasonId: $returnReasonId, ActionId: $returnActionId");

              await AppDatabase.instance.updateReturnRemarkFieldsByItineraryAndProduct(
                itineraryLineId: itineraryId,
                productId: productId,
                return_reason: remark.text,
              );

              await AppDatabase.instance.updateReturnReasonIdAndActionFieldsByItineraryAndProduct(
                itineraryLineId: itineraryId,
                productId: productId,
                return_reason_id: returnReasonId,
              );

              await AppDatabase.instance.updateReturnActionIdAndActionFieldsByItineraryAndProduct(
                itineraryLineId: itineraryId,
                productId: productId,
                return_action_id: returnActionId,
              );

              Navigator.pop(context, true);

              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white, size: 20),
                      SizedBox(width: 12),
                      Text("Return details saved successfully"),
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
              print("Error saving return details: $e");

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