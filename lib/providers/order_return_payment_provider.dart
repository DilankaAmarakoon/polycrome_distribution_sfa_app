import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../localDb/app_database.dart';
import '../reusableWidgets/showDialog.dart';

class OrderReturnPaymentProvider with ChangeNotifier {
  List<Map<String, dynamic>> showOrderProductValidData = [];
  List<Map<String, dynamic>> showReturnProductValidData = [];
  List<Map<String, dynamic>> showPaymentValidData = [];
  List<Map<String, dynamic>> showPaymentInvoicesDropData = [];

  int _patner_id = 0;
  int get patner_id => _patner_id;

  List<Map<String, dynamic>> _discountDataList = [];
  List<Map<String, dynamic>>  get discountDataList => _discountDataList;

  bool _isDiscountPress = false;
  bool get isDiscountPress => _isDiscountPress;
  bool _isFreeIssuePress = false;
  bool get isFreeIssuePress => _isFreeIssuePress;

  String  _outStandingState =  "";
  String get outStandingState => _outStandingState;

  void setOutStandingState(String outStandingState){
    _outStandingState = outStandingState;
    notifyListeners();
  }
  void setIsDiscountState(bool isDiscountPress){
    _isDiscountPress = isDiscountPress;
    notifyListeners();
  }
  void setIsFreeIssueState(bool isFreeIssuePress){
    _isFreeIssuePress = isFreeIssuePress;
    notifyListeners();
  }


  void setPartnerId(int value) {
    _patner_id = value;
    notifyListeners();
  }


  Future<void> fetchOrderProductValidData(int liternary_id, BuildContext context,fromPressDicountBtn) async {
    showOrderProductValidData = [];
    final AppDatabase dataBase = AppDatabase.instance;
    try {
      final List<JoinedProductUsage> list  = await dataBase.getDetailedOrderProductUsage(liternary_id);
      if(list.isNotEmpty){
        for(JoinedProductUsage  item in list){
          showOrderProductValidData.add(
              {
                "orderUsageTableId":item.id,
                "id" : item.product.id,
                "productId" : item.product.productId,
                "itinerary_id" : item.itineraryLineId,
                'adQty' : item.adQty,
                'productName': item.product.productName,
                "display_name":item.product.displayName,
                'salePrice': item.isFreeProduct ? 0.0 :item.product.salesPrice,
                'is_reward': item.is_reward,
                'isFreeProduct':item.isFreeProduct,
                'productCategoryId':item.product.productCategoryId,
                'is_discount_product':item.isDiscountProduct,
              }
          );
        }
      }
      if(_isDiscountPress){
        await checkAndCalculateDiscount(context,liternary_id,showOrderProductValidData,fromPressDicountBtn);
        final List<OrderProductUsageData> discountList  = await dataBase.getDiscountOrderProductUsage(liternary_id);
        if(discountList.isNotEmpty){
          for(OrderProductUsageData  item in discountList){
            showOrderProductValidData.add(
                {
                  "orderUsageTableId":item.id,
                  "id" : item.productId,
                  "productId" : item.productId,
                  "itinerary_id" : item.itineraryLineId,
                  'adQty' : item.adQty,
                  'productName':  item.displayDiscountProduct,
                  "display_name":item.displayDiscountProduct,
                  'salePrice': -item.discountProductPrice ,
                  'is_reward': item.is_reward,
                  'isFreeProduct':item.isFreeProduct,
                  'is_discount_product':item.isDiscountProduct,
                }
            );
          }
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
  checkAndCalculateDiscount(BuildContext context , liternary_Id, showOrderProductValidData, fromPressDicountBtn)async{
    AppDatabase.instance.deleteDiscountOrderProductUsage(liternary_Id);
    print("weer...${showOrderProductValidData}");
    Map<int, Map<String, dynamic>> groupedData = groupByCategoryIdWise(showOrderProductValidData);
    Map<String, Map<String, dynamic>> discountGroupMap = {};
    for (var data in groupedData.entries) {
      print("ccmm.${data.value}");
      final categoryId = data.value["products"][0]["productCategoryId"];
      final DiscountIds = await AppDatabase.instance.getCategoryDetailsByCategoryId(categoryId);

      print("DiscountIds..$DiscountIds");
      for (ProductCategoryData category in DiscountIds) {
        try {
          final ids = jsonDecode(category.itinerary_discount_ids);
          if (ids is List && ids.isNotEmpty) {
            data.value["itinerary_discount_ids"] = ids;
          }
        } catch (e) {
          print("Error decoding itinerary_discount_ids: $e");
        }
      }

      final discountIds = data.value["itinerary_discount_ids"];

      if (discountIds == null || !(discountIds is List) || discountIds.isEmpty) {
        print("Skipping categoryId $categoryId due to missing discount IDs.");
        continue;
      }

      final products = data.value["products"];
      final key = jsonEncode(discountIds);

      if (!discountGroupMap.containsKey(key)) {
        discountGroupMap[key] = {
          "products": [],
          "total": 0.0,
        };
      }

      for (var product in products) {
        final productId = product["productId"];
        bool isExcluded = false;


        for (var discountId in discountIds) {
          isExcluded = await AppDatabase.instance.isProductInNotList(
            discountId: discountId,
            productId: productId,
          );
          if (isExcluded) break;
        }

        if (isExcluded) {
          print("Excluded product: ${product["display_name"]} from discount IDs: $discountIds");
          continue;
        }

        double productTotal = (product["adQty"] ?? 0) * (product["salePrice"] ?? 0.0);
        discountGroupMap[key]!["products"].add(product);
        discountGroupMap[key]!["total"] += productTotal;
      }
    }
    discountGroupMap.forEach((discountKey, data) {
      print("Discount ID Group: $discountKey");
      print("Total Value: ${data['total']}");
      print("Products:");
      for (var product in data["products"]) {
        print("  - ${product['display_name']} | Qty: ${product['adQty']} | Price: ${product['salePrice']}");
      }
      print("------------------");
    });
    print("bbnn..${discountGroupMap.entries}");

    bool isAddedDisc = false;
    emptyDiscountList();
    for (var entry in discountGroupMap.entries) {
      // Decode the discount ID group string (like "[1,2]") to a List<int>
      List<int> discountIds;
      try {
        discountIds = (jsonDecode(entry.key) as List).cast<int>();
      } catch (e) {
        print("Invalid discount ID group key: ${entry.key}");
        continue;
      }

      double total = entry.value['total'];
      await fetchValiDiscountEligibleData(entry.key,  total);
      for (int discountId in discountIds) {
        final dataList = await AppDatabase.instance.getAllDiscountDataFilteredDiscountId(discountId);
        for (DiscountData item in dataList) {
          double min = item.minimum_amount;
          double max = item.maximum_amount;

          print("hj..$min");
          print("hj..$total");
          print("hj..$max");
          if (total >= min && total <= max) {
            isAddedDisc = true;
            double calDiscountPrice = (total*item.discount_percentage)/100;
            await AppDatabase.instance.insertOrderProductUsage(
                itineraryLineId: liternary_Id,
                productId: item.discount_product_id,
                adQty: 1,
                discountProductPrice: calDiscountPrice,
                displayDiscountProduct: item.discount_product_name,
                discountPercentage: item.discount_percentage,
                isDiscountProduct: true
            );
            print("✅ Free issue added for discountId: $discountId | product: ${item.discount_product_id}");
          }
        }
      }
    }
    if(!isAddedDisc & fromPressDicountBtn){
      await showConfirmationDialog(
        context,
        "No applicable discounts found for the current order lines and date",
        actionType: 'Ok',
      );
    }
    notifyListeners();
  }
  groupByCategoryIdWise(list) {
    Map<int, Map<String, dynamic>> groupedData = {};
    for (var item in list) {
      print("lop..${item["is_discount_product"]}");
      if (!item["is_discount_product"]) {
        int categoryId = item["productCategoryId"];
        double total = (item["adQty"] ?? 0) * (item["salePrice"] ?? 0.0);

        if (!groupedData.containsKey(categoryId)) {
          groupedData[categoryId] = {
            "products": [],
            "total": 0.0,
          };
        }

        groupedData[categoryId]!["products"].add(item);
        groupedData[categoryId]!["total"] += total;
      }
    }
    notifyListeners();
    return groupedData;
  }
  fetchValiDiscountEligibleData(
      discountId,total,
      )
  {
    final List<int> discountIdList = discountId is String
        ? List<int>.from(jsonDecode(discountId))
        : List<int>.from(discountId);

    for (int id in discountIdList) {
      _discountDataList.add({
        "discountId": id,
        "total": total,
      });
    }
    notifyListeners();
  }
  void emptyDiscountList() {
    _discountDataList = [];
    notifyListeners();
  }
  Future<void> fetchReturnProductValidData(int liternary_id) async {
    showReturnProductValidData = [];
    final AppDatabase dataBase = AppDatabase.instance;
    try {
      final List<JoinedReturnProductUsage> list  = await dataBase.getDetailedReturnProductUsage(liternary_id);
      if(list.isNotEmpty){
        for(JoinedReturnProductUsage  item in list){
          print("c${item.product.id}");
          showReturnProductValidData.add(
              { "id" : item.product.id,
                'adQty' : item.returnQty,
                'productName': item.product.productName,
                "display_name":item.product.displayName,
                'salePrice': item.product.salesPrice,
                'is_discount_product' :false,
                'is_reward' :false,
                'isFreeProduct' :false,
              }
          );

        }
      }
      notifyListeners();
      print("return produc valid length.${showReturnProductValidData.length}");

    } catch (e) {
      debugPrint("Error fetching product data 2: $e");
    }
  }
  Future<void> insertPaymentUsageData(int liternary_id) async {
    final AppDatabase dataBase = AppDatabase.instance;
    try {
      print("wanted.$liternary_id");
      final List<ItineraryPaymentLineData> list  = await dataBase.getItineraryPaymentLinesByPaymentLineId(liternary_id);
      if(list.isNotEmpty) {
        for (ItineraryPaymentLineData item in list) {
          final existingEntry = await dataBase.getPaymentUsageByUniqueKeys(
            itineraryPaymentLineId: item.id,
          );
          if (existingEntry == null) {
            await dataBase.insertPaymentUsageData(
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
          } else {
            print("Duplicate found for payment_line_id: ${item.payment_line_id}");
          }
        }

      }
      notifyListeners();
      print("return showPaymentValidData length.${showPaymentValidData.length}");

    } catch (e) {
      debugPrint("Error fetching product data 3: $e");
    }
  }
  Future<void> fetchPaymentValidData(int liternary_id) async {
    final AppDatabase dataBase = AppDatabase.instance;
    try {
      final List<PaymentUsageData> listPaymentUsage  = await dataBase.getAllPaymentUsageLinesPaymentLineId(liternary_id);
      if(listPaymentUsage.isNotEmpty){
        showPaymentValidData = [];

        for(PaymentUsageData  item in listPaymentUsage){

          print("oppkk..${item.invoice_amount}");
          showPaymentValidData.add(
              {
                "id" : item.id,
                'payment_line_id' : item.payment_line_id,
                'date': item.date,
                "invoice_id":item.invoice_id,
                "invoice_name":item.invoice_name,
                'invoice_date': item.invoice_date,
                'payment_method': item.payment_method,
                'cheque_number': item.cheque_number,
                'cheque_date': item.cheque_date,
                'amount': item.amount,
                'invoice_amount': item.invoice_amount,
                'isExciteOrNew': item.isExciteOrNew,
              }
          );
        }
      }else{
        showPaymentValidData = [];
      }
      notifyListeners();
      print("return showPaymentValidData length.${showPaymentValidData.length}");

    } catch (e) {
      debugPrint("Error fetching product data 4: $e");
    }
  }
  Future<void> fetchPaymentInvoicesDropData(int partnerId) async {
    final AppDatabase dataBase = AppDatabase.instance;
    try {
      final List<InvoicesData> list = await dataBase.getFilteredInvoices(partnerId: partnerId);
      if(list.isNotEmpty){
        showPaymentInvoicesDropData = [];
        for(InvoicesData  item in list){
          showPaymentInvoicesDropData.add(
              {
                "id": item.invoice_id,
                "partner_id" : item.partner_id,
                'name' : item.invoice_name,
                'invoice_date': item.invoice_date,
                "invoice_due_date":item.invoice_due_date,
                "invoice_amount":item.invoice_amount,
                "is_discount_product":item.invoice_amount,

              }
          );

        }
      }else{
        showPaymentInvoicesDropData = [];
      }
      notifyListeners();
      print("return showPaymentValidData length.${showPaymentInvoicesDropData.length}");

    } catch (e) {
      debugPrint("Error fetching product data 5: $e");
    }
  }
}