import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

@DataClassName('SalesPersonData')
class SalesPersonDataOperations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get itinerary_line_id => integer()();
  IntColumn get partner_id => integer()();
  TextColumn get partner_name => text()();
  TextColumn get date => text()();
  TextColumn get route_code => text()();
  TextColumn get route_name => text()();
  RealColumn get cusOutstandingAmount => real()();
  RealColumn get itinerary_latitude => real().nullable()();
  RealColumn get itinerary_longitude => real().nullable()();
  TextColumn get visit_status => text().withDefault(const Constant(""))();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  BoolColumn get isVisited => boolean().withDefault(const Constant(false))();
}

@DataClassName('ProductMasterData')
class ProductMaster extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer()();
  TextColumn get productName => text()();
  TextColumn get displayName => text()();
  TextColumn get imageUrl => text()();
  RealColumn get salesPrice => real()();
  TextColumn get itemCode => text()();
  IntColumn get productCategoryId => integer().nullable()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  BoolColumn get is_discount_product => boolean()();
}

@DataClassName('OrderProductUsageData')
class OrderProductUsage extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get odooId => integer().withDefault(const Constant(0))();
  IntColumn get itineraryLineId => integer()();
  IntColumn get productId => integer()();
  BoolColumn get is_reward => boolean().withDefault(const Constant(false))();
  BoolColumn get isFreeProduct => boolean().withDefault(const Constant(false))();
  BoolColumn get isDiscountProduct => boolean().withDefault(const Constant(false))();
  TextColumn get displayDiscountProduct => text().withDefault(const Constant(""))();
  RealColumn get discountProductPrice => real().withDefault(const Constant(0.0))();
  RealColumn get discountPercentage => real().withDefault(const Constant(0.0))();
  IntColumn get stock_lot_id => integer().withDefault(const Constant(0))();
  RealColumn get reward_amount => real().withDefault(const Constant(0.0))();
  IntColumn get adQty => integer().withDefault(const Constant(0))();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

}

@DataClassName('ReturnProductUsageData')
class ReturnProductUsage extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get odooId => integer().withDefault(const Constant(0))();
  IntColumn get itineraryLineId => integer()();
  IntColumn get productId => integer()();
  TextColumn get return_reason => text().withDefault(const Constant(""))();
  TextColumn get return_invoices_display_name => text().withDefault(const Constant(""))();
  RealColumn get invoiceSalesPrice => real().withDefault(const Constant(0.0))();
  IntColumn get returnQty => integer().withDefault(const Constant(0))();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  IntColumn get return_reason_id => integer().withDefault(const Constant(0))();
  IntColumn get return_action_id => integer().withDefault(const Constant(0))();
  BoolColumn get isAddedInvoicesReturn => boolean().withDefault(const Constant(false))();

}

@DataClassName('ReturnInvoicesData')
class ReturnInvoices extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get move_id => integer()();
  IntColumn get account_move_line_id => integer()();
  IntColumn get productId => integer()();
  TextColumn get productDisplayName => text()();
  TextColumn get return_reason => text()();
  IntColumn get returnQty => integer()();
  RealColumn get unitPrice => real()();

}

@DataClassName('PaymentUsageData')
class PaymentUsage extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get odooId => integer().withDefault(const Constant(0))();
  IntColumn get payment_line_id => integer()();
  IntColumn get itinerary_line_id => integer()();
  TextColumn get date => text()();
  IntColumn get invoice_id => integer()();
  TextColumn get invoice_name => text()();
  TextColumn get invoice_date => text()();
  TextColumn get payment_method => text()();
  TextColumn get cheque_number => text().nullable()();
  TextColumn get cheque_date => text().nullable()();
  RealColumn get invoice_amount => real()();
  RealColumn get amount => real()();
  BoolColumn get isExciteOrNew => boolean().withDefault(const Constant(false))();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

@DataClassName('ProductCategoryData')
class ProductCategory extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer()();
  TextColumn get displayName => text()();
  TextColumn get itinerary_discount_ids => text()();


}
@DataClassName('ItineraryPaymentLineData')
class ItineraryPaymentLines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get payment_line_id => integer()();
  IntColumn get itinerary_line_id => integer()();
  TextColumn get date => text()();
  IntColumn get invoice_id => integer()();
  TextColumn get invoice_name => text()();
  TextColumn get invoice_date => text()();
  TextColumn get payment_method => text()();
  TextColumn get cheque_number => text().nullable()();
  TextColumn get cheque_date => text().nullable()();
  RealColumn get invoice_amount => real()();
  RealColumn get amount => real()();
}

@DataClassName('InvoicesData')
class InvoicesDataLines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get partner_id => integer()();
  IntColumn get invoice_id => integer()();
  TextColumn get invoice_name => text()();
  TextColumn get invoice_due_date => text()();
  TextColumn get invoice_date => text()();
  TextColumn get payment_status => text()();
  RealColumn get amount_residual => real()();
  TextColumn get move_type => text()();
  TextColumn get state => text()();
  RealColumn get invoice_amount => real()();

}

@DataClassName('VisitStatus')
class VisitStatusDataLines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get status_id => integer()();
  TextColumn get visitStatus => text()();

}
@DataClassName('LoyaltyFreeIssue')
class LoyaltyFreeIssueDataLines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer()();
  TextColumn get displayName => text()();
  IntColumn get minimumQty => integer()();
  IntColumn get stock_lot_id => integer()();
  IntColumn get reward_product_qty => integer()();

}

@DataClassName('DiscountData')
class DiscountDataOperations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get discount_id => integer()();
  TextColumn get name => text()();
  RealColumn get discount_percentage => real()();
  TextColumn get start_date => text()();
  TextColumn get end_date => text()();
  IntColumn get discount_product_id => integer()();
  TextColumn get discount_product_name => text()();
  BoolColumn get is_active => boolean()();
  RealColumn get minimum_amount => real()();
  RealColumn get maximum_amount => real()();
  TextColumn get not_issue_discount_products_ids => text()();
}

@DataClassName('ResPartnerData')
class ResPartnerDataOperations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get res_partner_id => integer()();
  TextColumn get name => text()();
  RealColumn get credit => real()();
  RealColumn get use_partner_credit_limit => real()();
  IntColumn get credit_period => integer()();
}

@DataClassName('ReturnTypeData')
class ReturnTypeDataOperations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get return_type_id => integer()();
  TextColumn get return_type_name => text()();
}

@DataClassName('ReturnActionData')
class ReturnActionDataOperations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get return_action_id => integer()();
  TextColumn get return_action_name => text()();
}

class JoinedProductUsage {
  final int id;
  final int odooId;
  final ProductMasterData product;
  final int adQty;
  final int itineraryLineId;
  final bool isSynced;
  final bool is_reward;
  final bool isFreeProduct;
  final bool isDiscountProduct;
  final String displayDiscountProduct;
  final double discountProductPrice;
  final double discountPercentage;
  final int  stock_lot_id;
  final double  reward_amount;



  JoinedProductUsage({
    required this.id,
    required this.odooId,
    required this.product,
    required this.adQty,
    required this.itineraryLineId,
    required this.isSynced,
    required this.is_reward,
    required this.isFreeProduct,
    required this.isDiscountProduct,
    required this.displayDiscountProduct,
    required this.discountProductPrice,
    required this.discountPercentage,
    required this.stock_lot_id,
    required this.reward_amount,
  });

  @override
  String toString() {
    return 'Product: \${product.productName}, Code: \${product.itemCode}, Price: \${product.salesPrice}, Qty: \$adQty, product_Id: \${product.productId} isSynced: \${product.isSynced}';
  }
}
class JoinedReturnProductUsage {
  final int id;
  final int odooId;
  final ProductMasterData product;
  final int productId;
  final int returnQty;
  final int itineraryLineId;
  final bool isSynced;
  final String return_reason;
  final int return_reason_id;
  final int return_action_id;
  final String return_invoices_display_name ;
  final double invoiceSalesPrice;
  final bool isAddedInvoicesReturn ;



  JoinedReturnProductUsage({
    required this.id,
    required this.odooId,
    required this.product,
    required this.returnQty,
    required this.productId,
    required this.itineraryLineId,
    required this.isSynced,
    required this.return_reason,
    required this.return_reason_id,
    required this.return_action_id,
    required this.return_invoices_display_name,
    required this.invoiceSalesPrice,
    required this.isAddedInvoicesReturn,

  });

  @override
  String toString() {
    return 'Product: \${product.productName}, Code: \${product.itemCode}, Price: \${product.salesPrice}, Qty: \$adQty, product_Id: \${product.productId} , isSynced: \${product.isSynced} ';

  }
}

@DriftDatabase(tables: [
  SalesPersonDataOperations,
  ProductMaster,
  OrderProductUsage,
  ReturnProductUsage,
  ReturnInvoices,
  ProductCategory,
  ItineraryPaymentLines,
  InvoicesDataLines,
  PaymentUsage,
  VisitStatusDataLines,
  LoyaltyFreeIssueDataLines,
  DiscountDataOperations,
  ResPartnerDataOperations,
  ReturnTypeDataOperations,
  ReturnActionDataOperations
])
class AppDatabase extends _$AppDatabase {
  AppDatabase._() : super(_openConnection());
  static final AppDatabase instance = AppDatabase._();

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        await m.addColumn(productMaster, productMaster.productId);
      }
      if (from < 3) {
        await m.createTable(returnProductUsage);
      }
    },
  );

  Future<int> insertIternaryData({
    required int itinerary_line_id,
    required String partner_name,
    required int partner_id,
    required String route_code,
    required String route_name,
    required double cusOutstandingAmount,
    required String date,
    required double itinerary_latitude,
    required double itinerary_longitude,
    required String visit_status,
  }) {
    return into(salesPersonDataOperations).insert(
      SalesPersonDataOperationsCompanion(
        itinerary_line_id: Value(itinerary_line_id),
        partner_name: Value(partner_name),
        partner_id: Value(partner_id),
        route_code: Value(route_code),
        route_name: Value(route_name),
        cusOutstandingAmount: Value(cusOutstandingAmount),
        date: Value(date),
        itinerary_latitude: Value(itinerary_latitude),
        itinerary_longitude: Value(itinerary_longitude),
        visit_status: Value(visit_status),
      ),
    );
  }

  Future<List<SalesPersonData>> getAllData() =>
      select(salesPersonDataOperations).get();
  Future<List<SalesPersonData>> getAllDataDataByItineraryLineId(int itineraryLineId) {
    return (select(salesPersonDataOperations)
      ..where((tbl) => tbl.itinerary_line_id.equals(itineraryLineId)))
        .get();
  }

  Future<List<SalesPersonData>> getUnsyncedData() =>
      (select(salesPersonDataOperations)..where((tbl) => tbl.isSynced.equals(false))).get();

  Future<void> markAsSynced(int id) async {
    await (update(salesPersonDataOperations)..where((tbl) => tbl.id.equals(id))).write(
      const SalesPersonDataOperationsCompanion(isSynced: Value(true)),
    );
  }

  Future<void> clearAllData() => delete(salesPersonDataOperations).go();
  Future<void> clearAllLoyaltyFreeIssueData() => delete(loyaltyFreeIssueDataLines).go();

  Future<int> insertProductMaster({
    required int productId,
    required String productName,
    required String imageUrl,
    required double salesPrice,
    required String itemCode,
    required String displayName,
    required int productCategoryId,
    required bool is_discount_product,
    bool isSynced = false,
  }

  ) {
    return into(productMaster).insert(
      ProductMasterCompanion(
        productId: Value(productId),
        productName: Value(productName),
        imageUrl: Value(imageUrl),
        salesPrice: Value(salesPrice),
        itemCode: Value(itemCode),
        displayName: Value(displayName),
        productCategoryId: Value(productCategoryId),
        is_discount_product: Value(is_discount_product),
        isSynced: Value(isSynced),
      ),
    );
  }

  Future<List<ProductMasterData>> getAllProductMaster() => select(productMaster).get();

  Future<void> clearProductMaster() => delete(productMaster).go();

  // Future<int?> addOrUpdateOrRemoveOrderProductUsage({
  //   required int itineraryLineId,
  //   required int productId,
  //   required int adQty,
  // }) async
  // {
  //   final existing = await (select(orderProductUsage)
  //     ..where((tbl) =>
  //     tbl.itineraryLineId.equals(itineraryLineId) &
  //     tbl.productId.equals(productId))).getSingleOrNull();
  //
  //   if (existing == null && adQty > 0) {
  //     print("Fffff");
  //     final insertedId = await into(orderProductUsage).insert(
  //       OrderProductUsageCompanion(
  //         itineraryLineId: Value(itineraryLineId),
  //         productId: Value(productId),
  //         adQty: Value(adQty),
  //       ),
  //     );
  //     return insertedId;
  //   } else if (existing != null && adQty > 0) {
  //     print("dddd");
  //     await (update(orderProductUsage)..where((tbl) => tbl.id.equals(existing.id)))
  //         .write(OrderProductUsageCompanion(adQty: Value(adQty)));
  //     return existing.id;
  //   } else if (existing != null && adQty == 0) {
  //     await (delete(orderProductUsage)..where((tbl) => tbl.id.equals(existing.id))).go();
  //     return null;
  //   }
  //   return null;
  // }
  Future<int?> addOrUpdateOrRemoveOrderProductUsage({
    required int itineraryLineId,
    required int productId,
    required int adQty,
  }) async
  {
    final existingList = await (select(orderProductUsage)
      ..where((tbl) =>
      tbl.itineraryLineId.equals(itineraryLineId) &
      tbl.productId.equals(productId)))
        .get();

    final existing = existingList.isNotEmpty ? existingList.first : null;

    // Insert if doesn't exist
    if (existing == null && adQty > 0) {
      final insertedId = await into(orderProductUsage).insert(
        OrderProductUsageCompanion(
          itineraryLineId: Value(itineraryLineId),
          productId: Value(productId),
          adQty: Value(adQty),
        ),
      );
      return insertedId;
    }

    // Update if exists and not a free product
    else if (existing != null && adQty > 0) {
      if (!existing.isFreeProduct) {
        await (update(orderProductUsage)
          ..where((tbl) => tbl.id.equals(existing.id)))
            .write(OrderProductUsageCompanion(adQty: Value(adQty)));
        updateFreeIssueOrderProductUsage(itineraryLineId: itineraryLineId, productId: productId, adQty: adQty);
      }
      return existing.id;
    }

    // Delete if adQty == 0
    else if (existing != null && adQty == 0) {
     await deleteOrderProductUsageByLineAndProduct(
        itineraryLineId: itineraryLineId,
        productId: existing.productId,
      );
      await (delete(orderProductUsage)
        ..where((tbl) => tbl.id.equals(existing.id))).go();

      ///jhgggggggggggggggggggggggggg
      return null;
    }

    return null;
  }

  Future<void> updateReturnRemarkFieldsByItineraryAndProduct({
    required int itineraryLineId,
    required int productId,
    String return_reason = "" ,
  }) async {

    final count = await (update(returnProductUsage)
      ..where((tbl) =>
      tbl.itineraryLineId.equals(itineraryLineId) &
      tbl.productId.equals(productId)))
        .write( ReturnProductUsageCompanion(
      return_reason: Value(return_reason),
    ),);

    print("✅ Updated $count row(s) in returnProductUsage");
  }
  Future<void> updateReturnReasonIdAndActionFieldsByItineraryAndProduct({
    required int itineraryLineId,
    required int productId,
    int return_reason_id = 0,
  }) async {

    final count = await (update(returnProductUsage)
      ..where((tbl) =>
      tbl.itineraryLineId.equals(itineraryLineId) &
      tbl.productId.equals(productId)))
        .write( ReturnProductUsageCompanion(
      return_reason_id: Value(return_reason_id),
    ),);

    print("✅ Updated $count row(s) in returnProductUsage");
  }

  Future<void> updateReturnActionIdAndActionFieldsByItineraryAndProduct({
    required int itineraryLineId,
    required int productId,
    int return_action_id =0,
  }) async {

    final count = await (update(returnProductUsage)
      ..where((tbl) =>
      tbl.itineraryLineId.equals(itineraryLineId) &
      tbl.productId.equals(productId)))
        .write( ReturnProductUsageCompanion(
      return_action_id: Value(return_action_id),
    ),);

    print("✅ Updated $count row(s) in returnProductUsage");
  }


  Future<int> insertOrderProductUsage({
    required int itineraryLineId,
    required int productId,
    int adQty = 1,
    bool isDiscountProduct = false,
    String displayDiscountProduct = "",
    double discountProductPrice = 0.0,
    double discountPercentage = 0.0,
  }) {
    return into(orderProductUsage).insert(
      OrderProductUsageCompanion(
        itineraryLineId: Value(itineraryLineId),
        productId: Value(productId),
        adQty: Value(adQty),
        isDiscountProduct: Value(isDiscountProduct),
        displayDiscountProduct: Value(displayDiscountProduct),
        discountProductPrice: Value(discountProductPrice),
        discountPercentage: Value(discountPercentage),
      ),
    );
  }

  // Future<int> insertReturnProductUsage({
  //   required int itineraryLineId,
  //   required int productId,
  //   required returnQty,
  //   String return_invoices_display_name = "",
  //   int odooId = 0,
  //   bool isSynced = false,
  //   String return_reason = "",
  //   double invoiceSalesPrice = 0.0,
  //   bool isAddedInvoicesReturn = false,
  // }) {
  //   return into(returnProductUsage).insert(
  //     ReturnProductUsageCompanion(
  //       itineraryLineId: Value(itineraryLineId),
  //       productId: Value(productId),
  //       returnQty: Value(returnQty),
  //       return_invoices_display_name: Value(return_invoices_display_name),
  //       odooId: Value(odooId),
  //       isSynced: Value(isSynced),
  //       return_reason: Value(return_reason),
  //       invoiceSalesPrice: Value(invoiceSalesPrice),
  //       isAddedInvoicesReturn: Value(isAddedInvoicesReturn),
  //     ),
  //   );
  // }


  Future<int>  addFreeIssueOrderProductUsage({
    required int itineraryLineId,
    required int productId,
    required int adQty,
    bool isReward = false,
    int stockLotId = 0,
    bool isFreeProduct = false,
    double? rewardAmount, // optional
  }) async
  {
    final product = await (select(productMaster)
      ..where((tbl) => tbl.id.equals(productId)))
        .getSingleOrNull();

    if (product == null) {
      throw Exception("Product with productId $productId not found");
    }

    final double finalRewardAmount = rewardAmount ?? product.salesPrice;

    final insertedId = await into(orderProductUsage).insert(
      OrderProductUsageCompanion(
        itineraryLineId: Value(itineraryLineId),
        productId: Value(productId),
        adQty: Value(adQty),
        is_reward: Value(isReward),
        isFreeProduct: Value(isFreeProduct),
        stock_lot_id: Value(stockLotId),
        reward_amount: Value(finalRewardAmount),
      ),
    );

    return insertedId;
  }



  Future<int?> getProductMasterTableId(int productId) async {
    final product = await (select(productMaster)
      ..where((tbl) => tbl.productId.equals(productId)))
        .getSingleOrNull();

    return product?.id;
  }
 Future<int?> updateFreeIssueOrderProductUsage({
    required int itineraryLineId,
    required int productId,
    required int adQty,
    bool isReward = true,
    bool isFreeProduct = true,
    double? rewardAmount,
  }) async {
    // Fetch the product
    final product = await (select(productMaster)
      ..where((tbl) => tbl.id.equals(productId)))
        .getSingleOrNull();

    if (product == null) {
      throw Exception("Product with productId $productId not found");
    }

    // Fetch existing free issue usage entry
    final existingList = await (select(orderProductUsage)
      ..where((tbl) =>
      tbl.itineraryLineId.equals(itineraryLineId) &
      tbl.productId.equals(productId) &
      tbl.isFreeProduct.equals(true)))
        .get();

    final existing = existingList.isNotEmpty ? existingList.first : null;

    if (existing == null) {
      // No free issue record found to update
      return null;
    }

    // Fetch reward rule for the product
    final rewardLine = await (select(loyaltyFreeIssueDataLines)
      ..where((tbl) => tbl.productId.equals(productId)))
        .getSingleOrNull();

    // Calculate final adQty based on reward rule
    int finalAdQty = adQty;
    if (rewardLine != null) {
      finalAdQty = adQty * rewardLine.reward_product_qty;
    }

    final double finalRewardAmount = rewardAmount ?? product.salesPrice;

    // Perform update
    await (update(orderProductUsage)
      ..where((tbl) => tbl.id.equals(existing.id)))
        .write(OrderProductUsageCompanion(
      adQty: Value(finalAdQty),
      is_reward: Value(isReward),
      isFreeProduct: Value(true),
      reward_amount: Value(finalRewardAmount),
    ));

    return existing.id;
  }






  Future<void> deleteOrderProductUsageByLineAndProduct({
    required int itineraryLineId,
    required int productId,
  }) async {
    await (delete(orderProductUsage)
      ..where((tbl) =>
      tbl.itineraryLineId.equals(itineraryLineId) &
      tbl.productId.equals(productId))).go();
  }

  Future<List<OrderProductUsageData>> getAllOrderProductUsage() {
    return select(orderProductUsage).get();
  }
  Future<List<OrderProductUsageData>> getDiscountOrderProductUsage(int itineraryLineId) {
    return (select(orderProductUsage)
      ..where((tbl) =>
      tbl.itineraryLineId.equals(itineraryLineId) &
      tbl.isDiscountProduct.equals(true)))
        .get();
  }
  Future<List<OrderProductUsageData>> getFreeIssueOrderProductUsage(int itineraryLineId) {
    return (select(orderProductUsage)
      ..where((tbl) =>
      tbl.itineraryLineId.equals(itineraryLineId) &
      tbl.isFreeProduct.equals(true)))
        .get();
  }
  Future<int> deleteDiscountOrderProductUsage(int itineraryLineId) {
    return (delete(orderProductUsage)
      ..where((tbl) =>
      tbl.itineraryLineId.equals(itineraryLineId) &
      tbl.isDiscountProduct.equals(true)))
        .go();
  }
  Future<List<JoinedProductUsage>> getDetailedOrderProductUsage(int itineraryLineId) async {
    final query = select(productMaster).join([
      innerJoin(
        orderProductUsage,
        orderProductUsage.productId.equalsExp(productMaster.id) &
        orderProductUsage.itineraryLineId.equals(itineraryLineId),
      )
    ]);
    final results = await query.get();

    return results.map((row) {
      final product = row.readTable(productMaster);
      final usage = row.readTable(orderProductUsage);
      return JoinedProductUsage(
          product: product,
          adQty: usage.adQty ,
          itineraryLineId:usage.itineraryLineId,
          id: usage.id,
          isSynced: usage.isSynced,
          odooId: usage.odooId,
          is_reward:usage.is_reward,
          isFreeProduct:usage.isFreeProduct,
          isDiscountProduct:usage.isDiscountProduct,
          displayDiscountProduct:usage.displayDiscountProduct,
          discountProductPrice:usage.discountProductPrice,
          discountPercentage:usage.discountPercentage,
          stock_lot_id:usage.stock_lot_id,
          reward_amount:usage.reward_amount,

      );
    }).toList();
  }

  Future<List<JoinedProductUsage>> getAllDetailedOrderProductUsage() async {
    final query = select(productMaster).join([
      innerJoin(
        orderProductUsage,
        orderProductUsage.productId.equalsExp(productMaster.id),
      )
    ]);

    final results = await query.get();

    return results.map((row) {
      final product = row.readTable(productMaster);
      final usage = row.readTable(orderProductUsage);
      return JoinedProductUsage(
        product: product,
        adQty: usage.adQty,
        itineraryLineId: usage.itineraryLineId,
        id: usage.id,
        isSynced: usage.isSynced,
        odooId: usage.odooId,
        is_reward: usage.is_reward,
        isFreeProduct: usage.isFreeProduct,
        isDiscountProduct: usage.isDiscountProduct,
        displayDiscountProduct: usage.displayDiscountProduct,
        discountProductPrice: usage.discountProductPrice,
        discountPercentage: usage.discountPercentage,
        stock_lot_id: usage.stock_lot_id,
        reward_amount: usage.reward_amount,
      );
    }).toList();
  }

  Future<List<JoinedReturnProductUsage>> getDetailedReturnProductUsage(int itineraryLineId) async {
    final query = select(productMaster).join([
      innerJoin(
        returnProductUsage,
        returnProductUsage.productId.equalsExp(productMaster.id) &
        returnProductUsage.itineraryLineId.equals(itineraryLineId),
      )
    ]);

    final results = await query.get();

    return results.map((row) {
      final product = row.readTable(productMaster);
      final usage = row.readTable(returnProductUsage);
      return JoinedReturnProductUsage(
        product: product,
        returnQty: usage.returnQty,
        productId: usage.productId,
        itineraryLineId: usage.itineraryLineId,
        id: usage.id,
        isSynced: usage.isSynced,
        odooId: usage.odooId,
        return_reason: usage.return_reason,
        return_reason_id: usage.return_reason_id,
        return_action_id: usage.return_action_id,
        return_invoices_display_name: usage.return_invoices_display_name,
        invoiceSalesPrice: usage.invoiceSalesPrice,
        isAddedInvoicesReturn: usage.isAddedInvoicesReturn,

      );
    }).toList();
  }
  Future<List<JoinedReturnProductUsage>> getDetailedInvoiceReturnProductUsage(int itineraryLineId) async {
    final query = select(productMaster).join([
      innerJoin(
        returnProductUsage,
        returnProductUsage.productId.equalsExp(productMaster.productId) &
        returnProductUsage.itineraryLineId.equals(itineraryLineId),
      )
    ]);

    final results = await query.get();

    return results.map((row) {
      final product = row.readTable(productMaster);
      final usage = row.readTable(returnProductUsage);
      return JoinedReturnProductUsage(
        product: product,
        returnQty: usage.returnQty,
        productId: usage.productId,
        itineraryLineId: usage.itineraryLineId,
        id: usage.id,
        isSynced: usage.isSynced,
        odooId: usage.odooId,
        return_reason: usage.return_reason,
        return_reason_id: usage.return_reason_id,
        return_action_id: usage.return_action_id,
        return_invoices_display_name: usage.return_invoices_display_name,
        invoiceSalesPrice: usage.invoiceSalesPrice,
        isAddedInvoicesReturn: usage.isAddedInvoicesReturn,
      );
    }).toList();
  }

  Future<List<JoinedReturnProductUsage>> getAllDetailedReturnProductUsage() async {
    final query = select(productMaster).join([
      innerJoin(
        returnProductUsage,
        returnProductUsage.productId.equalsExp(productMaster.id),
      )
    ]);

    final results = await query.get();

    return results.map((row) {
      final product = row.readTable(productMaster);
      final usage = row.readTable(returnProductUsage);
      return JoinedReturnProductUsage(
        product: product,
        returnQty: usage.returnQty,
        productId: usage.productId,
        itineraryLineId: usage.itineraryLineId,
        id: usage.id,
        isSynced: usage.isSynced,
        odooId: usage.odooId,
        return_reason:usage.return_reason,
        return_reason_id:usage.return_reason_id,
        return_action_id:usage.return_action_id,
        return_invoices_display_name: usage.return_invoices_display_name,
        invoiceSalesPrice: usage.invoiceSalesPrice,
        isAddedInvoicesReturn: usage.isAddedInvoicesReturn,
      );
    }).toList();
  }
  Future<List<JoinedReturnProductUsage>> getAllDetailedInvoiceReturnProductUsage() async {
    final query = select(productMaster).join([
      innerJoin(
        returnProductUsage,
        returnProductUsage.productId.equalsExp(productMaster.productId),
      )
    ]);

    final results = await query.get();

    return results.map((row) {
      final product = row.readTable(productMaster);
      final usage = row.readTable(returnProductUsage);
      return JoinedReturnProductUsage(
        product: product,
        returnQty: usage.returnQty,
        productId: usage.productId,
        itineraryLineId: usage.itineraryLineId,
        id: usage.id,
        isSynced: usage.isSynced,
        odooId: usage.odooId,
        return_reason:usage.return_reason,
        return_reason_id:usage.return_reason_id,
        return_action_id:usage.return_action_id,
        return_invoices_display_name: usage.return_invoices_display_name,
        invoiceSalesPrice: usage.invoiceSalesPrice,
        isAddedInvoicesReturn: usage.isAddedInvoicesReturn,
      );
    }).toList();
  }




  Future<void> clearOrderProductUsage() => delete(orderProductUsage).go();

  Future<int?> addOrUpdateOrRemoveReturnProductUsage({
    required int itineraryLineId,
    required int productId,
    required int returnQty,
  }) async
  {
    final existing = await (select(returnProductUsage)
      ..where((tbl) =>
      tbl.itineraryLineId.equals(itineraryLineId) &
      tbl.productId.equals(productId))).getSingleOrNull();

    if (existing == null && returnQty > 0) {
      final insertedId = await into(returnProductUsage).insert(
        ReturnProductUsageCompanion(
          itineraryLineId: Value(itineraryLineId),
          productId: Value(productId),
          returnQty: Value(returnQty),
        ),
      );
      return insertedId;
    } else if (existing != null && returnQty > 0) {
      await (update(returnProductUsage)..where((tbl) => tbl.id.equals(existing.id)))
          .write(ReturnProductUsageCompanion(returnQty: Value(returnQty)));
      return existing.id;
    } else if (existing != null && returnQty == 0) {
      await (delete(returnProductUsage)..where((tbl) => tbl.id.equals(existing.id))).go();
      return null;
    }
    return null;
  }
  Future<int?> addOrUpdateOrRemoveReturnProductUsageForInvoiceItems({
    required int itineraryLineId,
    required int productId,
    required int returnQty,
    double invoiceSalesPrice = 0.0,
    String return_invoices_display_name = "",
    String return_reason = "",
  }) async
  {
    // await deleteInvoiceReturnProductUsageByProductAndItinerary(itineraryLineId: itineraryLineId, returnInvoiceDeleteId:returnInvoiceDeleteId);
    final existing = await (select(returnProductUsage)
      ..where((tbl) =>
      tbl.itineraryLineId.equals(itineraryLineId) &
      tbl.productId.equals(productId)
      )).getSingleOrNull();

    if (existing == null && returnQty > 0) {
      final insertedId = await into(returnProductUsage).insert(
        ReturnProductUsageCompanion(
          itineraryLineId: Value(itineraryLineId),
          productId: Value(productId),
          returnQty: Value(returnQty),
          isAddedInvoicesReturn: const Value(true),
          invoiceSalesPrice: Value(invoiceSalesPrice),
          return_invoices_display_name: Value(return_invoices_display_name),
          return_reason: Value(return_reason),
        ),
      );
      return insertedId;
    } else if (existing != null && returnQty > 0) {
      await (update(returnProductUsage)
        ..where((tbl) => tbl.id.equals(existing.id)))
          .write(ReturnProductUsageCompanion(
        returnQty: Value(returnQty),
        invoiceSalesPrice: Value(invoiceSalesPrice),
        return_invoices_display_name: Value(return_invoices_display_name),
        return_reason: Value(return_reason),
      ));
      return existing.id;
    } else if (existing != null && returnQty == 0) {
      await (delete(returnProductUsage)
        ..where((tbl) => tbl.id.equals(existing.id))).go();
      return null;
    }

    return null;
  }


  Future<bool> deleteReturnProductUsageByLineAndProduct({
    required int itineraryLineId,
    required int productId,
  }) async {
    final deletedCount = await (delete(returnProductUsage)
      ..where((tbl) =>
      tbl.itineraryLineId.equals(itineraryLineId) &
      tbl.productId.equals(productId)))
        .go();

    return deletedCount > 0; // true if any row was deleted
  }


  Future<List<ReturnProductUsageData>> getInvoiceReturnProductUsageForItinerary(int itineraryLineId) {
    return (select(returnProductUsage)..where((tbl) =>
        tbl.itineraryLineId.equals(itineraryLineId)  &
        tbl.isAddedInvoicesReturn.equals(true))).get();
  }

  Future<int> deleteReturnProductUsageByItinerary(int itineraryLineId) {
    return (delete(returnProductUsage)..where((tbl) => tbl.itineraryLineId.equals(itineraryLineId))).go();
  }

  Future<void> clearReturnProductUsage() => delete(returnProductUsage).go();

  Future<int> insertCategory({
    required int categoryId,
    required String displayName,
    required String itinerary_discount_ids,
  }) {
    return into(productCategory).insert(
      ProductCategoryCompanion(
        categoryId: Value(categoryId),
        displayName: Value(displayName),
        itinerary_discount_ids: Value(itinerary_discount_ids),
      ),
      mode: InsertMode.insertOrReplace,
    );
  }
  Future<List<ProductCategoryData>> getCategoryDetailsByCategoryId(int categoryId) {
    return (select(productCategory)..where((tbl) => tbl.categoryId.equals(categoryId))).get();
  }


  Future<int> insertItineraryPaymentLine({
    required int paymentLineId,
    required int itinerary_line_id,
    required String date,
    required int invoiceId,
    required String invoice_name,
    required String invoiceDate,
    required String paymentMethod,
    required String chequeNumber,
    required String chequeDate,
    required double amount,
    required double invoice_amount,
  }) {
    return into(itineraryPaymentLines).insert(
      ItineraryPaymentLinesCompanion(
        payment_line_id: Value(paymentLineId),
        itinerary_line_id: Value(itinerary_line_id),
        date: Value(date),
        invoice_id: Value(invoiceId),
        invoice_name: Value(invoice_name),
        invoice_date: Value(invoiceDate),
        payment_method: Value(paymentMethod),
        cheque_number: Value(chequeNumber),
        cheque_date: Value(chequeDate),
        invoice_amount: Value(invoice_amount),
        amount: Value(amount),
      ),
    );
  }

  Future<void> clearAllItineraryPaymentLines() => delete(itineraryPaymentLines).go();
  Future<List<ItineraryPaymentLineData>> getAllItineraryPaymentLines() => select(itineraryPaymentLines).get();
  Future<List<ItineraryPaymentLineData>> getItineraryPaymentLinesByPaymentLineId(int paymentLineId) {
    return (select(itineraryPaymentLines)..where((tbl) => tbl.payment_line_id.equals(paymentLineId))).get();
  }

  Future<int> insertPaymentUsageData({
    required int paymentLineId,
    required int itinerary_line_id,
    required int odooId,
    required String date,
    required int invoiceId,
    required String invoice_name,
    required String invoiceDate,
    required String paymentMethod,
    required String chequeNumber,
    required String chequeDate,
    required double amount,
    required double invoice_amount,
    required bool isExciteOrNew,
  }) {
    return into(paymentUsage).insert(
      PaymentUsageCompanion(
        payment_line_id: Value(paymentLineId),
        itinerary_line_id: Value(itinerary_line_id),
        odooId: Value(odooId),
        date: Value(date),
        invoice_id: Value(invoiceId),
        invoice_name: Value(invoice_name),
        invoice_date: Value(invoiceDate),
        payment_method: Value(paymentMethod),
        cheque_number: Value(chequeNumber),
        cheque_date: Value(chequeDate),
        invoice_amount: Value(invoice_amount),
        amount: Value(amount),
        isExciteOrNew: Value(isExciteOrNew),
      ),
    );
  }

  Future<int> updatePaymentUsageData({
    required int id,
    required int paymentLineId,
    required int itinerary_line_id,
    required int itineraryPaymentLineId,
    required String date,
    required int invoiceId,
    required String invoiceName,
    required String invoiceDate,
    required String paymentMethod,
    required String chequeNumber,
    required String chequeDate,
    required double amount,
    required double invoiceAmount,
    required bool isSynced,
  }) {
    return (update(paymentUsage)
      ..where((tbl) =>
      tbl.payment_line_id.equals(paymentLineId) &
      tbl.id.equals(id)))
        .write(
      PaymentUsageCompanion(
        itinerary_line_id: Value(itinerary_line_id),
        date: Value(date),
        invoice_id: Value(invoiceId),
        invoice_name: Value(invoiceName),
        invoice_date: Value(invoiceDate),
        payment_method: Value(paymentMethod),
        cheque_number: Value(chequeNumber),
        cheque_date: Value(chequeDate),
        invoice_amount: Value(invoiceAmount),
        amount: Value(amount),
        isSynced: Value(isSynced),
      ),
    );
  }


  Future<PaymentUsageData?> getPaymentUsageByUniqueKeys({
    required int itineraryPaymentLineId,
  }) {
    final query = select(paymentUsage)
      ..where((tbl) =>
      tbl.itinerary_line_id.equals(itineraryPaymentLineId));
    return query.getSingleOrNull();
  }
  Future<void> deletePaymentUsageByPaymentLineIdIfNotExciteOrNew(int paymentLineId) {
    return (delete(paymentUsage)
      ..where((tbl) =>
      tbl.id.equals(paymentLineId) &
      tbl.isExciteOrNew.equals(false)))
        .go();
  }
  Future<void> clearAllPaymentUsageLines() => delete(paymentUsage).go();
  Future<List<PaymentUsageData>> getAllPaymentUsageLines() => select(paymentUsage).get();
  Future<List<PaymentUsageData>> getAllPaymentUsageLinesPaymentLineId(int paymentLineId) {
    return (select(paymentUsage)..where((tbl) => tbl.payment_line_id.equals(paymentLineId))).get();
  }
  //
  Future<int> insertReturnInvoiceData({
    required int move_id,
    required int accountMoveLineId,
    required int productId,
    required String productDisplayName,
    required String return_reason,
    required int returnQty,
    required double unitPrice,
  }) {
    return into(returnInvoices).insert(
      ReturnInvoicesCompanion(
        move_id: Value(move_id),
        account_move_line_id: Value(accountMoveLineId),
        productId: Value(productId),
        productDisplayName: Value(productDisplayName),
        return_reason: Value(return_reason),
        returnQty: Value(returnQty),
        unitPrice: Value(unitPrice),
      ),
    );
  }

  Future<int?> insertReturnProductUsage({
    required int itineraryLineId,
    String return_invoices_display_name = "",
    double invoiceSalesPrice = 0.0,
    required int productId,
    String return_reason = "",
    required int returnQty,
    bool isAddedInvoicesReturn = false,
  }) async {
    // Validate returnQty
    if (returnQty <= 0) {
      print("⚠️ Return quantity must be greater than 0.");
      return null;
    }

    // Join ProductMaster to get more product info

    final product = await (select(productMaster)
      ..where((tbl) => tbl.productId.equals(productId)))
        .getSingleOrNull();

    if (product == null) {
      print("❌ ProductMaster not found for productId: $productId");
      return null;
    }

    // Insert new record into ReturnProductUsage
    final insertedId = await into(returnProductUsage).insert(
        ReturnProductUsageCompanion(
          itineraryLineId: Value(itineraryLineId),
          return_invoices_display_name: Value(return_invoices_display_name),
          invoiceSalesPrice: Value(invoiceSalesPrice),
          productId: Value(productId),
          return_reason: Value(return_reason),
          returnQty: Value(returnQty),
          isAddedInvoicesReturn: Value(isAddedInvoicesReturn),
        ));

    print("✅ Inserted ReturnProductUsage: ID = $insertedId, productId = $productId");
    return insertedId;
  }
  Future<bool> deleteInvoiceReturnProductUsageByProductAndItinerary({
    required int itineraryLineId,
    required int returnInvoiceDeleteId,
  }) async {
    final deletedCount = await (delete(returnProductUsage)
      ..where((tbl) =>
      tbl.itineraryLineId.equals(itineraryLineId) &
      tbl.productId.equals(returnInvoiceDeleteId) &
      tbl.isAddedInvoicesReturn.equals(true)))
        .go();

    print("🗑️ Deleted $deletedCount returnProductUsage record(s) for productId: $returnInvoiceDeleteId, itineraryLineId: $itineraryLineId");

    return deletedCount > 0;
  }




  Future<void> clearAllReturnInvoiceDataLines() => delete(returnInvoices).go();
  Future<List<ReturnInvoicesData>> getAllReturnInvoiceDataLines() => select(returnInvoices).get();
  Future<List<ReturnInvoicesData>> getReturnInvoicesByMoveId(int moveId) {
    return (select(returnInvoices)..where((tbl) => tbl.move_id.equals(moveId))).get();
  }


  Future<int> insertInvoiceData({
    required int partnerId,
    required int invoice_id,
    required String invoiceName,
    required String invoiceDueDate,
    required String invoiceDate,
    required String paymentStatus,
    required double amount_residual,
    required String moveType,
    required String state,
    required double invoice_amount,
  }) {
    return into(invoicesDataLines).insert(
      InvoicesDataLinesCompanion(
        partner_id: Value(partnerId),
        invoice_id: Value(invoice_id),
        invoice_name: Value(invoiceName),
        invoice_due_date: Value(invoiceDueDate),
        invoice_date: Value(invoiceDate),
        payment_status: Value(paymentStatus),
        amount_residual: Value(amount_residual),
        move_type: Value(moveType),
        state: Value(state),
        invoice_amount: Value(invoice_amount),
      ),
    );
  }
  Future<int> insertResPartnerData({
    required int resPartnerId,
    required String name,
    required double credit,
    required double credit_limit,
    required int creditPeriod,
  }) {
    return into(resPartnerDataOperations).insert(
      ResPartnerDataOperationsCompanion(
        res_partner_id: Value(resPartnerId),
        name: Value(name),
        credit: Value(credit),
        use_partner_credit_limit: Value(credit_limit),
        credit_period: Value(creditPeriod),
      ),
    );
  }

  Future<void> clearAllResPartnerDataLines() => delete(resPartnerDataOperations).go();
  Future<List<ResPartnerData>> getAllResPartnerDataLinesFilteredPartnerId(int partnerId) {
    return (select(resPartnerDataOperations)..where((tbl) => tbl.res_partner_id.equals(partnerId))).get();
  }

  Future<int> insertVisitStatus({
    required int statusId,
    required String visitStatus,
  }) {
    return into(visitStatusDataLines).insert(
      VisitStatusDataLinesCompanion(
        status_id: Value(statusId),
        visitStatus: Value(visitStatus),
      ),
    );
  }

  Future<void> clearAllVisitStatusData() => delete(visitStatusDataLines).go();
  Future<List<VisitStatus>> getAllVisitStatusData() => select(visitStatusDataLines).get();
  Future<void> clearAllInvoiceDataLines() => delete(invoicesDataLines).go();
  Future<List<InvoicesData>> getAllInvoiceDataLines() => select(invoicesDataLines).get();
  Future<List<InvoicesData>> getFilteredInvoices({
    required int partnerId,
  }) {
    return (select(invoicesDataLines)
      ..where((tbl) =>
      tbl.partner_id.equals(partnerId)))
        .get();
  }




  Future<List<ProductCategoryData>> getAllCategories() => select(productCategory).get();

  Future<void> clearAllCategories() => delete(productCategory).go();

  Future<void> closeDb() async => close();

  Future<int> insertReturnTypeData({
    required int returnTypeId,
    required String returnTypeName,
  }) {
    return into(returnTypeDataOperations).insert(
      ReturnTypeDataOperationsCompanion(
        return_type_id: Value(returnTypeId),
        return_type_name: Value(returnTypeName),
      ),
    );
  }

  // ReturnTypeData by return_type_id
  Future<String?> getReturnTypeNameById(int id) async {
    final result = await (select(returnTypeDataOperations)
      ..where((tbl) => tbl.return_type_id.equals(id)))
        .getSingleOrNull();

    return result?.return_type_name;
  }

// ReturnActionData by return_action_id

  Future<String?> getReturnActionNameById(int id) async {
    return (await (select(returnActionDataOperations)
      ..where((tbl) => tbl.return_action_id.equals(id)))
        .getSingleOrNull())
        ?.return_action_name;
  }

  Future<List<ReturnTypeData>> getAllReturnTypeData() => select(returnTypeDataOperations).get();
  Future<void> clearAllReturnTypeData() => delete(returnTypeDataOperations).go();

  Future<int> insertReturnActionData({
    required int returnActionId,
    required String returnActionName,
  }) {
    return into(returnActionDataOperations).insert(
      ReturnActionDataOperationsCompanion(
        return_action_id: Value(returnActionId),
        return_action_name: Value(returnActionName),
      ),
    );
  }

  Future<List<ReturnActionData>> getAllReturnActionData() => select(returnActionDataOperations).get();
  Future<void> clearAllReturnActionData() => delete(returnActionDataOperations).go();


  Future<int> insertLoyaltyFreeIssueData({
    required int productId,
    required String displayName,
    required int minimumQty,
    required int stockLotId,
    required int rewardProductQty,
  }) {
    return into(loyaltyFreeIssueDataLines).insert(
      LoyaltyFreeIssueDataLinesCompanion(
        productId: Value(productId),
        displayName: Value(displayName),
        minimumQty: Value(minimumQty),
        stock_lot_id: Value(stockLotId),
        reward_product_qty: Value(rewardProductQty),
      ),
    );
  }

  Future<int> insertDiscountData({
    required int discount_id,
    required String name,
    required double discount_percentage,
    required String start_date,
    required String end_date,
    required int discount_product_id,
    required String discount_product_name,
    required bool is_active,
    required double minimum_amount,
    required double maximum_amount,
    required String not_issue_discount_products_ids,
  }) {
    return into(discountDataOperations).insert(
      DiscountDataOperationsCompanion(
        discount_id: Value(discount_id),
        name: Value(name),
        discount_percentage: Value(discount_percentage),
        start_date: Value(start_date),
        end_date: Value(end_date),
        discount_product_id: Value(discount_product_id),
        discount_product_name: Value(discount_product_name),
        is_active: Value(is_active),
        minimum_amount: Value(minimum_amount),
        maximum_amount: Value(maximum_amount),
        not_issue_discount_products_ids: Value(not_issue_discount_products_ids),
      ),
    );
  }
  Future<List<DiscountData>> getAllDiscountData() => select(discountDataOperations).get();
  Future<void> clearAllDiscountData() => delete(discountDataOperations).go();
  Future<bool> isProductInNotList({
    required int discountId,
    required int productId,
  }) async
  {
    print("dfff.$discountId");
    print("ssss.$productId");
    final discount = await (select(discountDataOperations)
      ..where((tbl) => tbl.discount_id.equals(discountId)))
        .getSingleOrNull();
    print("mkoll.$discount");

    if (discount == null) {
      return false;
    }

    try {
      final List<dynamic> ids = jsonDecode(discount.not_issue_discount_products_ids);
      return ids.contains(productId);
    } catch (e) {
      print("Error decoding not_issue_discount_products_ids: $e");
      return false;
    }
  }

  Future<List<DiscountData>> getAlCategoryData() => select(discountDataOperations).get();
  Future<List<DiscountData>> getAllDiscountDataFilteredDiscountId(int discountId) {
    return (select(discountDataOperations)..where((tbl) => tbl.discount_id.equals(discountId))).get();
  }


  Future<List<LoyaltyFreeIssue>> getAllLoyaltyFreeIssueData() => select(loyaltyFreeIssueDataLines).get();

  //update isSynced = True orderProductUsage
  Future<void> updateIsSyncedTrueAndOdooIdOrderProductUsage({
    required int id,
    dynamic odooId,
  }) async {
    // Get current row
    final existing = await (select(orderProductUsage)
      ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();

    if (existing == null) {
      print("Row with id $id not found.");
      return;
    }

    final shouldUpdateOdooId = odooId is int && existing.odooId != odooId;

    final companion = shouldUpdateOdooId
        ? OrderProductUsageCompanion(
      isSynced: const Value(true),
      odooId: Value(odooId),
    )
        : OrderProductUsageCompanion(
      isSynced: const Value(true),
    );

    final count = await (update(orderProductUsage)
      ..where((tbl) => tbl.id.equals(id)))
        .write(companion);

    print("Updated rows in orderProductUsage: $count");
  }


  //update isSynced = True returnProductUsage
  Future<void> updateIsSyncedTrueAndOdooIdReturnProductUsage({
    required int id,
    dynamic odooId,
  }) async {
    final existing = await (select(returnProductUsage)
      ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();

    if (existing == null) {
      print("Row with id $id not found in returnProductUsage.");
      return;
    }

    final shouldUpdateOdooId = odooId is int && existing.odooId != odooId;

    final companion = shouldUpdateOdooId
        ? ReturnProductUsageCompanion(
      isSynced: const Value(true),
      odooId: Value(odooId),
    )
        : ReturnProductUsageCompanion(
      isSynced: const Value(true),
    );

    // Perform update
    final count = await (update(returnProductUsage)
      ..where((tbl) => tbl.id.equals(id)))
        .write(companion);

    print("Updated rows in returnProductUsage: $count");
  }


  //update isSynced = false orderProductUsage
  Future<void> updateFalseIsSyncedOrderProductUsage({
    required int id,
  }) async {
    final count = await (update(orderProductUsage)
      ..where((tbl) => tbl.id.equals(id)))
        .write( OrderProductUsageCompanion(
      isSynced: Value(false),
    ));
    print("Updated rows in orderProductUsage: $count");
  }

  Future<int> updateIsRewarded({
    required int id, // or use itineraryLineId + productId if preferred
    required bool isReward,
  }) async {
    return (update(orderProductUsage)
      ..where((tbl) => tbl.id.equals(id))) // filter condition
        .write(
      OrderProductUsageCompanion(
        is_reward: Value(isReward),
      ),
    );
  }

  //update isSynced = false returnProductUsage
  Future<void> updateFalseIsSyncedReturnProductUsage({required int id}) async {
    final count = await (update(returnProductUsage)
      ..where((tbl) => tbl.id.equals(id)))
        .write(const ReturnProductUsageCompanion(
      isSynced: Value(false),
    ));
    print("Updated rows in orderProductUsage: $count");
  }

  //update isSynced = true paymentProductUsage
  Future<void> updateIsSyncedTrueAndOdooIdPaymentProductUsage({
    required int id,
    required bool isSynced,
    dynamic odooId,
  }) async {
    final existing = await (select(paymentUsage)
      ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();

    if (existing == null) {
      print("Row with id $id not found in paymentUsage.");
      return;
    }

    final shouldUpdateOdooId = odooId is int && odooId != 0 && existing.odooId != odooId;

    final companion = shouldUpdateOdooId
        ? PaymentUsageCompanion(
      isSynced: Value(isSynced),
      odooId: Value(odooId),
    )
        : PaymentUsageCompanion(
      isSynced: Value(isSynced),
    );

    final count = await (update(paymentUsage)
      ..where((tbl) => tbl.id.equals(id)))
        .write(companion);

    print("Updated rows in paymentUsage: $count");
  }

  //update  isVisited  SalesPersonData
  Future<int>  updateIsVisitedSalesPersonData({
    required int itinerary_line_id,
    required bool isVisited,
  }) {
    return (update(salesPersonDataOperations)..where((tbl) => tbl.itinerary_line_id.equals(itinerary_line_id)))
        .write(SalesPersonDataOperationsCompanion(
      isVisited: Value(isVisited),
    ));
  }

  //update isSynced   SalesPersonData
  Future<int>  updateIsSyncedSalesPersonData({
    required int itinerary_line_id,
    required bool isSynced,
  }) {
    return (update(salesPersonDataOperations)..where((tbl) => tbl.itinerary_line_id.equals(itinerary_line_id)))
        .write(SalesPersonDataOperationsCompanion(
      isSynced: Value(isSynced),
    ));
  }

  Future<List<SalesPersonData>> getVisitedSalesPersonData() {
    return (select(salesPersonDataOperations)
      ..where((tbl) => tbl.isVisited.equals(true)))
        .get();
  }

  //update location  SalesPersonData
  Future<int>  updateLocationSalesPersonData({
    required int itinerary_line_id,
     double itinerary_latitude = 0.0,
     double itinerary_longitude = 0.0,
     String visitStatus = "",
  }) {
    return (update(salesPersonDataOperations)..where((tbl) => tbl.itinerary_line_id.equals(itinerary_line_id)))
        .write(SalesPersonDataOperationsCompanion(
      itinerary_latitude: Value(itinerary_latitude),
      itinerary_longitude: Value(itinerary_longitude),
      visit_status: Value(visitStatus),
    ));
  }

  //update visit Status   SalesPersonData
  Future<int>  updateVisitStatusSalesPersonData({
    required int itinerary_line_id,
    required String visit_status,
  }) {
    return (update(salesPersonDataOperations)..where((tbl) => tbl.itinerary_line_id.equals(itinerary_line_id)))
        .write(SalesPersonDataOperationsCompanion(
      visit_status: Value(visit_status),
    ));
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'sales_person.db'));
    return NativeDatabase(file);
  });
}
