import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:polycrome_sales_application/reusableWidgets/date_picker.dart';
import 'package:polycrome_sales_application/reusableWidgets/drop_down.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:xml_rpc/client_c.dart' as xml_rpc;
import '../constants/staticData.dart';
import '../reusableWidgets/sync_featching_dialog_btn.dart';

class CustomerOutletHistoryTable extends StatefulWidget {
  final partnerName;
  final partnerId;
  const CustomerOutletHistoryTable({super.key, required this.partnerName, required this.partnerId,});

  @override
  State<CustomerOutletHistoryTable> createState() => _CustomerOutletHistoryTableState();
}

class _CustomerOutletHistoryTableState extends State<CustomerOutletHistoryTable> {

  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  late DataSource dataSource;
  List<GridColumn> columns = [];
  List <dynamic> loadedDataList = [];
  final ScrollController _horizontalScroll = ScrollController();
  DateFormat formattedDate = DateFormat('yyyy-MM-dd');
  final numberFormatter = NumberFormat('#,##0.00');
  List<Map<String, dynamic>> customerInvoices = [
    {"id":0,"name":"All"},
    {"id":1,"name":"Invoices"},
    {"id":2,"name":"Credit Note"},
  ];
  int customerInvoicesId = 0;
  List<Map<String, dynamic>>invoicesTypes = [
    {"id":0,"name":"All"},
    {"id":1,"name":"Outstanding"},
  ];
  int invoicesTypesId = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchAccountMoveData(customerInvoicesId,invoicesTypesId,fromDate.text,toDate.text);
    });
    dataSource = DataSource(loadedDataList: loadedDataList);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("${widget.partnerName}\n Invoices & Credit Note",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Theme.of(context).primaryColor),),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 50,
              child: StyledDropdown(
                  dataList: customerInvoices,
                  type: "DefaultSetValue",
                  prefixText: "Customer Invoices",
                  onChange: (value)async{
                    if(value != null){
                      customerInvoicesId= value["id"];
                      if(customerInvoicesId != 1){
                        invoicesTypesId = 0;
                      }
                      await fetchAccountMoveData(customerInvoicesId,invoicesTypesId,fromDate.text,toDate.text);
                    }
                  }
              ),
            ),
            customerInvoicesId == 1 ? Container(
              height: 50,
              child: StyledDropdown(
                  dataList: invoicesTypes,
                  type: "DefaultSetValue",
                  prefixText: "Invoices Type        ",
                  onChange: (value)async{
                    if(value != null){
                      invoicesTypesId= value["id"];
                      await fetchAccountMoveData(customerInvoicesId,invoicesTypesId,fromDate.text,toDate.text);
                    }
                  }
              ),
            ) : SizedBox(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    child: DatePickerFormField(
                        controller: fromDate,
                         label: "From Date",
                        isEnable: true,
                      onChanged: (value){
                        fetchAccountMoveData(customerInvoicesId,invoicesTypesId,fromDate.text,toDate.text);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    child: DatePickerFormField(
                        controller: toDate,
                        label: "To Date",
                        isEnable: true,
                      onChanged: (value){
                        fetchAccountMoveData(customerInvoicesId,invoicesTypesId,fromDate.text,toDate.text);
                      },
                    ),
                  ),
                ),
                IconButton(
                    onPressed: ()async{
                      setState(() {
                        toDate.text = "";
                        fromDate.text = "";
                      });
                      await fetchAccountMoveData(customerInvoicesId,invoicesTypesId,fromDate.text,toDate.text);
                   },
                    icon: Icon(Icons.close))
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.65,
              child: SfDataGrid(
                horizontalScrollController: _horizontalScroll,
                  selectionMode: SelectionMode.none,
                  source: dataSource,
                  columns: getColumns(),
                onCellTap: (DataGridCellTapDetails details) {
                  int rowIndex = details.rowColumnIndex.rowIndex;
                  if (rowIndex > 0) {}
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  getColumns(){
    columns = [
      GridColumn(
          columnName: "name",
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              color: Theme.of(context).primaryColor,
              alignment: Alignment.centerLeft,
              child: const Text(
                "Inv Number",
                style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white),
                softWrap: false,
              )
          )
      ),
      GridColumn(
          columnName: "status_in_payment",
          width: 100,
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              color: Theme.of(context).primaryColor,
              alignment: Alignment.center,
              child: const Text(
                "Status",
                style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white),
                softWrap: false,
              )
          )
      ),
      GridColumn(
          columnName: "formatted_invoice_date",
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          label: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              color: Theme.of(context).primaryColor,
              alignment: Alignment.centerLeft,
              child: const Text(
                "Inv Date",
                style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white),
                softWrap: false,
              )
          )
      ),
      GridColumn(
          columnName: "formatted_invoice_date_due",
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          label: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              color: Theme.of(context).primaryColor,
              alignment: Alignment.centerRight,
              child: const Text(
                "Inv Due Date",
                style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white),
                softWrap: false,
              )
          )
      ),
      GridColumn(
          columnName: "formatted_amount_total",
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              color: Theme.of(context).primaryColor,
              alignment: Alignment.center,
              child: const Text(
                "Total",
                style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white),
                softWrap: false,
              )
          )
      ),
    ];
    return columns;
  }
  Future<dynamic> fetchAccountMoveData(customerInvoicesId,invoicesTypesId,fromDate,toDate) async {
    try {
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const SyncDialog(message: "Downloading data from the server...", syncType: "download"),
        );
      }
      final pref = await SharedPreferences.getInstance();
      final userId = pref.getInt("user_Id");
      final password = pref.getString("password");
      if (userId == null || password == null) return "User credentials not found";
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
      if (fromDate != "" && toDate != "") {
        domain.addAll([
          ['invoice_date', '>=', fromDate],
          ['invoice_date', '<=', toDate],
        ]);
      } else if (fromDate != "") {
        domain.add(['invoice_date', '>=', fromDate]);
      } else if (toDate != "") {
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
              'id','name', 'invoice_date','invoice_date_due','amount_total', 'status_in_payment',
            ],
          },
        ],
      );

      loadedDataList = [];
      if (accountMoveData.isNotEmpty) {
        for (dynamic item in accountMoveData) {
          item["formatted_invoice_date"] = item["invoice_date"] == null || item["invoice_date"] == ''
              ? ""
              : formattedDate.format(DateTime.parse(item["invoice_date"]));

          item["formatted_invoice_date_due"] = item["invoice_date_due"] == null || item["invoice_date_due"] == ''
              ? ""
              : formattedDate.format(DateTime.parse(item["invoice_date_due"]));

          item["formatted_amount_total"] = item["amount_total"] == null
              ? '0.00'
              : numberFormatter.format(double.tryParse(item["amount_total"].toString()) ?? 0.0);

          String lable;
          Color? color;
           lable = item["status_in_payment"] == "not_paid" ? "Not Paid" :
           item["status_in_payment"] == "in_payment" ? "In Payment" :
           item["status_in_payment"] == "paid" ? "Paid" :
           item["status_in_payment"] == "partial" ? "Partially paid" :
           item["status_in_payment"] == "reversed" ? "Reversed" :
           item["status_in_payment"] == "blocked" ? "Blocked": "Invoicing App Legacy";

          color = item["status_in_payment"] == "not_paid" ? Colors.grey :
          item["status_in_payment"] == "in_payment" ? Colors.orange :
          item["status_in_payment"] == "paid" ? Colors.green :
          item["status_in_payment"] == "partial" ? Colors.orange :
          item["status_in_payment"] == "reversed" ? Colors.green :
          item["status_in_payment"] == "blocked" ? Colors.blue: Colors.amberAccent;

          item["status_in_payment"] =  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 20,
              width: 80,
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  lable,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          );


          loadedDataList.add(item);
        }
        dataSource = DataSource(loadedDataList: loadedDataList);
        setState(() {});
      } else {
        Navigator.pop(context);
        return [];
      }
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      print("Error in hhh: $e");
      return "Error: $e";
    }
  }

}
enum paymentStatusType {
  not_paid,
  in_payment,
  paid,
  partial,
  reversed,
  blocked,
  invoice_legacy
}
class DataSource extends DataGridSource {
  DataSource({required List loadedDataList}) {
    _employeeData = loadedDataList.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'name', value: e['name']),
      DataGridCell<Widget>(columnName: 'status_in_payment', value: e['status_in_payment']),
      DataGridCell<String>(columnName: 'formatted_invoice_date', value: e['formatted_invoice_date'].toString()),
      DataGridCell<String>(columnName: 'formatted_invoice_date_due', value:  e['formatted_invoice_date_due'].toString()),
      DataGridCell<String>(columnName: 'formatted_amount_total', value: e['formatted_amount_total']),

    ])).toList();
  }
  List<DataGridRow> _employeeData = [];
  List loadedDataList = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          if(e.columnName == "status_in_payment"){
            return e.value;
          }else if(e.columnName == "formatted_amount_total"){
            return Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(8.0),
              child: Text(e.value.toString(),overflow: TextOverflow.ellipsis,),
            );
          }else{
            return Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(8.0),
              child: Text(e.value.toString(),overflow: TextOverflow.ellipsis,),
            );
          }

        }).toList());
  }
}