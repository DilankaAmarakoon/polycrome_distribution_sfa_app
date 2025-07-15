import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../localDb/app_database.dart';
import '../reusableWidgets/showDialog.dart';

class OrderReturnPaymentProvider with ChangeNotifier {
  final List<Map<String, dynamic>> showOrderProductValidData = [];
  final List<Map<String, dynamic>> showReturnProductValidData = [];
  final List<Map<String, dynamic>> showPaymentValidData = [];
  final List<Map<String, dynamic>> showPaymentInvoicesDropData = [];
  final List<Map<String, dynamic>> showReturnInvoicesDropData = [];
  final List<Map<String, dynamic>> showReturnTypeDropData = [];
  final List<Map<String, dynamic>> showReturnActionDropData = [];

  int _patner_id = 0;
  int get patner_id => _patner_id;

  final List<Map<String, dynamic>> _discountDataList = [];
  List<Map<String, dynamic>> get discountDataList => List.unmodifiable(_discountDataList);

  bool _isDiscountPress = false;
  bool get isDiscountPress => _isDiscountPress;
  bool _isFreeIssuePress = false;
  bool get isFreeIssuePress => _isFreeIssuePress;

  String _outStandingState = "";
  String get outStandingState => _outStandingState;

  int _returnInvoiceId = 0;
  int get returnInvoiceId => _returnInvoiceId;

  final AppDatabase _dataBase = AppDatabase.instance;

  void setOutStandingState(String outStandingState) {
    if (_outStandingState != outStandingState) {
      _outStandingState = outStandingState;
      notifyListeners();
    }
  }

  void setIsDiscountState(bool isDiscountPress) {
    if (_isDiscountPress != isDiscountPress) {
      _isDiscountPress = isDiscountPress;
      notifyListeners();
    }
  }

  void setIsFreeIssueState(bool isFreeIssuePress) {
    if (_isFreeIssuePress != isFreeIssuePress) {
      _isFreeIssuePress = isFreeIssuePress;
      notifyListeners();
    }
  }

  void setPartnerId(int value) {
    if (_patner_id != value) {
      _patner_id = value;
      notifyListeners();
    }
  }

  void setReturnInvoiceId(int value) {
    if (_returnInvoiceId != value) {
      _returnInvoiceId = value;
      notifyListeners();
    }
  }

  Future<void> fetchOrderProductValidData(int liternary_id, BuildContext context, bool fromPressDicountBtn) async {
    showOrderProductValidData.clear();
    try {
      final List<JoinedProductUsage> list = await _dataBase.getDetailedOrderProductUsage(liternary_id);
      if (list.isNotEmpty) {
        showOrderProductValidData.addAll(list.map((item) => {
          "orderUsageTableId": item.id,
          "id": item.product.id,
          "productId": item.product.productId,
          "itinerary_id": item.itineraryLineId,
          'adQty': item.adQty,
          'productName': item.product.productName,
          "display_name": item.product.displayName,
          'salePrice': item.isFreeProduct ? 0.0 : item.product.salesPrice,
          'is_reward': item.is_reward,
          'isFreeProduct': item.isFreeProduct,
          'productCategoryId': item.product.productCategoryId,
          'is_discount_product': item.isDiscountProduct,
        }));
      }
      if (_isDiscountPress) {
        await checkAndCalculateDiscount(context, liternary_id, showOrderProductValidData, fromPressDicountBtn);
        final List<OrderProductUsageData> discountList = await _dataBase.getDiscountOrderProductUsage(liternary_id);
        if (discountList.isNotEmpty) {
          showOrderProductValidData.addAll(discountList.map((item) => {
            "orderUsageTableId": item.id,
            "id": item.productId,
            "productId": item.productId,
            "itinerary_id": item.itineraryLineId,
            'adQty': item.adQty,
            'productName': item.displayDiscountProduct,
            "display_name": item.displayDiscountProduct,
            'salePrice': -item.discountProductPrice,
            'is_reward': item.is_reward,
            'isFreeProduct': item.isFreeProduct,
            'is_discount_product': item.isDiscountProduct,
          }));
        }
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching product data 1: $e");
    }
  }

  List<Map<String, dynamic>> convertMapEntryToList(Map<List<int>, Map<String, dynamic>> originalMap) {
    return originalMap.entries.map((entry) => entry.value).toList();
  }

  Future<void> checkAndCalculateDiscount(BuildContext context, int liternary_Id, List<Map<String, dynamic>> showOrderProductValidData, bool fromPressDicountBtn) async {
    await _dataBase.deleteDiscountOrderProductUsage(liternary_Id);
    final Map<int, Map<String, dynamic>> groupedData = groupByCategoryIdWise(showOrderProductValidData);
    final Map<String, Map<String, dynamic>> discountGroupMap = {};
    for (var data in groupedData.entries) {
      final categoryId = data.value["products"][0]["productCategoryId"];
      final DiscountIds = await _dataBase.getCategoryDetailsByCategoryId(categoryId);
      for (ProductCategoryData category in DiscountIds) {
        try {
          final ids = jsonDecode(category.itinerary_discount_ids);
          if (ids is List && ids.isNotEmpty) {
            data.value["itinerary_discount_ids"] = ids;
          }
        } catch (_) {}
      }
      final discountIds = data.value["itinerary_discount_ids"];
      if (discountIds == null || !(discountIds is List) || discountIds.isEmpty) {
        continue;
      }
      final products = data.value["products"];
      final key = jsonEncode(discountIds);
      discountGroupMap.putIfAbsent(key, () => {"products": [], "total": 0.0});
      for (var product in products) {
        final productId = product["productId"];
        bool isExcluded = false;
        for (var discountId in discountIds) {
          isExcluded = await _dataBase.isProductInNotList(discountId: discountId, productId: productId);
          if (isExcluded) break;
        }
        if (isExcluded) continue;
        double productTotal = (product["adQty"] ?? 0) * (product["salePrice"] ?? 0.0);
        discountGroupMap[key]!["products"].add(product);
        discountGroupMap[key]!["total"] += productTotal;
      }
    }
    bool isAddedDisc = false;
    emptyDiscountList();
    for (var entry in discountGroupMap.entries) {
      List<int> discountIds;
      try {
        discountIds = (jsonDecode(entry.key) as List).cast<int>();
      } catch (_) {
        continue;
      }
      double total = entry.value['total'];
      fetchValiDiscountEligibleData(entry.key, total);
      for (int discountId in discountIds) {
        final dataList = await _dataBase.getAllDiscountDataFilteredDiscountId(discountId);
        for (DiscountData item in dataList) {
          double min = item.minimum_amount;
          double max = item.maximum_amount;
          if (total >= min && total <= max) {
            isAddedDisc = true;
            double calDiscountPrice = (total * item.discount_percentage) / 100;
            await _dataBase.insertOrderProductUsage(
              itineraryLineId: liternary_Id,
              productId: item.discount_product_id,
              adQty: 1,
              discountProductPrice: calDiscountPrice,
              displayDiscountProduct: item.discount_product_name,
              discountPercentage: item.discount_percentage,
              isDiscountProduct: true,
            );
          }
        }
      }
    }
    if (!isAddedDisc && fromPressDicountBtn) {
      await showConfirmationDialog(
        context,
        "No applicable discounts found for the current order lines and date",
        actionType: 'Ok',
      );
    }
    notifyListeners();
  }

  Map<int, Map<String, dynamic>> groupByCategoryIdWise(List<Map<String, dynamic>> list) {
    final Map<int, Map<String, dynamic>> groupedData = {};
    for (var item in list) {
      if (!item["is_discount_product"]) {
        int categoryId = item["productCategoryId"];
        double total = (item["adQty"] ?? 0) * (item["salePrice"] ?? 0.0);
        groupedData.putIfAbsent(categoryId, () => {"products": [], "total": 0.0});
        groupedData[categoryId]!["products"].add(item);
        groupedData[categoryId]!["total"] += total;
      }
    }
    return groupedData;
  }

  void fetchValiDiscountEligibleData(dynamic discountId, double total) {
    final List<int> discountIdList = discountId is String
        ? List<int>.from(jsonDecode(discountId))
        : List<int>.from(discountId);
    for (int id in discountIdList) {
      _discountDataList.add({
        "discountId": id,
        "total": total,
      });
    }
  }

  void emptyDiscountList() {
    _discountDataList.clear();
  }

  Future<void> fetchReturnProductValidData(int liternary_id) async {
    showReturnProductValidData.clear();
    try {
      final List<JoinedReturnProductUsage> list = await _dataBase.getDetailedReturnProductUsage(liternary_id);
      if (list.isNotEmpty) {
        for (JoinedReturnProductUsage item in list) {
          String? returnType = await _dataBase.getReturnTypeNameById(item.return_reason_id);
          String? returnAction = await _dataBase.getReturnActionNameById(item.return_action_id);
          showReturnProductValidData.add({
            "id": item.product.id,
            'adQty': item.returnQty,
            'productId': item.product.productId,
            'productName': item.product.productName,
            "display_name": item.product.displayName,
            'salePrice': item.product.salesPrice,
            'remark': item.return_reason,
            'return_reason_id': item.return_reason_id,
            'return_action_id': item.return_action_id,
            'return_reason_name': returnType,
            'return_action_name': returnAction,
            'is_discount_product': false,
            'is_reward': false,
            'isFreeProduct': false,
            'isAddedInvoicesReturn': false,
          });
        }
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching product data 2: $e");
    }
  }

  Future<void> insertPaymentUsageData(int liternary_id) async {
    try {
      final List<ItineraryPaymentLineData> list = await _dataBase.getItineraryPaymentLinesByPaymentLineId(liternary_id);
      if (list.isNotEmpty) {
        for (ItineraryPaymentLineData item in list) {
          final existingEntry = await _dataBase.getPaymentUsageByUniqueKeys(
            itineraryPaymentLineId: item.id,
          );
          if (existingEntry == null) {
            await _dataBase.insertPaymentUsageData(
              itinerary_line_id: item.id,
              odooId: item.itinerary_line_id,
              paymentLineId: item.payment_line_id,
              date: item.date,
              invoiceId: item.invoice_id,
              invoice_name: item.invoice_name,
              invoiceDate: item.invoice_date,
              paymentMethod: item.payment_method,
              chequeDate: item.cheque_date!,
              chequeNumber: item.cheque_number!,
              amount: item.amount,
              invoice_amount: item.invoice_amount,
              isExciteOrNew: true,
            );
          }
        }
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching product data 3: $e");
    }
  }

  Future<void> fetchPaymentValidData(int liternary_id) async {
    try {
      final List<PaymentUsageData> listPaymentUsage = await _dataBase.getAllPaymentUsageLinesPaymentLineId(liternary_id);
      showPaymentValidData.clear();
      if (listPaymentUsage.isNotEmpty) {
        showPaymentValidData.addAll(listPaymentUsage.map((item) => {
          "id": item.id,
          'payment_line_id': item.payment_line_id,
          'date': item.date,
          "invoice_id": item.invoice_id,
          "invoice_name": item.invoice_name,
          'invoice_date': item.invoice_date,
          'payment_method': item.payment_method,
          'cheque_number': item.cheque_number,
          'cheque_date': item.cheque_date,
          'amount': item.amount,
          'invoice_amount': item.invoice_amount,
          'isExciteOrNew': item.isExciteOrNew,
        }));
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching product data 4: $e");
    }
  }

  Future<void> fetchPaymentInvoicesDropData(int partnerId) async {
    try {
      final List<InvoicesData> list = await _dataBase.getFilteredInvoices(partnerId: partnerId);
      showPaymentInvoicesDropData.clear();
      showReturnInvoicesDropData.clear();
      if (list.isNotEmpty) {
        for (InvoicesData item in list) {
          if (item.amount_residual != 0) {
            showPaymentInvoicesDropData.add({
              "id": item.invoice_id,
              "partner_id": item.partner_id,
              'name': item.invoice_name,
              'invoice_date': item.invoice_date,
              "invoice_due_date": item.invoice_due_date,
              "invoice_amount": item.invoice_amount,
              "is_discount_product": item.invoice_amount,
            });
          }
          if (item.payment_status == "not_paid" || item.payment_status == "partial") {
            showReturnInvoicesDropData.add({
              "id": item.invoice_id,
              'name': item.invoice_name,
            });
          }
        }
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching product data 5: $e");
    }
  }

  Future<bool> fetchReturnInvoicesLines(int invoiceId, int itineraryId, String invoiceName) async {
    final returnInvoicesList = await _dataBase.getReturnInvoicesByMoveId(invoiceId);
    try {
      if (returnInvoicesList.isNotEmpty) {
        await _dataBase.deleteReturnProductUsageByItinerary(itineraryId);
        for (ReturnInvoicesData item in returnInvoicesList) {
          final productMasterId = await _dataBase.getProductMasterTableId(item.productId);
          await _dataBase.addOrUpdateOrRemoveReturnProductUsageForInvoiceItems(
            itineraryLineId: itineraryId,
            productId: productMasterId!,
            returnQty: item.returnQty,
            return_reason: "Return from Invoice $invoiceName",
            invoiceSalesPrice: item.unitPrice,
            return_invoices_display_name: item.productDisplayName,
          );
        }
        notifyListeners();
        return true;
      } else {
        notifyListeners();
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> fetchReturnTypeAndActionDropData() async {
    try {
      final List<ReturnTypeData> returnTypeData = await _dataBase.getAllReturnTypeData();
      final List<ReturnActionData> returnActionData = await _dataBase.getAllReturnActionData();
      showReturnTypeDropData.clear();
      showReturnActionDropData.clear();
      if (returnTypeData.isNotEmpty) {
        showReturnTypeDropData.addAll(returnTypeData.map((item) => {
          "id": item.return_type_id,
          'name': item.return_type_name,
        }));
      }
      if (returnActionData.isNotEmpty) {
        showReturnActionDropData.addAll(returnActionData.map((item) => {
          "id": item.return_action_id,
          'name': item.return_action_name,
        }));
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching product data 5: $e");
    }
  }
}