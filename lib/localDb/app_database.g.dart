// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SalesPersonDataOperationsTable extends SalesPersonDataOperations
    with TableInfo<$SalesPersonDataOperationsTable, SalesPersonData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesPersonDataOperationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _itinerary_line_idMeta = const VerificationMeta(
    'itinerary_line_id',
  );
  @override
  late final GeneratedColumn<int> itinerary_line_id = GeneratedColumn<int>(
    'itinerary_line_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _partner_nameMeta = const VerificationMeta(
    'partner_name',
  );
  @override
  late final GeneratedColumn<String> partner_name = GeneratedColumn<String>(
    'partner_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _route_codeMeta = const VerificationMeta(
    'route_code',
  );
  @override
  late final GeneratedColumn<String> route_code = GeneratedColumn<String>(
    'route_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _route_nameMeta = const VerificationMeta(
    'route_name',
  );
  @override
  late final GeneratedColumn<String> route_name = GeneratedColumn<String>(
    'route_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    itinerary_line_id,
    partner_name,
    date,
    route_code,
    route_name,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales_person_data_operations';
  @override
  VerificationContext validateIntegrity(
    Insertable<SalesPersonData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('itinerary_line_id')) {
      context.handle(
        _itinerary_line_idMeta,
        itinerary_line_id.isAcceptableOrUnknown(
          data['itinerary_line_id']!,
          _itinerary_line_idMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_itinerary_line_idMeta);
    }
    if (data.containsKey('partner_name')) {
      context.handle(
        _partner_nameMeta,
        partner_name.isAcceptableOrUnknown(
          data['partner_name']!,
          _partner_nameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_partner_nameMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('route_code')) {
      context.handle(
        _route_codeMeta,
        route_code.isAcceptableOrUnknown(data['route_code']!, _route_codeMeta),
      );
    } else if (isInserting) {
      context.missing(_route_codeMeta);
    }
    if (data.containsKey('route_name')) {
      context.handle(
        _route_nameMeta,
        route_name.isAcceptableOrUnknown(data['route_name']!, _route_nameMeta),
      );
    } else if (isInserting) {
      context.missing(_route_nameMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SalesPersonData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SalesPersonData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      itinerary_line_id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}itinerary_line_id'],
          )!,
      partner_name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}partner_name'],
          )!,
      date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}date'],
          )!,
      route_code:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}route_code'],
          )!,
      route_name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}route_name'],
          )!,
      isSynced:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_synced'],
          )!,
    );
  }

  @override
  $SalesPersonDataOperationsTable createAlias(String alias) {
    return $SalesPersonDataOperationsTable(attachedDatabase, alias);
  }
}

class SalesPersonData extends DataClass implements Insertable<SalesPersonData> {
  final int id;
  final int itinerary_line_id;
  final String partner_name;
  final String date;
  final String route_code;
  final String route_name;
  final bool isSynced;
  const SalesPersonData({
    required this.id,
    required this.itinerary_line_id,
    required this.partner_name,
    required this.date,
    required this.route_code,
    required this.route_name,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['itinerary_line_id'] = Variable<int>(itinerary_line_id);
    map['partner_name'] = Variable<String>(partner_name);
    map['date'] = Variable<String>(date);
    map['route_code'] = Variable<String>(route_code);
    map['route_name'] = Variable<String>(route_name);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  SalesPersonDataOperationsCompanion toCompanion(bool nullToAbsent) {
    return SalesPersonDataOperationsCompanion(
      id: Value(id),
      itinerary_line_id: Value(itinerary_line_id),
      partner_name: Value(partner_name),
      date: Value(date),
      route_code: Value(route_code),
      route_name: Value(route_name),
      isSynced: Value(isSynced),
    );
  }

  factory SalesPersonData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SalesPersonData(
      id: serializer.fromJson<int>(json['id']),
      itinerary_line_id: serializer.fromJson<int>(json['itinerary_line_id']),
      partner_name: serializer.fromJson<String>(json['partner_name']),
      date: serializer.fromJson<String>(json['date']),
      route_code: serializer.fromJson<String>(json['route_code']),
      route_name: serializer.fromJson<String>(json['route_name']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itinerary_line_id': serializer.toJson<int>(itinerary_line_id),
      'partner_name': serializer.toJson<String>(partner_name),
      'date': serializer.toJson<String>(date),
      'route_code': serializer.toJson<String>(route_code),
      'route_name': serializer.toJson<String>(route_name),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  SalesPersonData copyWith({
    int? id,
    int? itinerary_line_id,
    String? partner_name,
    String? date,
    String? route_code,
    String? route_name,
    bool? isSynced,
  }) => SalesPersonData(
    id: id ?? this.id,
    itinerary_line_id: itinerary_line_id ?? this.itinerary_line_id,
    partner_name: partner_name ?? this.partner_name,
    date: date ?? this.date,
    route_code: route_code ?? this.route_code,
    route_name: route_name ?? this.route_name,
    isSynced: isSynced ?? this.isSynced,
  );
  SalesPersonData copyWithCompanion(SalesPersonDataOperationsCompanion data) {
    return SalesPersonData(
      id: data.id.present ? data.id.value : this.id,
      itinerary_line_id:
          data.itinerary_line_id.present
              ? data.itinerary_line_id.value
              : this.itinerary_line_id,
      partner_name:
          data.partner_name.present
              ? data.partner_name.value
              : this.partner_name,
      date: data.date.present ? data.date.value : this.date,
      route_code:
          data.route_code.present ? data.route_code.value : this.route_code,
      route_name:
          data.route_name.present ? data.route_name.value : this.route_name,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SalesPersonData(')
          ..write('id: $id, ')
          ..write('itinerary_line_id: $itinerary_line_id, ')
          ..write('partner_name: $partner_name, ')
          ..write('date: $date, ')
          ..write('route_code: $route_code, ')
          ..write('route_name: $route_name, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    itinerary_line_id,
    partner_name,
    date,
    route_code,
    route_name,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalesPersonData &&
          other.id == this.id &&
          other.itinerary_line_id == this.itinerary_line_id &&
          other.partner_name == this.partner_name &&
          other.date == this.date &&
          other.route_code == this.route_code &&
          other.route_name == this.route_name &&
          other.isSynced == this.isSynced);
}

class SalesPersonDataOperationsCompanion
    extends UpdateCompanion<SalesPersonData> {
  final Value<int> id;
  final Value<int> itinerary_line_id;
  final Value<String> partner_name;
  final Value<String> date;
  final Value<String> route_code;
  final Value<String> route_name;
  final Value<bool> isSynced;
  const SalesPersonDataOperationsCompanion({
    this.id = const Value.absent(),
    this.itinerary_line_id = const Value.absent(),
    this.partner_name = const Value.absent(),
    this.date = const Value.absent(),
    this.route_code = const Value.absent(),
    this.route_name = const Value.absent(),
    this.isSynced = const Value.absent(),
  });
  SalesPersonDataOperationsCompanion.insert({
    this.id = const Value.absent(),
    required int itinerary_line_id,
    required String partner_name,
    required String date,
    required String route_code,
    required String route_name,
    this.isSynced = const Value.absent(),
  }) : itinerary_line_id = Value(itinerary_line_id),
       partner_name = Value(partner_name),
       date = Value(date),
       route_code = Value(route_code),
       route_name = Value(route_name);
  static Insertable<SalesPersonData> custom({
    Expression<int>? id,
    Expression<int>? itinerary_line_id,
    Expression<String>? partner_name,
    Expression<String>? date,
    Expression<String>? route_code,
    Expression<String>? route_name,
    Expression<bool>? isSynced,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itinerary_line_id != null) 'itinerary_line_id': itinerary_line_id,
      if (partner_name != null) 'partner_name': partner_name,
      if (date != null) 'date': date,
      if (route_code != null) 'route_code': route_code,
      if (route_name != null) 'route_name': route_name,
      if (isSynced != null) 'is_synced': isSynced,
    });
  }

  SalesPersonDataOperationsCompanion copyWith({
    Value<int>? id,
    Value<int>? itinerary_line_id,
    Value<String>? partner_name,
    Value<String>? date,
    Value<String>? route_code,
    Value<String>? route_name,
    Value<bool>? isSynced,
  }) {
    return SalesPersonDataOperationsCompanion(
      id: id ?? this.id,
      itinerary_line_id: itinerary_line_id ?? this.itinerary_line_id,
      partner_name: partner_name ?? this.partner_name,
      date: date ?? this.date,
      route_code: route_code ?? this.route_code,
      route_name: route_name ?? this.route_name,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itinerary_line_id.present) {
      map['itinerary_line_id'] = Variable<int>(itinerary_line_id.value);
    }
    if (partner_name.present) {
      map['partner_name'] = Variable<String>(partner_name.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (route_code.present) {
      map['route_code'] = Variable<String>(route_code.value);
    }
    if (route_name.present) {
      map['route_name'] = Variable<String>(route_name.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesPersonDataOperationsCompanion(')
          ..write('id: $id, ')
          ..write('itinerary_line_id: $itinerary_line_id, ')
          ..write('partner_name: $partner_name, ')
          ..write('date: $date, ')
          ..write('route_code: $route_code, ')
          ..write('route_name: $route_name, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }
}

class $ProductMasterTable extends ProductMaster
    with TableInfo<$ProductMasterTable, ProductMasterData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductMasterTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _salesPriceMeta = const VerificationMeta(
    'salesPrice',
  );
  @override
  late final GeneratedColumn<double> salesPrice = GeneratedColumn<double>(
    'sales_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemCodeMeta = const VerificationMeta(
    'itemCode',
  );
  @override
  late final GeneratedColumn<String> itemCode = GeneratedColumn<String>(
    'item_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productName,
    imageUrl,
    salesPrice,
    itemCode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_master';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductMasterData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('sales_price')) {
      context.handle(
        _salesPriceMeta,
        salesPrice.isAcceptableOrUnknown(data['sales_price']!, _salesPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_salesPriceMeta);
    }
    if (data.containsKey('item_code')) {
      context.handle(
        _itemCodeMeta,
        itemCode.isAcceptableOrUnknown(data['item_code']!, _itemCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_itemCodeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductMasterData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductMasterData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      productName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}product_name'],
          )!,
      imageUrl:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}image_url'],
          )!,
      salesPrice:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}sales_price'],
          )!,
      itemCode:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}item_code'],
          )!,
    );
  }

  @override
  $ProductMasterTable createAlias(String alias) {
    return $ProductMasterTable(attachedDatabase, alias);
  }
}

class ProductMasterData extends DataClass
    implements Insertable<ProductMasterData> {
  final int id;
  final String productName;
  final String imageUrl;
  final double salesPrice;
  final String itemCode;
  const ProductMasterData({
    required this.id,
    required this.productName,
    required this.imageUrl,
    required this.salesPrice,
    required this.itemCode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_name'] = Variable<String>(productName);
    map['image_url'] = Variable<String>(imageUrl);
    map['sales_price'] = Variable<double>(salesPrice);
    map['item_code'] = Variable<String>(itemCode);
    return map;
  }

  ProductMasterCompanion toCompanion(bool nullToAbsent) {
    return ProductMasterCompanion(
      id: Value(id),
      productName: Value(productName),
      imageUrl: Value(imageUrl),
      salesPrice: Value(salesPrice),
      itemCode: Value(itemCode),
    );
  }

  factory ProductMasterData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductMasterData(
      id: serializer.fromJson<int>(json['id']),
      productName: serializer.fromJson<String>(json['productName']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      salesPrice: serializer.fromJson<double>(json['salesPrice']),
      itemCode: serializer.fromJson<String>(json['itemCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productName': serializer.toJson<String>(productName),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'salesPrice': serializer.toJson<double>(salesPrice),
      'itemCode': serializer.toJson<String>(itemCode),
    };
  }

  ProductMasterData copyWith({
    int? id,
    String? productName,
    String? imageUrl,
    double? salesPrice,
    String? itemCode,
  }) => ProductMasterData(
    id: id ?? this.id,
    productName: productName ?? this.productName,
    imageUrl: imageUrl ?? this.imageUrl,
    salesPrice: salesPrice ?? this.salesPrice,
    itemCode: itemCode ?? this.itemCode,
  );
  ProductMasterData copyWithCompanion(ProductMasterCompanion data) {
    return ProductMasterData(
      id: data.id.present ? data.id.value : this.id,
      productName:
          data.productName.present ? data.productName.value : this.productName,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      salesPrice:
          data.salesPrice.present ? data.salesPrice.value : this.salesPrice,
      itemCode: data.itemCode.present ? data.itemCode.value : this.itemCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductMasterData(')
          ..write('id: $id, ')
          ..write('productName: $productName, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('salesPrice: $salesPrice, ')
          ..write('itemCode: $itemCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, productName, imageUrl, salesPrice, itemCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductMasterData &&
          other.id == this.id &&
          other.productName == this.productName &&
          other.imageUrl == this.imageUrl &&
          other.salesPrice == this.salesPrice &&
          other.itemCode == this.itemCode);
}

class ProductMasterCompanion extends UpdateCompanion<ProductMasterData> {
  final Value<int> id;
  final Value<String> productName;
  final Value<String> imageUrl;
  final Value<double> salesPrice;
  final Value<String> itemCode;
  const ProductMasterCompanion({
    this.id = const Value.absent(),
    this.productName = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.salesPrice = const Value.absent(),
    this.itemCode = const Value.absent(),
  });
  ProductMasterCompanion.insert({
    this.id = const Value.absent(),
    required String productName,
    required String imageUrl,
    required double salesPrice,
    required String itemCode,
  }) : productName = Value(productName),
       imageUrl = Value(imageUrl),
       salesPrice = Value(salesPrice),
       itemCode = Value(itemCode);
  static Insertable<ProductMasterData> custom({
    Expression<int>? id,
    Expression<String>? productName,
    Expression<String>? imageUrl,
    Expression<double>? salesPrice,
    Expression<String>? itemCode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productName != null) 'product_name': productName,
      if (imageUrl != null) 'image_url': imageUrl,
      if (salesPrice != null) 'sales_price': salesPrice,
      if (itemCode != null) 'item_code': itemCode,
    });
  }

  ProductMasterCompanion copyWith({
    Value<int>? id,
    Value<String>? productName,
    Value<String>? imageUrl,
    Value<double>? salesPrice,
    Value<String>? itemCode,
  }) {
    return ProductMasterCompanion(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      imageUrl: imageUrl ?? this.imageUrl,
      salesPrice: salesPrice ?? this.salesPrice,
      itemCode: itemCode ?? this.itemCode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (salesPrice.present) {
      map['sales_price'] = Variable<double>(salesPrice.value);
    }
    if (itemCode.present) {
      map['item_code'] = Variable<String>(itemCode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductMasterCompanion(')
          ..write('id: $id, ')
          ..write('productName: $productName, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('salesPrice: $salesPrice, ')
          ..write('itemCode: $itemCode')
          ..write(')'))
        .toString();
  }
}

class $ProductUsageTable extends ProductUsage
    with TableInfo<$ProductUsageTable, ProductUsageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductUsageTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _itineraryLineIdMeta = const VerificationMeta(
    'itineraryLineId',
  );
  @override
  late final GeneratedColumn<int> itineraryLineId = GeneratedColumn<int>(
    'itinerary_line_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _adQtyMeta = const VerificationMeta('adQty');
  @override
  late final GeneratedColumn<int> adQty = GeneratedColumn<int>(
    'ad_qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, itineraryLineId, productId, adQty];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_usage';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductUsageData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('itinerary_line_id')) {
      context.handle(
        _itineraryLineIdMeta,
        itineraryLineId.isAcceptableOrUnknown(
          data['itinerary_line_id']!,
          _itineraryLineIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_itineraryLineIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('ad_qty')) {
      context.handle(
        _adQtyMeta,
        adQty.isAcceptableOrUnknown(data['ad_qty']!, _adQtyMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductUsageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductUsageData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      itineraryLineId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}itinerary_line_id'],
          )!,
      productId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}product_id'],
          )!,
      adQty:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}ad_qty'],
          )!,
    );
  }

  @override
  $ProductUsageTable createAlias(String alias) {
    return $ProductUsageTable(attachedDatabase, alias);
  }
}

class ProductUsageData extends DataClass
    implements Insertable<ProductUsageData> {
  final int id;
  final int itineraryLineId;
  final int productId;
  final int adQty;
  const ProductUsageData({
    required this.id,
    required this.itineraryLineId,
    required this.productId,
    required this.adQty,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['itinerary_line_id'] = Variable<int>(itineraryLineId);
    map['product_id'] = Variable<int>(productId);
    map['ad_qty'] = Variable<int>(adQty);
    return map;
  }

  ProductUsageCompanion toCompanion(bool nullToAbsent) {
    return ProductUsageCompanion(
      id: Value(id),
      itineraryLineId: Value(itineraryLineId),
      productId: Value(productId),
      adQty: Value(adQty),
    );
  }

  factory ProductUsageData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductUsageData(
      id: serializer.fromJson<int>(json['id']),
      itineraryLineId: serializer.fromJson<int>(json['itineraryLineId']),
      productId: serializer.fromJson<int>(json['productId']),
      adQty: serializer.fromJson<int>(json['adQty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itineraryLineId': serializer.toJson<int>(itineraryLineId),
      'productId': serializer.toJson<int>(productId),
      'adQty': serializer.toJson<int>(adQty),
    };
  }

  ProductUsageData copyWith({
    int? id,
    int? itineraryLineId,
    int? productId,
    int? adQty,
  }) => ProductUsageData(
    id: id ?? this.id,
    itineraryLineId: itineraryLineId ?? this.itineraryLineId,
    productId: productId ?? this.productId,
    adQty: adQty ?? this.adQty,
  );
  ProductUsageData copyWithCompanion(ProductUsageCompanion data) {
    return ProductUsageData(
      id: data.id.present ? data.id.value : this.id,
      itineraryLineId:
          data.itineraryLineId.present
              ? data.itineraryLineId.value
              : this.itineraryLineId,
      productId: data.productId.present ? data.productId.value : this.productId,
      adQty: data.adQty.present ? data.adQty.value : this.adQty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductUsageData(')
          ..write('id: $id, ')
          ..write('itineraryLineId: $itineraryLineId, ')
          ..write('productId: $productId, ')
          ..write('adQty: $adQty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, itineraryLineId, productId, adQty);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductUsageData &&
          other.id == this.id &&
          other.itineraryLineId == this.itineraryLineId &&
          other.productId == this.productId &&
          other.adQty == this.adQty);
}

class ProductUsageCompanion extends UpdateCompanion<ProductUsageData> {
  final Value<int> id;
  final Value<int> itineraryLineId;
  final Value<int> productId;
  final Value<int> adQty;
  const ProductUsageCompanion({
    this.id = const Value.absent(),
    this.itineraryLineId = const Value.absent(),
    this.productId = const Value.absent(),
    this.adQty = const Value.absent(),
  });
  ProductUsageCompanion.insert({
    this.id = const Value.absent(),
    required int itineraryLineId,
    required int productId,
    this.adQty = const Value.absent(),
  }) : itineraryLineId = Value(itineraryLineId),
       productId = Value(productId);
  static Insertable<ProductUsageData> custom({
    Expression<int>? id,
    Expression<int>? itineraryLineId,
    Expression<int>? productId,
    Expression<int>? adQty,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itineraryLineId != null) 'itinerary_line_id': itineraryLineId,
      if (productId != null) 'product_id': productId,
      if (adQty != null) 'ad_qty': adQty,
    });
  }

  ProductUsageCompanion copyWith({
    Value<int>? id,
    Value<int>? itineraryLineId,
    Value<int>? productId,
    Value<int>? adQty,
  }) {
    return ProductUsageCompanion(
      id: id ?? this.id,
      itineraryLineId: itineraryLineId ?? this.itineraryLineId,
      productId: productId ?? this.productId,
      adQty: adQty ?? this.adQty,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itineraryLineId.present) {
      map['itinerary_line_id'] = Variable<int>(itineraryLineId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (adQty.present) {
      map['ad_qty'] = Variable<int>(adQty.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductUsageCompanion(')
          ..write('id: $id, ')
          ..write('itineraryLineId: $itineraryLineId, ')
          ..write('productId: $productId, ')
          ..write('adQty: $adQty')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SalesPersonDataOperationsTable salesPersonDataOperations =
      $SalesPersonDataOperationsTable(this);
  late final $ProductMasterTable productMaster = $ProductMasterTable(this);
  late final $ProductUsageTable productUsage = $ProductUsageTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    salesPersonDataOperations,
    productMaster,
    productUsage,
  ];
}

typedef $$SalesPersonDataOperationsTableCreateCompanionBuilder =
    SalesPersonDataOperationsCompanion Function({
      Value<int> id,
      required int itinerary_line_id,
      required String partner_name,
      required String date,
      required String route_code,
      required String route_name,
      Value<bool> isSynced,
    });
typedef $$SalesPersonDataOperationsTableUpdateCompanionBuilder =
    SalesPersonDataOperationsCompanion Function({
      Value<int> id,
      Value<int> itinerary_line_id,
      Value<String> partner_name,
      Value<String> date,
      Value<String> route_code,
      Value<String> route_name,
      Value<bool> isSynced,
    });

class $$SalesPersonDataOperationsTableFilterComposer
    extends Composer<_$AppDatabase, $SalesPersonDataOperationsTable> {
  $$SalesPersonDataOperationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get itinerary_line_id => $composableBuilder(
    column: $table.itinerary_line_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partner_name => $composableBuilder(
    column: $table.partner_name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get route_code => $composableBuilder(
    column: $table.route_code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get route_name => $composableBuilder(
    column: $table.route_name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SalesPersonDataOperationsTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesPersonDataOperationsTable> {
  $$SalesPersonDataOperationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get itinerary_line_id => $composableBuilder(
    column: $table.itinerary_line_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partner_name => $composableBuilder(
    column: $table.partner_name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get route_code => $composableBuilder(
    column: $table.route_code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get route_name => $composableBuilder(
    column: $table.route_name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SalesPersonDataOperationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesPersonDataOperationsTable> {
  $$SalesPersonDataOperationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get itinerary_line_id => $composableBuilder(
    column: $table.itinerary_line_id,
    builder: (column) => column,
  );

  GeneratedColumn<String> get partner_name => $composableBuilder(
    column: $table.partner_name,
    builder: (column) => column,
  );

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get route_code => $composableBuilder(
    column: $table.route_code,
    builder: (column) => column,
  );

  GeneratedColumn<String> get route_name => $composableBuilder(
    column: $table.route_name,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$SalesPersonDataOperationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesPersonDataOperationsTable,
          SalesPersonData,
          $$SalesPersonDataOperationsTableFilterComposer,
          $$SalesPersonDataOperationsTableOrderingComposer,
          $$SalesPersonDataOperationsTableAnnotationComposer,
          $$SalesPersonDataOperationsTableCreateCompanionBuilder,
          $$SalesPersonDataOperationsTableUpdateCompanionBuilder,
          (
            SalesPersonData,
            BaseReferences<
              _$AppDatabase,
              $SalesPersonDataOperationsTable,
              SalesPersonData
            >,
          ),
          SalesPersonData,
          PrefetchHooks Function()
        > {
  $$SalesPersonDataOperationsTableTableManager(
    _$AppDatabase db,
    $SalesPersonDataOperationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SalesPersonDataOperationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$SalesPersonDataOperationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$SalesPersonDataOperationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> itinerary_line_id = const Value.absent(),
                Value<String> partner_name = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> route_code = const Value.absent(),
                Value<String> route_name = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
              }) => SalesPersonDataOperationsCompanion(
                id: id,
                itinerary_line_id: itinerary_line_id,
                partner_name: partner_name,
                date: date,
                route_code: route_code,
                route_name: route_name,
                isSynced: isSynced,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int itinerary_line_id,
                required String partner_name,
                required String date,
                required String route_code,
                required String route_name,
                Value<bool> isSynced = const Value.absent(),
              }) => SalesPersonDataOperationsCompanion.insert(
                id: id,
                itinerary_line_id: itinerary_line_id,
                partner_name: partner_name,
                date: date,
                route_code: route_code,
                route_name: route_name,
                isSynced: isSynced,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SalesPersonDataOperationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesPersonDataOperationsTable,
      SalesPersonData,
      $$SalesPersonDataOperationsTableFilterComposer,
      $$SalesPersonDataOperationsTableOrderingComposer,
      $$SalesPersonDataOperationsTableAnnotationComposer,
      $$SalesPersonDataOperationsTableCreateCompanionBuilder,
      $$SalesPersonDataOperationsTableUpdateCompanionBuilder,
      (
        SalesPersonData,
        BaseReferences<
          _$AppDatabase,
          $SalesPersonDataOperationsTable,
          SalesPersonData
        >,
      ),
      SalesPersonData,
      PrefetchHooks Function()
    >;
typedef $$ProductMasterTableCreateCompanionBuilder =
    ProductMasterCompanion Function({
      Value<int> id,
      required String productName,
      required String imageUrl,
      required double salesPrice,
      required String itemCode,
    });
typedef $$ProductMasterTableUpdateCompanionBuilder =
    ProductMasterCompanion Function({
      Value<int> id,
      Value<String> productName,
      Value<String> imageUrl,
      Value<double> salesPrice,
      Value<String> itemCode,
    });

class $$ProductMasterTableFilterComposer
    extends Composer<_$AppDatabase, $ProductMasterTable> {
  $$ProductMasterTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get salesPrice => $composableBuilder(
    column: $table.salesPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemCode => $composableBuilder(
    column: $table.itemCode,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductMasterTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductMasterTable> {
  $$ProductMasterTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get salesPrice => $composableBuilder(
    column: $table.salesPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemCode => $composableBuilder(
    column: $table.itemCode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductMasterTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductMasterTable> {
  $$ProductMasterTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<double> get salesPrice => $composableBuilder(
    column: $table.salesPrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get itemCode =>
      $composableBuilder(column: $table.itemCode, builder: (column) => column);
}

class $$ProductMasterTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductMasterTable,
          ProductMasterData,
          $$ProductMasterTableFilterComposer,
          $$ProductMasterTableOrderingComposer,
          $$ProductMasterTableAnnotationComposer,
          $$ProductMasterTableCreateCompanionBuilder,
          $$ProductMasterTableUpdateCompanionBuilder,
          (
            ProductMasterData,
            BaseReferences<
              _$AppDatabase,
              $ProductMasterTable,
              ProductMasterData
            >,
          ),
          ProductMasterData,
          PrefetchHooks Function()
        > {
  $$ProductMasterTableTableManager(_$AppDatabase db, $ProductMasterTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ProductMasterTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$ProductMasterTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ProductMasterTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<double> salesPrice = const Value.absent(),
                Value<String> itemCode = const Value.absent(),
              }) => ProductMasterCompanion(
                id: id,
                productName: productName,
                imageUrl: imageUrl,
                salesPrice: salesPrice,
                itemCode: itemCode,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String productName,
                required String imageUrl,
                required double salesPrice,
                required String itemCode,
              }) => ProductMasterCompanion.insert(
                id: id,
                productName: productName,
                imageUrl: imageUrl,
                salesPrice: salesPrice,
                itemCode: itemCode,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductMasterTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductMasterTable,
      ProductMasterData,
      $$ProductMasterTableFilterComposer,
      $$ProductMasterTableOrderingComposer,
      $$ProductMasterTableAnnotationComposer,
      $$ProductMasterTableCreateCompanionBuilder,
      $$ProductMasterTableUpdateCompanionBuilder,
      (
        ProductMasterData,
        BaseReferences<_$AppDatabase, $ProductMasterTable, ProductMasterData>,
      ),
      ProductMasterData,
      PrefetchHooks Function()
    >;
typedef $$ProductUsageTableCreateCompanionBuilder =
    ProductUsageCompanion Function({
      Value<int> id,
      required int itineraryLineId,
      required int productId,
      Value<int> adQty,
    });
typedef $$ProductUsageTableUpdateCompanionBuilder =
    ProductUsageCompanion Function({
      Value<int> id,
      Value<int> itineraryLineId,
      Value<int> productId,
      Value<int> adQty,
    });

class $$ProductUsageTableFilterComposer
    extends Composer<_$AppDatabase, $ProductUsageTable> {
  $$ProductUsageTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get itineraryLineId => $composableBuilder(
    column: $table.itineraryLineId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get adQty => $composableBuilder(
    column: $table.adQty,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductUsageTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductUsageTable> {
  $$ProductUsageTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get itineraryLineId => $composableBuilder(
    column: $table.itineraryLineId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get adQty => $composableBuilder(
    column: $table.adQty,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductUsageTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductUsageTable> {
  $$ProductUsageTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get itineraryLineId => $composableBuilder(
    column: $table.itineraryLineId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get adQty =>
      $composableBuilder(column: $table.adQty, builder: (column) => column);
}

class $$ProductUsageTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductUsageTable,
          ProductUsageData,
          $$ProductUsageTableFilterComposer,
          $$ProductUsageTableOrderingComposer,
          $$ProductUsageTableAnnotationComposer,
          $$ProductUsageTableCreateCompanionBuilder,
          $$ProductUsageTableUpdateCompanionBuilder,
          (
            ProductUsageData,
            BaseReferences<_$AppDatabase, $ProductUsageTable, ProductUsageData>,
          ),
          ProductUsageData,
          PrefetchHooks Function()
        > {
  $$ProductUsageTableTableManager(_$AppDatabase db, $ProductUsageTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ProductUsageTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ProductUsageTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$ProductUsageTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> itineraryLineId = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> adQty = const Value.absent(),
              }) => ProductUsageCompanion(
                id: id,
                itineraryLineId: itineraryLineId,
                productId: productId,
                adQty: adQty,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int itineraryLineId,
                required int productId,
                Value<int> adQty = const Value.absent(),
              }) => ProductUsageCompanion.insert(
                id: id,
                itineraryLineId: itineraryLineId,
                productId: productId,
                adQty: adQty,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductUsageTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductUsageTable,
      ProductUsageData,
      $$ProductUsageTableFilterComposer,
      $$ProductUsageTableOrderingComposer,
      $$ProductUsageTableAnnotationComposer,
      $$ProductUsageTableCreateCompanionBuilder,
      $$ProductUsageTableUpdateCompanionBuilder,
      (
        ProductUsageData,
        BaseReferences<_$AppDatabase, $ProductUsageTable, ProductUsageData>,
      ),
      ProductUsageData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SalesPersonDataOperationsTableTableManager get salesPersonDataOperations =>
      $$SalesPersonDataOperationsTableTableManager(
        _db,
        _db.salesPersonDataOperations,
      );
  $$ProductMasterTableTableManager get productMaster =>
      $$ProductMasterTableTableManager(_db, _db.productMaster);
  $$ProductUsageTableTableManager get productUsage =>
      $$ProductUsageTableTableManager(_db, _db.productUsage);
}
