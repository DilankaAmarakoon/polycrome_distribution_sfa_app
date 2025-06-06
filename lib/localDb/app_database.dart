import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

/// Table for sales person itinerary lines data
@DataClassName('SalesPersonData')
class SalesPersonDataOperations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get itinerary_line_id => integer()();
  TextColumn get partner_name => text()();
  TextColumn get date => text()();
  TextColumn get route_code => text()();
  TextColumn get route_name => text()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

/// Table for product master data
@DataClassName('ProductMasterData')
class ProductMaster extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get productName => text()();
  TextColumn get imageUrl => text()();
  RealColumn get salesPrice => real()();
  TextColumn get itemCode => text()();
}

/// Table for product usage linked with itinerary lines
@DataClassName('ProductUsageData')
class ProductUsage extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get itineraryLineId => integer()();
  IntColumn get productId => integer()();
  IntColumn get adQty => integer().withDefault(const Constant(0))();
}

/// Helper class to join ProductMaster and ProductUsage data
class JoinedProductUsage {
  final ProductMasterData product;
  final int adQty;

  JoinedProductUsage({required this.product, required this.adQty});

  @override
  String toString() {
    return 'Product: ${product.productName}, Code: ${product.itemCode}, Price: ${product.salesPrice}, Qty: $adQty, product_Id: ${product.id}';
  }
}

@DriftDatabase(tables: [SalesPersonDataOperations, ProductMaster, ProductUsage])
class AppDatabase extends _$AppDatabase {
  // Singleton pattern for database instance
  AppDatabase._() : super(_openConnection());
  static final AppDatabase instance = AppDatabase._();

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // Handle database schema migrations if needed in the future
    },
  );

  // CRUD operations for SalesPersonDataOperations table

  Future<int> insertIternaryData({
    required int itinerary_line_id,
    required String partner_name,
    required String route_code,
    required String route_name,
    required String date,
  }) {
    return into(salesPersonDataOperations).insert(
      SalesPersonDataOperationsCompanion(
        itinerary_line_id: Value(itinerary_line_id),
        partner_name: Value(partner_name),
        route_code: Value(route_code),
        route_name: Value(route_name),
        date: Value(date),
      ),
    );
  }

  Future<List<SalesPersonData>> getAllData() => select(salesPersonDataOperations).get();

  Future<List<SalesPersonData>> getUnsyncedData() =>
      (select(salesPersonDataOperations)..where((tbl) => tbl.isSynced.equals(false))).get();

  Future<void> markAsSynced(int id) async {
    await (update(salesPersonDataOperations)..where((tbl) => tbl.id.equals(id))).write(
      const SalesPersonDataOperationsCompanion(isSynced: Value(true)),
    );
  }

  Future<void> clearAllData() => delete(salesPersonDataOperations).go();

  // CRUD operations for ProductMaster table

  Future<int> insertProductMaster({
    required String productName,
    required String imageUrl,
    required double salesPrice,
    required String itemCode,
  }) {
    return into(productMaster).insert(
      ProductMasterCompanion(
        productName: Value(productName),
        imageUrl: Value(imageUrl),
        salesPrice: Value(salesPrice),
        itemCode: Value(itemCode),
      ),
    );
  }

  Future<List<ProductMasterData>> getAllProductMaster() => select(productMaster).get();

  Future<void> clearProductMaster() => delete(productMaster).go();

  // CRUD operations for ProductUsage table

  Future<void> addOrUpdateOrRemoveProductUsage({
    required int itineraryLineId,
    required int productId,
    required int adQty,
  }) async {
    final existing = await (select(productUsage)
      ..where((tbl) =>
      tbl.itineraryLineId.equals(itineraryLineId) & tbl.productId.equals(productId)))
        .getSingleOrNull();

    if (existing == null && adQty > 0) {
      // Insert new if not exists and qty > 0
      await into(productUsage).insert(
        ProductUsageCompanion(
          itineraryLineId: Value(itineraryLineId),
          productId: Value(productId),
          adQty: Value(adQty),
        ),
      );
    } else if (existing != null && adQty > 0) {
      // Update if exists and qty > 0
      await (update(productUsage)..where((tbl) => tbl.id.equals(existing.id)))
          .write(ProductUsageCompanion(adQty: Value(adQty)));
    } else if (existing != null && adQty == 0) {
      // Delete if exists and qty == 0
      await (delete(productUsage)..where((tbl) => tbl.id.equals(existing.id))).go();
    }
  }

  Future<List<ProductUsageData>> getProductUsageForItinerary(int itineraryLineId) async {
    return (select(productUsage)..where((tbl) => tbl.itineraryLineId.equals(itineraryLineId))).get();
  }

  /// Gets detailed joined data of products and their usage quantities for a given itinerary line
  Future<List<JoinedProductUsage>> getDetailedProductUsageForItinerary(int itineraryLineId) async {
    final query = select(productMaster).join([
      innerJoin(
        productUsage,
        productUsage.productId.equalsExp(productMaster.id) &
        productUsage.itineraryLineId.equals(itineraryLineId),
      )
    ]);

    final results = await query.get();

    return results.map((row) {
      final product = row.readTable(productMaster);
      final usage = row.readTable(productUsage);
      return JoinedProductUsage(product: product, adQty: usage.adQty);
    }).toList();
  }

  Future<void> updateAdQty(int usageId, int newQty) async {
    await (update(productUsage)..where((tbl) => tbl.id.equals(usageId)))
        .write(ProductUsageCompanion(adQty: Value(newQty)));
  }

  Future<void> clearProductUsage() => delete(productUsage).go();

  Future<void> closeDb() async => close();
}

/// Opens the database connection, using application documents directory
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'sales_person.db'));
    return NativeDatabase(file);
  });
}
