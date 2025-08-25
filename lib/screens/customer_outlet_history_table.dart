import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xml_rpc/client_c.dart' as xml_rpc;
import '../constants/staticData.dart';
import '../constants/colors.dart';
import '../reusableWidgets/date_picker.dart';
import '../reusableWidgets/reusable_drop_down.dart';
import '../reusableWidgets/sync_featching_dialog_btn.dart';

class CustomerOutletHistoryTable extends StatefulWidget {
  final String partnerName;
  final int partnerId;

  const CustomerOutletHistoryTable({
    super.key,
    required this.partnerName,
    required this.partnerId,
  });

  @override
  State<CustomerOutletHistoryTable> createState() =>
      _CustomerOutletHistoryTableState();
}

class _CustomerOutletHistoryTableState extends State<CustomerOutletHistoryTable>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController fromDate = TextEditingController();
  final TextEditingController toDate = TextEditingController();
  late DataSource dataSource;
  List<GridColumn> columns = [];
  List<dynamic> loadedDataList = [];
  final ScrollController _horizontalScroll = ScrollController();
  final DateFormat formattedDate = DateFormat('yyyy-MM-dd');
  final NumberFormat numberFormatter = NumberFormat('#,##0.00');

  bool isLoading = false;
  int totalRecords = 0;
  double totalAmount = 0.0;

  final List<Map<String, dynamic>> customerInvoices = [
    {"id": 0, "name": "All"},
    {"id": 1, "name": "Invoices"},
    {"id": 2, "name": "Credit Note"},
  ];
  int customerInvoicesId = 0;

  final List<Map<String, dynamic>> invoicesTypes = [
    {"id": 0, "name": "All"},
    {"id": 1, "name": "Outstanding"},
  ];
  int invoicesTypesId = 0;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    dataSource = DataSource(loadedDataList: loadedDataList);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchAccountMoveData(customerInvoicesId, invoicesTypesId, fromDate.text, toDate.text);
    });
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
    fromDate.dispose();
    toDate.dispose();
    _horizontalScroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                            SizedBox(height: 50,),
                            Text(
                              'Transaction History',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              widget.partnerName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '$totalRecords Records',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Summary Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet_outlined,
                          color: Colors.white.withOpacity(0.9),
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Amount',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Rs ${numberFormatter.format(totalAmount)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Filters Section
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
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
                          Icons.filter_list_rounded,
                          color: kMainColor,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Filters',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: kCartColor,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Invoice Type Filter
                    ReusableDropdown(
                      dataList: customerInvoices,
                      hintText: "Select Invoice Type",
                      selectedItem: customerInvoices[customerInvoicesId],
                      onChange: (value) async {
                        if (value != null) {
                          setState(() {
                            customerInvoicesId = value["id"];
                            if (customerInvoicesId != 1) {
                              invoicesTypesId = 0;
                            }
                          });
                          await fetchAccountMoveData(
                              customerInvoicesId, invoicesTypesId, fromDate.text, toDate.text);
                        }
                      },
                    ),

                    // Invoice Status Filter (conditional)
                    if (customerInvoicesId == 1) ...[
                      const SizedBox(height: 12),
                      ReusableDropdown(
                        dataList: invoicesTypes,
                        hintText: "Select Status Type",
                        selectedItem: invoicesTypes[invoicesTypesId],
                        onChange: (value) async {
                          if (value != null) {
                            setState(() {
                              invoicesTypesId = value["id"];
                            });
                            await fetchAccountMoveData(
                                customerInvoicesId, invoicesTypesId, fromDate.text, toDate.text);
                          }
                        },
                      ),
                    ],

                    const SizedBox(height: 16),

                    // Date Range
                    Row(
                      children: [
                        Expanded(
                          child: DatePickerFormField(
                            controller: fromDate,
                            label: "From Date",
                            isEnable: true,
                            onChanged: (value) {
                              fetchAccountMoveData(
                                  customerInvoicesId, invoicesTypesId, fromDate.text, toDate.text);
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DatePickerFormField(
                            controller: toDate,
                            label: "To Date",
                            isEnable: true,
                            onChanged: (value) {
                              fetchAccountMoveData(
                                  customerInvoicesId, invoicesTypesId, fromDate.text, toDate.text);
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            setState(() {
                              toDate.clear();
                              fromDate.clear();
                            });
                            await fetchAccountMoveData(
                                customerInvoicesId, invoicesTypesId, "", "");
                          },
                          icon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.clear_rounded,
                              color: Colors.red.shade600,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Data Table Section
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: isLoading
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : loadedDataList.isEmpty
                    ? _buildEmptyState()
                    : SfDataGrid(
                  horizontalScrollController: _horizontalScroll,
                  selectionMode: SelectionMode.none,
                  source: dataSource,
                  columns: getColumns(),
                  headerRowHeight: 60,
                  rowHeight: 55,
                  gridLinesVisibility: GridLinesVisibility.none,
                  headerGridLinesVisibility: GridLinesVisibility.none,
                  onCellTap: (DataGridCellTapDetails details) {
                    int rowIndex = details.rowColumnIndex.rowIndex;
                    if (rowIndex > 0) {
                      // Handle row tap
                    }
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
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
              Icons.receipt_long_outlined,
              size: 50,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'No transactions found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  List<GridColumn> getColumns() {
    return [
      GridColumn(
        columnName: "name",
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        label: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          color: kMainColor,
          alignment: Alignment.centerLeft,
          child: const Text(
            "Invoice Number",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
      GridColumn(
        columnName: "status_in_payment",
        width: 120,
        label: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          color: kMainColor,
          alignment: Alignment.center,
          child: const Text(
            "Status",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
      GridColumn(
        columnName: "formatted_invoice_date",
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        label: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          color: kMainColor,
          alignment: Alignment.centerLeft,
          child: const Text(
            "Invoice Date",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
      GridColumn(
        columnName: "formatted_invoice_date_due",
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        label: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          color: kMainColor,
          alignment: Alignment.centerLeft,
          child: const Text(
            "Due Date",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
      GridColumn(
        columnName: "formatted_amount_total",
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        label: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          color: kMainColor,
          alignment: Alignment.centerRight,
          child: const Text(
            "Amount",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
    ];
  }

  Future<dynamic> fetchAccountMoveData(
      int customerInvoicesId, int invoicesTypesId, String fromDate, String toDate) async {
    setState(() {
      isLoading = true;
      totalRecords = 0;
      totalAmount = 0.0;
    });

    try {
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const SyncDialog(
            message: "Loading transaction history...",
            syncType: "download",
          ),
        );
      }

      final pref = await SharedPreferences.getInstance();
      final userId = pref.getInt("user_Id");
      final password = pref.getString("password");

      if (userId == null || password == null) {
        throw Exception("User credentials not found");
      }

      List<String> moveTypeList;
      if (customerInvoicesId == 0) {
        moveTypeList = ['out_invoice', 'out_refund'];
      } else if (customerInvoicesId == 1) {
        moveTypeList = ['out_invoice'];
      } else {
        moveTypeList = ['out_refund'];
      }

      List<dynamic> domain = [
        ['partner_id', '=', widget.partnerId],
        ['state', '=', "posted"],
        ['move_type', 'in', moveTypeList],
      ];

      if (invoicesTypesId == 1) {
        domain.add(['status_in_payment', 'in', ['not_paid', 'in_payment', 'partial']]);
      }

      if (fromDate.isNotEmpty && toDate.isNotEmpty) {
        domain.addAll([
          ['invoice_date', '>=', fromDate],
          ['invoice_date', '<=', toDate],
        ]);
      } else if (fromDate.isNotEmpty) {
        domain.add(['invoice_date', '>=', fromDate]);
      } else if (toDate.isNotEmpty) {
        domain.add(['invoice_date', '<=', toDate]);
      }

      final accountMoveData = await xml_rpc.call(
        Uri.parse("$baseUrl/xmlrpc/2/object"),
        'execute_kw',
        [
          dbName,
          userId,
          password,
          'account.move',
          'search_read',
          [domain],
          {
            'fields': [
              'id',
              'name',
              'invoice_date',
              'invoice_date_due',
              'amount_total',
              'status_in_payment',
            ],
          },
        ],
      );

      loadedDataList.clear();
      double calculatedTotal = 0.0;

      if (accountMoveData.isNotEmpty) {
        for (dynamic item in accountMoveData) {
          // Format dates
          item["formatted_invoice_date"] = item["invoice_date"] == null || item["invoice_date"] == ''
              ? ""
              : formattedDate.format(DateTime.parse(item["invoice_date"]));

          item["formatted_invoice_date_due"] = item["invoice_date_due"] == null || item["invoice_date_due"] == ''
              ? ""
              : formattedDate.format(DateTime.parse(item["invoice_date_due"]));

          // Format amount
          double amount = double.tryParse(item["amount_total"].toString()) ?? 0.0;
          item["formatted_amount_total"] = numberFormatter.format(amount);
          calculatedTotal += amount;

          // Create status widget
          item["status_in_payment"] = _buildStatusChip(item["status_in_payment"]);

          loadedDataList.add(item);
        }
      }

      setState(() {
        totalRecords = loadedDataList.length;
        totalAmount = calculatedTotal;
        dataSource = DataSource(loadedDataList: loadedDataList);
        isLoading = false;
      });

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error loading data: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildStatusChip(String status) {
    String label;
    Color color;

    switch (status) {
      case "not_paid":
        label = "Not Paid";
        color = Colors.red;
        break;
      case "in_payment":
        label = "In Payment";
        color = Colors.orange;
        break;
      case "paid":
        label = "Paid";
        color = Colors.green;
        break;
      case "partial":
        label = "Partial";
        color = Colors.orange;
        break;
      case "reversed":
        label = "Reversed";
        color = Colors.purple;
        break;
      case "blocked":
        label = "Blocked";
        color = Colors.red;
        break;
      default:
        label = "Legacy";
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class DataSource extends DataGridSource {
  DataSource({required List loadedDataList}) {
    _employeeData = loadedDataList
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'name', value: e['name']),
      DataGridCell<Widget>(columnName: 'status_in_payment', value: e['status_in_payment']),
      DataGridCell<String>(columnName: 'formatted_invoice_date', value: e['formatted_invoice_date'].toString()),
      DataGridCell<String>(columnName: 'formatted_invoice_date_due', value: e['formatted_invoice_date_due'].toString()),
      DataGridCell<String>(columnName: 'formatted_amount_total', value: e['formatted_amount_total']),
    ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        if (e.columnName == "status_in_payment") {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: e.value,
          );
        } else if (e.columnName == "formatted_amount_total") {
          return Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              e.value.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          );
        } else {
          return Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              e.value.toString(),
              style: const TextStyle(
                fontSize: 13,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }
      }).toList(),
    );
  }
}