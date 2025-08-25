import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:polycrome_sales_application/localDb/app_database.dart';
import 'package:polycrome_sales_application/providers/order_return_payment_provider.dart';
import 'package:provider/provider.dart';
import '../reusableWidgets/date_picker.dart';
import '../reusableWidgets/reusable_drop_down.dart';
import '../reusableWidgets/showDialog.dart';
import '../reusableWidgets/text_field.dart';

class PaymentDraggableSheet {
  TextEditingController searchField = TextEditingController();

  Future<void> openDraggableSheet(
      String paymentType,
      BuildContext context,
      int liternary_Id,
      Map<String, dynamic> paymentValidData,
      VoidCallback onPressed,
      {required paymentLineId, required partnerId}
      ) async {

    await Provider.of<OrderReturnPaymentProvider>(context, listen: false)
        .fetchPaymentInvoicesDropData(partnerId);
    final showPaymentInvoicesDropData = Provider.of<OrderReturnPaymentProvider>(
        context, listen: false);

    final DraggableScrollableController sheetController = DraggableScrollableController();
    final TextEditingController paymentDate = TextEditingController();
    final TextEditingController invoiceDate = TextEditingController();
    final TextEditingController invoiceAmount = TextEditingController();
    final TextEditingController chequeNumber = TextEditingController();
    final TextEditingController chequeDate = TextEditingController();
    final TextEditingController amount = TextEditingController();

    final List<Map<String, dynamic>> invoiceList = showPaymentInvoicesDropData
        .showPaymentInvoicesDropData;

    Map<String, dynamic> currentUpdateChangeMap = {};
    Map<String, dynamic> currentAddNewChangeMap = {};
    bool isChequeVisible = false;
    if (paymentValidData["payment_method"] == "cheque") {
      isChequeVisible = true;
    }

    final List<Map<String, dynamic>> paymentMethodList = [
      {"id": 1, "name": "cash"},
      {"id": 2, "name": "cheque"},
    ];

    Map<String, dynamic>? selectedInvoice;
    Map<String, dynamic>? selectedPaymentMethod = setFieldsValue(
      paymentValidData,
      paymentDate,
      invoiceDate,
      chequeNumber,
      chequeDate,
      invoiceAmount,
      amount,
      paymentMethodList,
      invoiceList,
      currentUpdateChangeMap,
          (value) => selectedInvoice = value,
    );

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (BuildContext sheetContext) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: StatefulBuilder(
            builder: (context, setModalState) {
              final theme = Theme.of(context);

              return DraggableScrollableSheet(
                controller: sheetController,
                initialChildSize: 0.85,
                minChildSize: 0.6,
                maxChildSize: 0.95,
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
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade200,
                                width: 1,
                              ),
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
                                  paymentType == "updatePayment"
                                      ? Icons.edit_outlined
                                      : Icons.payment_outlined,
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
                                      paymentType == "updatePayment"
                                          ? "Update Payment Line"
                                          : "Create Payment Line",
                                      style: theme.textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: theme.colorScheme.onSurface,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      paymentType == "updatePayment"
                                          ? "Modify payment details"
                                          : "Add a new payment entry",
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                                        letterSpacing: 0.1,
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
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Invoice Selection Section
                                _buildSectionHeader(
                                  "Invoice Details",
                                  Icons.receipt_long_outlined,
                                  theme,
                                ),
                                const SizedBox(height: 16),

                                ReusableDropdown(
                                  dataList: invoiceList,
                                  hintText: "Select Invoice",
                                  selectedItem: selectedInvoice,
                                  isEnabled: paymentType != "updatePayment",
                                  onChange: (Map<String, dynamic>? value) {
                                    if (value != null) {
                                      currentAddNewChangeMap = value;
                                      final now = DateTime.now();
                                      final formatter = DateFormat('yyyy-MM-dd');
                                      paymentDate.text = formatter.format(now);
                                      invoiceDate.text = value["invoice_date"];
                                      invoiceAmount.text = value["invoice_amount"].toString();
                                      setModalState(() {});
                                    }
                                  },
                                ),

                                const SizedBox(height: 16),

                                DatePickerFormField(
                                  controller: invoiceDate,
                                  label: "Invoice Date",
                                  isEnable: false,
                                ),

                                const SizedBox(height: 16),

                                ReusableTextField(
                                  controller: invoiceAmount,
                                  labelText: "Invoice Amount",
                                  hintText: "Enter invoice amount",
                                  keyboardType: TextInputType.number,
                                  prefixIcon: Icons.attach_money_outlined,
                                  readOnly: false,
                                  onChanged: (value) {
                                    currentUpdateChangeMap["invoiceAmount"] = value;
                                    setModalState(() {});
                                  },
                                ),

                                const SizedBox(height: 24),

                                // Payment Method Section
                                _buildSectionHeader(
                                  "Payment Method",
                                  Icons.credit_card_outlined,
                                  theme,
                                ),
                                const SizedBox(height: 16),

                                ReusableDropdown(
                                  dataList: paymentMethodList,
                                  hintText: "Payment Method",
                                  selectedItem: selectedPaymentMethod,
                                  onChange: (Map<String, dynamic>? value) {
                                    if (value != null) {
                                      currentUpdateChangeMap["paymentMethod"] = value["name"];
                                      currentAddNewChangeMap["paymentMethod"] = value["name"];
                                      isChequeVisible = value["name"] == "cheque";
                                    }
                                    selectedPaymentMethod = value!;
                                    setModalState(() {});
                                  },
                                ),

                                const SizedBox(height: 16),

                                DatePickerFormField(
                                  controller: paymentDate,
                                  label: "Payment Date",
                                  isEnable: true,
                                ),

                                const SizedBox(height: 16),

                                ReusableTextField(
                                  controller: amount,
                                  labelText: "Payment Amount",
                                  hintText: "Enter payment amount",
                                  keyboardType: TextInputType.number,
                                  prefixIcon: Icons.payments_outlined,
                                  onChanged: (value) {
                                    currentUpdateChangeMap["amount"] = value;
                                    setModalState(() {});
                                  },
                                ),

                                // Cheque Details Section (Conditional)
                                if (isChequeVisible) ...[
                                  const SizedBox(height: 24),

                                  _buildSectionHeader(
                                    "Cheque Details",
                                    Icons.receipt_outlined,
                                    theme,
                                  ),
                                  const SizedBox(height: 16),

                                  ReusableTextField(
                                    controller: chequeNumber,
                                    labelText: "Cheque Number",
                                    hintText: "Enter cheque number",
                                    prefixIcon: Icons.confirmation_number_outlined,
                                    textCapitalization: TextCapitalization.characters,
                                    onChanged: (value) {
                                      currentUpdateChangeMap["chequeNumber"] = value;
                                      setModalState(() {});
                                    },
                                  ),

                                  const SizedBox(height: 16),

                                  DatePickerFormField(
                                    controller: chequeDate,
                                    label: "Cheque Date",
                                    isEnable: true,
                                    onChanged: (value) {
                                      currentUpdateChangeMap["chequeDate"] = value;
                                      setModalState(() {});
                                    },
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
                                if (paymentType == "updatePayment") {
                                  await updatePaymentLineData(
                                    paymentValidData,
                                    currentUpdateChangeMap,
                                  );
                                } else {
                                  if (currentUpdateChangeMap["paymentMethod"] != null ||
                                      currentAddNewChangeMap["id"] != null) {
                                    await addNewPaymentLineData(
                                      paymentLineId,
                                      currentAddNewChangeMap,
                                      paymentDate,
                                      chequeNumber,
                                      chequeDate,
                                      amount,
                                      liternary_Id,
                                    );
                                  } else {
                                    await showConfirmationDialog(
                                      context,
                                      "Please fill the required fields!",
                                      actionType: 'Ok',
                                    );
                                    return;
                                  }
                                }
                                Navigator.of(sheetContext).pop();
                              },
                              icon: Icon(
                                paymentType == "updatePayment"
                                    ? Icons.update_outlined
                                    : Icons.add_outlined,
                                size: 20,
                              ),
                              label: Text(
                                paymentType == "updatePayment"
                                    ? "Update Payment"
                                    : "Create Payment",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.3,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                elevation: 2,
                                shadowColor: theme.colorScheme.primary.withOpacity(0.3),
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
    ).then((value) {
      onPressed();
    });
  }

  Widget _buildSectionHeader(String title, IconData icon, ThemeData theme) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: theme.colorScheme.primary,
            size: 18,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  Future<void> updatePaymentLineData(
      Map<String, dynamic> paymentValidData,
      Map<String, dynamic> currentChangeMap,
      ) async {
    AppDatabase dataBase = AppDatabase.instance;
    await dataBase.updatePaymentUsageData(
      itinerary_line_id: paymentValidData["id"],
      id: paymentValidData["id"],
      paymentLineId: paymentValidData["payment_line_id"],
      itineraryPaymentLineId: paymentValidData["id"],
      date: paymentValidData["date"],
      invoiceId: paymentValidData["invoice_id"],
      invoiceName: paymentValidData["invoice_name"],
      invoiceDate: paymentValidData["invoice_date"],
      paymentMethod: currentChangeMap["paymentMethod"] ?? paymentValidData["payment_method"],
      amount: double.parse(currentChangeMap["amount"]?.toString() ?? "0"),
      invoiceAmount: double.parse(currentChangeMap["invoiceAmount"]?.toString() ?? "0"),
      chequeNumber: currentChangeMap["chequeNumber"] ?? paymentValidData["cheque_number"],
      chequeDate: currentChangeMap["chequeDate"] ?? paymentValidData["cheque_date"],
      isSynced: false,
    );
  }

  Future<void> addNewPaymentLineData(
      int paymentLineId,
      Map<String, dynamic> currentChangeMap,
      TextEditingController paymentDate,
      TextEditingController chequeNumber,
      TextEditingController chequeDate,
      TextEditingController amount,
      int liternary_Id,
      ) async {
    AppDatabase dataBase = AppDatabase.instance;
    await dataBase.insertPaymentUsageData(
      itinerary_line_id: 0,
      odooId: 0,
      paymentLineId: liternary_Id,
      date: paymentDate.text,
      invoiceId: currentChangeMap["id"],
      invoice_name: currentChangeMap["name"],
      invoiceDate: currentChangeMap["invoice_date"],
      paymentMethod: currentChangeMap["paymentMethod"],
      chequeDate: chequeDate.text,
      chequeNumber: chequeNumber.text,
      amount: amount.text.isEmpty ? 0 : double.parse(amount.text),
      invoice_amount: currentChangeMap["invoice_amount"],
      isExciteOrNew: false,
    );
  }

  Map<String, dynamic>? setFieldsValue(
      Map<String, dynamic> paymentValidData,
      TextEditingController paymentDate,
      TextEditingController invoiceDate,
      TextEditingController chequeNumber,
      TextEditingController chequeDate,
      TextEditingController invoiceAmount,
      TextEditingController amount,
      List<Map<String, dynamic>> paymentMethodList,
      List<Map<String, dynamic>> invoiceList,
      Map<String, dynamic> currentUpdateChangeMap,
      void Function(Map<String, dynamic>?) onSetSelectedInvoice,
      ) {
    if (paymentValidData.isNotEmpty) {
      currentUpdateChangeMap["invoiceAmount"] = paymentValidData['invoice_amount'];
      currentUpdateChangeMap["chequeNumber"] = paymentValidData['cheque_number'];
      currentUpdateChangeMap["chequeDate"] = paymentValidData['cheque_date'];
      currentUpdateChangeMap["amount"] = paymentValidData['invoice_amount'];

      paymentDate.text = paymentValidData['date'].toString();
      invoiceDate.text = paymentValidData['invoice_date'].toString();
      chequeNumber.text = paymentValidData['cheque_number'].toString();
      chequeDate.text = paymentValidData['cheque_date'].toString();
      invoiceAmount.text = paymentValidData['invoice_amount'].toString();
      amount.text = paymentValidData['amount'].toString();

      Map<String, dynamic>? matchedInvoice;
      try {
        matchedInvoice = invoiceList.firstWhere(
              (item) => item["name"] == paymentValidData['invoice_name'],
        );
      } catch (e) {
        matchedInvoice = null;
      }

      Map<String, dynamic>? matchedPaymentMethod;
      try {
        matchedPaymentMethod = paymentMethodList.firstWhere(
              (item) => item["name"] == paymentValidData['payment_method'],
        );
      } catch (e) {
        matchedPaymentMethod = null;
      }

      onSetSelectedInvoice(matchedInvoice);
      return matchedPaymentMethod;
    }

    return null;
  }
}