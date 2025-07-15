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
  static const VerificationMeta _partner_idMeta = const VerificationMeta(
    'partner_id',
  );
  @override
  late final GeneratedColumn<int> partner_id = GeneratedColumn<int>(
    'partner_id',
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
  static const VerificationMeta _cusOutstandingAmountMeta =
      const VerificationMeta('cusOutstandingAmount');
  @override
  late final GeneratedColumn<double> cusOutstandingAmount =
      GeneratedColumn<double>(
        'cus_outstanding_amount',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _itinerary_latitudeMeta =
      const VerificationMeta('itinerary_latitude');
  @override
  late final GeneratedColumn<double> itinerary_latitude =
      GeneratedColumn<double>(
        'itinerary_latitude',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _itinerary_longitudeMeta =
      const VerificationMeta('itinerary_longitude');
  @override
  late final GeneratedColumn<double> itinerary_longitude =
      GeneratedColumn<double>(
        'itinerary_longitude',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _visit_statusMeta = const VerificationMeta(
    'visit_status',
  );
  @override
  late final GeneratedColumn<String> visit_status = GeneratedColumn<String>(
    'visit_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(""),
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
  static const VerificationMeta _isVisitedMeta = const VerificationMeta(
    'isVisited',
  );
  @override
  late final GeneratedColumn<bool> isVisited = GeneratedColumn<bool>(
    'is_visited',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_visited" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    itinerary_line_id,
    partner_id,
    partner_name,
    date,
    route_code,
    route_name,
    cusOutstandingAmount,
    itinerary_latitude,
    itinerary_longitude,
    visit_status,
    isSynced,
    isVisited,
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
    if (data.containsKey('partner_id')) {
      context.handle(
        _partner_idMeta,
        partner_id.isAcceptableOrUnknown(data['partner_id']!, _partner_idMeta),
      );
    } else if (isInserting) {
      context.missing(_partner_idMeta);
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
    if (data.containsKey('cus_outstanding_amount')) {
      context.handle(
        _cusOutstandingAmountMeta,
        cusOutstandingAmount.isAcceptableOrUnknown(
          data['cus_outstanding_amount']!,
          _cusOutstandingAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cusOutstandingAmountMeta);
    }
    if (data.containsKey('itinerary_latitude')) {
      context.handle(
        _itinerary_latitudeMeta,
        itinerary_latitude.isAcceptableOrUnknown(
          data['itinerary_latitude']!,
          _itinerary_latitudeMeta,
        ),
      );
    }
    if (data.containsKey('itinerary_longitude')) {
      context.handle(
        _itinerary_longitudeMeta,
        itinerary_longitude.isAcceptableOrUnknown(
          data['itinerary_longitude']!,
          _itinerary_longitudeMeta,
        ),
      );
    }
    if (data.containsKey('visit_status')) {
      context.handle(
        _visit_statusMeta,
        visit_status.isAcceptableOrUnknown(
          data['visit_status']!,
          _visit_statusMeta,
        ),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('is_visited')) {
      context.handle(
        _isVisitedMeta,
        isVisited.isAcceptableOrUnknown(data['is_visited']!, _isVisitedMeta),
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
      partner_id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}partner_id'],
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
      cusOutstandingAmount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}cus_outstanding_amount'],
          )!,
      itinerary_latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}itinerary_latitude'],
      ),
      itinerary_longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}itinerary_longitude'],
      ),
      visit_status:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}visit_status'],
          )!,
      isSynced:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_synced'],
          )!,
      isVisited:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_visited'],
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
  final int partner_id;
  final String partner_name;
  final String date;
  final String route_code;
  final String route_name;
  final double cusOutstandingAmount;
  final double? itinerary_latitude;
  final double? itinerary_longitude;
  final String visit_status;
  final bool isSynced;
  final bool isVisited;
  const SalesPersonData({
    required this.id,
    required this.itinerary_line_id,
    required this.partner_id,
    required this.partner_name,
    required this.date,
    required this.route_code,
    required this.route_name,
    required this.cusOutstandingAmount,
    this.itinerary_latitude,
    this.itinerary_longitude,
    required this.visit_status,
    required this.isSynced,
    required this.isVisited,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['itinerary_line_id'] = Variable<int>(itinerary_line_id);
    map['partner_id'] = Variable<int>(partner_id);
    map['partner_name'] = Variable<String>(partner_name);
    map['date'] = Variable<String>(date);
    map['route_code'] = Variable<String>(route_code);
    map['route_name'] = Variable<String>(route_name);
    map['cus_outstanding_amount'] = Variable<double>(cusOutstandingAmount);
    if (!nullToAbsent || itinerary_latitude != null) {
      map['itinerary_latitude'] = Variable<double>(itinerary_latitude);
    }
    if (!nullToAbsent || itinerary_longitude != null) {
      map['itinerary_longitude'] = Variable<double>(itinerary_longitude);
    }
    map['visit_status'] = Variable<String>(visit_status);
    map['is_synced'] = Variable<bool>(isSynced);
    map['is_visited'] = Variable<bool>(isVisited);
    return map;
  }

  SalesPersonDataOperationsCompanion toCompanion(bool nullToAbsent) {
    return SalesPersonDataOperationsCompanion(
      id: Value(id),
      itinerary_line_id: Value(itinerary_line_id),
      partner_id: Value(partner_id),
      partner_name: Value(partner_name),
      date: Value(date),
      route_code: Value(route_code),
      route_name: Value(route_name),
      cusOutstandingAmount: Value(cusOutstandingAmount),
      itinerary_latitude:
          itinerary_latitude == null && nullToAbsent
              ? const Value.absent()
              : Value(itinerary_latitude),
      itinerary_longitude:
          itinerary_longitude == null && nullToAbsent
              ? const Value.absent()
              : Value(itinerary_longitude),
      visit_status: Value(visit_status),
      isSynced: Value(isSynced),
      isVisited: Value(isVisited),
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
      partner_id: serializer.fromJson<int>(json['partner_id']),
      partner_name: serializer.fromJson<String>(json['partner_name']),
      date: serializer.fromJson<String>(json['date']),
      route_code: serializer.fromJson<String>(json['route_code']),
      route_name: serializer.fromJson<String>(json['route_name']),
      cusOutstandingAmount: serializer.fromJson<double>(
        json['cusOutstandingAmount'],
      ),
      itinerary_latitude: serializer.fromJson<double?>(
        json['itinerary_latitude'],
      ),
      itinerary_longitude: serializer.fromJson<double?>(
        json['itinerary_longitude'],
      ),
      visit_status: serializer.fromJson<String>(json['visit_status']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      isVisited: serializer.fromJson<bool>(json['isVisited']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itinerary_line_id': serializer.toJson<int>(itinerary_line_id),
      'partner_id': serializer.toJson<int>(partner_id),
      'partner_name': serializer.toJson<String>(partner_name),
      'date': serializer.toJson<String>(date),
      'route_code': serializer.toJson<String>(route_code),
      'route_name': serializer.toJson<String>(route_name),
      'cusOutstandingAmount': serializer.toJson<double>(cusOutstandingAmount),
      'itinerary_latitude': serializer.toJson<double?>(itinerary_latitude),
      'itinerary_longitude': serializer.toJson<double?>(itinerary_longitude),
      'visit_status': serializer.toJson<String>(visit_status),
      'isSynced': serializer.toJson<bool>(isSynced),
      'isVisited': serializer.toJson<bool>(isVisited),
    };
  }

  SalesPersonData copyWith({
    int? id,
    int? itinerary_line_id,
    int? partner_id,
    String? partner_name,
    String? date,
    String? route_code,
    String? route_name,
    double? cusOutstandingAmount,
    Value<double?> itinerary_latitude = const Value.absent(),
    Value<double?> itinerary_longitude = const Value.absent(),
    String? visit_status,
    bool? isSynced,
    bool? isVisited,
  }) => SalesPersonData(
    id: id ?? this.id,
    itinerary_line_id: itinerary_line_id ?? this.itinerary_line_id,
    partner_id: partner_id ?? this.partner_id,
    partner_name: partner_name ?? this.partner_name,
    date: date ?? this.date,
    route_code: route_code ?? this.route_code,
    route_name: route_name ?? this.route_name,
    cusOutstandingAmount: cusOutstandingAmount ?? this.cusOutstandingAmount,
    itinerary_latitude:
        itinerary_latitude.present
            ? itinerary_latitude.value
            : this.itinerary_latitude,
    itinerary_longitude:
        itinerary_longitude.present
            ? itinerary_longitude.value
            : this.itinerary_longitude,
    visit_status: visit_status ?? this.visit_status,
    isSynced: isSynced ?? this.isSynced,
    isVisited: isVisited ?? this.isVisited,
  );
  SalesPersonData copyWithCompanion(SalesPersonDataOperationsCompanion data) {
    return SalesPersonData(
      id: data.id.present ? data.id.value : this.id,
      itinerary_line_id:
          data.itinerary_line_id.present
              ? data.itinerary_line_id.value
              : this.itinerary_line_id,
      partner_id:
          data.partner_id.present ? data.partner_id.value : this.partner_id,
      partner_name:
          data.partner_name.present
              ? data.partner_name.value
              : this.partner_name,
      date: data.date.present ? data.date.value : this.date,
      route_code:
          data.route_code.present ? data.route_code.value : this.route_code,
      route_name:
          data.route_name.present ? data.route_name.value : this.route_name,
      cusOutstandingAmount:
          data.cusOutstandingAmount.present
              ? data.cusOutstandingAmount.value
              : this.cusOutstandingAmount,
      itinerary_latitude:
          data.itinerary_latitude.present
              ? data.itinerary_latitude.value
              : this.itinerary_latitude,
      itinerary_longitude:
          data.itinerary_longitude.present
              ? data.itinerary_longitude.value
              : this.itinerary_longitude,
      visit_status:
          data.visit_status.present
              ? data.visit_status.value
              : this.visit_status,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      isVisited: data.isVisited.present ? data.isVisited.value : this.isVisited,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SalesPersonData(')
          ..write('id: $id, ')
          ..write('itinerary_line_id: $itinerary_line_id, ')
          ..write('partner_id: $partner_id, ')
          ..write('partner_name: $partner_name, ')
          ..write('date: $date, ')
          ..write('route_code: $route_code, ')
          ..write('route_name: $route_name, ')
          ..write('cusOutstandingAmount: $cusOutstandingAmount, ')
          ..write('itinerary_latitude: $itinerary_latitude, ')
          ..write('itinerary_longitude: $itinerary_longitude, ')
          ..write('visit_status: $visit_status, ')
          ..write('isSynced: $isSynced, ')
          ..write('isVisited: $isVisited')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    itinerary_line_id,
    partner_id,
    partner_name,
    date,
    route_code,
    route_name,
    cusOutstandingAmount,
    itinerary_latitude,
    itinerary_longitude,
    visit_status,
    isSynced,
    isVisited,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalesPersonData &&
          other.id == this.id &&
          other.itinerary_line_id == this.itinerary_line_id &&
          other.partner_id == this.partner_id &&
          other.partner_name == this.partner_name &&
          other.date == this.date &&
          other.route_code == this.route_code &&
          other.route_name == this.route_name &&
          other.cusOutstandingAmount == this.cusOutstandingAmount &&
          other.itinerary_latitude == this.itinerary_latitude &&
          other.itinerary_longitude == this.itinerary_longitude &&
          other.visit_status == this.visit_status &&
          other.isSynced == this.isSynced &&
          other.isVisited == this.isVisited);
}

class SalesPersonDataOperationsCompanion
    extends UpdateCompanion<SalesPersonData> {
  final Value<int> id;
  final Value<int> itinerary_line_id;
  final Value<int> partner_id;
  final Value<String> partner_name;
  final Value<String> date;
  final Value<String> route_code;
  final Value<String> route_name;
  final Value<double> cusOutstandingAmount;
  final Value<double?> itinerary_latitude;
  final Value<double?> itinerary_longitude;
  final Value<String> visit_status;
  final Value<bool> isSynced;
  final Value<bool> isVisited;
  const SalesPersonDataOperationsCompanion({
    this.id = const Value.absent(),
    this.itinerary_line_id = const Value.absent(),
    this.partner_id = const Value.absent(),
    this.partner_name = const Value.absent(),
    this.date = const Value.absent(),
    this.route_code = const Value.absent(),
    this.route_name = const Value.absent(),
    this.cusOutstandingAmount = const Value.absent(),
    this.itinerary_latitude = const Value.absent(),
    this.itinerary_longitude = const Value.absent(),
    this.visit_status = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isVisited = const Value.absent(),
  });
  SalesPersonDataOperationsCompanion.insert({
    this.id = const Value.absent(),
    required int itinerary_line_id,
    required int partner_id,
    required String partner_name,
    required String date,
    required String route_code,
    required String route_name,
    required double cusOutstandingAmount,
    this.itinerary_latitude = const Value.absent(),
    this.itinerary_longitude = const Value.absent(),
    this.visit_status = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.isVisited = const Value.absent(),
  }) : itinerary_line_id = Value(itinerary_line_id),
       partner_id = Value(partner_id),
       partner_name = Value(partner_name),
       date = Value(date),
       route_code = Value(route_code),
       route_name = Value(route_name),
       cusOutstandingAmount = Value(cusOutstandingAmount);
  static Insertable<SalesPersonData> custom({
    Expression<int>? id,
    Expression<int>? itinerary_line_id,
    Expression<int>? partner_id,
    Expression<String>? partner_name,
    Expression<String>? date,
    Expression<String>? route_code,
    Expression<String>? route_name,
    Expression<double>? cusOutstandingAmount,
    Expression<double>? itinerary_latitude,
    Expression<double>? itinerary_longitude,
    Expression<String>? visit_status,
    Expression<bool>? isSynced,
    Expression<bool>? isVisited,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itinerary_line_id != null) 'itinerary_line_id': itinerary_line_id,
      if (partner_id != null) 'partner_id': partner_id,
      if (partner_name != null) 'partner_name': partner_name,
      if (date != null) 'date': date,
      if (route_code != null) 'route_code': route_code,
      if (route_name != null) 'route_name': route_name,
      if (cusOutstandingAmount != null)
        'cus_outstanding_amount': cusOutstandingAmount,
      if (itinerary_latitude != null) 'itinerary_latitude': itinerary_latitude,
      if (itinerary_longitude != null)
        'itinerary_longitude': itinerary_longitude,
      if (visit_status != null) 'visit_status': visit_status,
      if (isSynced != null) 'is_synced': isSynced,
      if (isVisited != null) 'is_visited': isVisited,
    });
  }

  SalesPersonDataOperationsCompanion copyWith({
    Value<int>? id,
    Value<int>? itinerary_line_id,
    Value<int>? partner_id,
    Value<String>? partner_name,
    Value<String>? date,
    Value<String>? route_code,
    Value<String>? route_name,
    Value<double>? cusOutstandingAmount,
    Value<double?>? itinerary_latitude,
    Value<double?>? itinerary_longitude,
    Value<String>? visit_status,
    Value<bool>? isSynced,
    Value<bool>? isVisited,
  }) {
    return SalesPersonDataOperationsCompanion(
      id: id ?? this.id,
      itinerary_line_id: itinerary_line_id ?? this.itinerary_line_id,
      partner_id: partner_id ?? this.partner_id,
      partner_name: partner_name ?? this.partner_name,
      date: date ?? this.date,
      route_code: route_code ?? this.route_code,
      route_name: route_name ?? this.route_name,
      cusOutstandingAmount: cusOutstandingAmount ?? this.cusOutstandingAmount,
      itinerary_latitude: itinerary_latitude ?? this.itinerary_latitude,
      itinerary_longitude: itinerary_longitude ?? this.itinerary_longitude,
      visit_status: visit_status ?? this.visit_status,
      isSynced: isSynced ?? this.isSynced,
      isVisited: isVisited ?? this.isVisited,
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
    if (partner_id.present) {
      map['partner_id'] = Variable<int>(partner_id.value);
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
    if (cusOutstandingAmount.present) {
      map['cus_outstanding_amount'] = Variable<double>(
        cusOutstandingAmount.value,
      );
    }
    if (itinerary_latitude.present) {
      map['itinerary_latitude'] = Variable<double>(itinerary_latitude.value);
    }
    if (itinerary_longitude.present) {
      map['itinerary_longitude'] = Variable<double>(itinerary_longitude.value);
    }
    if (visit_status.present) {
      map['visit_status'] = Variable<String>(visit_status.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (isVisited.present) {
      map['is_visited'] = Variable<bool>(isVisited.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesPersonDataOperationsCompanion(')
          ..write('id: $id, ')
          ..write('itinerary_line_id: $itinerary_line_id, ')
          ..write('partner_id: $partner_id, ')
          ..write('partner_name: $partner_name, ')
          ..write('date: $date, ')
          ..write('route_code: $route_code, ')
          ..write('route_name: $route_name, ')
          ..write('cusOutstandingAmount: $cusOutstandingAmount, ')
          ..write('itinerary_latitude: $itinerary_latitude, ')
          ..write('itinerary_longitude: $itinerary_longitude, ')
          ..write('visit_status: $visit_status, ')
          ..write('isSynced: $isSynced, ')
          ..write('isVisited: $isVisited')
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
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
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
  static const VerificationMeta _productCategoryIdMeta = const VerificationMeta(
    'productCategoryId',
  );
  @override
  late final GeneratedColumn<int> productCategoryId = GeneratedColumn<int>(
    'product_category_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
  static const VerificationMeta _is_discount_productMeta =
      const VerificationMeta('is_discount_product');
  @override
  late final GeneratedColumn<bool> is_discount_product = GeneratedColumn<bool>(
    'is_discount_product',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_discount_product" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    productName,
    displayName,
    imageUrl,
    salesPrice,
    itemCode,
    productCategoryId,
    isSynced,
    is_discount_product,
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
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
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
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
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
    if (data.containsKey('product_category_id')) {
      context.handle(
        _productCategoryIdMeta,
        productCategoryId.isAcceptableOrUnknown(
          data['product_category_id']!,
          _productCategoryIdMeta,
        ),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('is_discount_product')) {
      context.handle(
        _is_discount_productMeta,
        is_discount_product.isAcceptableOrUnknown(
          data['is_discount_product']!,
          _is_discount_productMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_is_discount_productMeta);
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
      productId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}product_id'],
          )!,
      productName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}product_name'],
          )!,
      displayName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}display_name'],
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
      productCategoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_category_id'],
      ),
      isSynced:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_synced'],
          )!,
      is_discount_product:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_discount_product'],
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
  final int productId;
  final String productName;
  final String displayName;
  final String imageUrl;
  final double salesPrice;
  final String itemCode;
  final int? productCategoryId;
  final bool isSynced;
  final bool is_discount_product;
  const ProductMasterData({
    required this.id,
    required this.productId,
    required this.productName,
    required this.displayName,
    required this.imageUrl,
    required this.salesPrice,
    required this.itemCode,
    this.productCategoryId,
    required this.isSynced,
    required this.is_discount_product,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['product_name'] = Variable<String>(productName);
    map['display_name'] = Variable<String>(displayName);
    map['image_url'] = Variable<String>(imageUrl);
    map['sales_price'] = Variable<double>(salesPrice);
    map['item_code'] = Variable<String>(itemCode);
    if (!nullToAbsent || productCategoryId != null) {
      map['product_category_id'] = Variable<int>(productCategoryId);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    map['is_discount_product'] = Variable<bool>(is_discount_product);
    return map;
  }

  ProductMasterCompanion toCompanion(bool nullToAbsent) {
    return ProductMasterCompanion(
      id: Value(id),
      productId: Value(productId),
      productName: Value(productName),
      displayName: Value(displayName),
      imageUrl: Value(imageUrl),
      salesPrice: Value(salesPrice),
      itemCode: Value(itemCode),
      productCategoryId:
          productCategoryId == null && nullToAbsent
              ? const Value.absent()
              : Value(productCategoryId),
      isSynced: Value(isSynced),
      is_discount_product: Value(is_discount_product),
    );
  }

  factory ProductMasterData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductMasterData(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      productName: serializer.fromJson<String>(json['productName']),
      displayName: serializer.fromJson<String>(json['displayName']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      salesPrice: serializer.fromJson<double>(json['salesPrice']),
      itemCode: serializer.fromJson<String>(json['itemCode']),
      productCategoryId: serializer.fromJson<int?>(json['productCategoryId']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      is_discount_product: serializer.fromJson<bool>(
        json['is_discount_product'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'productName': serializer.toJson<String>(productName),
      'displayName': serializer.toJson<String>(displayName),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'salesPrice': serializer.toJson<double>(salesPrice),
      'itemCode': serializer.toJson<String>(itemCode),
      'productCategoryId': serializer.toJson<int?>(productCategoryId),
      'isSynced': serializer.toJson<bool>(isSynced),
      'is_discount_product': serializer.toJson<bool>(is_discount_product),
    };
  }

  ProductMasterData copyWith({
    int? id,
    int? productId,
    String? productName,
    String? displayName,
    String? imageUrl,
    double? salesPrice,
    String? itemCode,
    Value<int?> productCategoryId = const Value.absent(),
    bool? isSynced,
    bool? is_discount_product,
  }) => ProductMasterData(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    productName: productName ?? this.productName,
    displayName: displayName ?? this.displayName,
    imageUrl: imageUrl ?? this.imageUrl,
    salesPrice: salesPrice ?? this.salesPrice,
    itemCode: itemCode ?? this.itemCode,
    productCategoryId:
        productCategoryId.present
            ? productCategoryId.value
            : this.productCategoryId,
    isSynced: isSynced ?? this.isSynced,
    is_discount_product: is_discount_product ?? this.is_discount_product,
  );
  ProductMasterData copyWithCompanion(ProductMasterCompanion data) {
    return ProductMasterData(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      productName:
          data.productName.present ? data.productName.value : this.productName,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      salesPrice:
          data.salesPrice.present ? data.salesPrice.value : this.salesPrice,
      itemCode: data.itemCode.present ? data.itemCode.value : this.itemCode,
      productCategoryId:
          data.productCategoryId.present
              ? data.productCategoryId.value
              : this.productCategoryId,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      is_discount_product:
          data.is_discount_product.present
              ? data.is_discount_product.value
              : this.is_discount_product,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductMasterData(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('displayName: $displayName, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('salesPrice: $salesPrice, ')
          ..write('itemCode: $itemCode, ')
          ..write('productCategoryId: $productCategoryId, ')
          ..write('isSynced: $isSynced, ')
          ..write('is_discount_product: $is_discount_product')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    productName,
    displayName,
    imageUrl,
    salesPrice,
    itemCode,
    productCategoryId,
    isSynced,
    is_discount_product,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductMasterData &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.productName == this.productName &&
          other.displayName == this.displayName &&
          other.imageUrl == this.imageUrl &&
          other.salesPrice == this.salesPrice &&
          other.itemCode == this.itemCode &&
          other.productCategoryId == this.productCategoryId &&
          other.isSynced == this.isSynced &&
          other.is_discount_product == this.is_discount_product);
}

class ProductMasterCompanion extends UpdateCompanion<ProductMasterData> {
  final Value<int> id;
  final Value<int> productId;
  final Value<String> productName;
  final Value<String> displayName;
  final Value<String> imageUrl;
  final Value<double> salesPrice;
  final Value<String> itemCode;
  final Value<int?> productCategoryId;
  final Value<bool> isSynced;
  final Value<bool> is_discount_product;
  const ProductMasterCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.displayName = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.salesPrice = const Value.absent(),
    this.itemCode = const Value.absent(),
    this.productCategoryId = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.is_discount_product = const Value.absent(),
  });
  ProductMasterCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required String productName,
    required String displayName,
    required String imageUrl,
    required double salesPrice,
    required String itemCode,
    this.productCategoryId = const Value.absent(),
    this.isSynced = const Value.absent(),
    required bool is_discount_product,
  }) : productId = Value(productId),
       productName = Value(productName),
       displayName = Value(displayName),
       imageUrl = Value(imageUrl),
       salesPrice = Value(salesPrice),
       itemCode = Value(itemCode),
       is_discount_product = Value(is_discount_product);
  static Insertable<ProductMasterData> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<String>? productName,
    Expression<String>? displayName,
    Expression<String>? imageUrl,
    Expression<double>? salesPrice,
    Expression<String>? itemCode,
    Expression<int>? productCategoryId,
    Expression<bool>? isSynced,
    Expression<bool>? is_discount_product,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (productName != null) 'product_name': productName,
      if (displayName != null) 'display_name': displayName,
      if (imageUrl != null) 'image_url': imageUrl,
      if (salesPrice != null) 'sales_price': salesPrice,
      if (itemCode != null) 'item_code': itemCode,
      if (productCategoryId != null) 'product_category_id': productCategoryId,
      if (isSynced != null) 'is_synced': isSynced,
      if (is_discount_product != null)
        'is_discount_product': is_discount_product,
    });
  }

  ProductMasterCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<String>? productName,
    Value<String>? displayName,
    Value<String>? imageUrl,
    Value<double>? salesPrice,
    Value<String>? itemCode,
    Value<int?>? productCategoryId,
    Value<bool>? isSynced,
    Value<bool>? is_discount_product,
  }) {
    return ProductMasterCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      displayName: displayName ?? this.displayName,
      imageUrl: imageUrl ?? this.imageUrl,
      salesPrice: salesPrice ?? this.salesPrice,
      itemCode: itemCode ?? this.itemCode,
      productCategoryId: productCategoryId ?? this.productCategoryId,
      isSynced: isSynced ?? this.isSynced,
      is_discount_product: is_discount_product ?? this.is_discount_product,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
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
    if (productCategoryId.present) {
      map['product_category_id'] = Variable<int>(productCategoryId.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (is_discount_product.present) {
      map['is_discount_product'] = Variable<bool>(is_discount_product.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductMasterCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('displayName: $displayName, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('salesPrice: $salesPrice, ')
          ..write('itemCode: $itemCode, ')
          ..write('productCategoryId: $productCategoryId, ')
          ..write('isSynced: $isSynced, ')
          ..write('is_discount_product: $is_discount_product')
          ..write(')'))
        .toString();
  }
}

class $OrderProductUsageTable extends OrderProductUsage
    with TableInfo<$OrderProductUsageTable, OrderProductUsageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderProductUsageTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _odooIdMeta = const VerificationMeta('odooId');
  @override
  late final GeneratedColumn<int> odooId = GeneratedColumn<int>(
    'odoo_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
  static const VerificationMeta _is_rewardMeta = const VerificationMeta(
    'is_reward',
  );
  @override
  late final GeneratedColumn<bool> is_reward = GeneratedColumn<bool>(
    'is_reward',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_reward" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isFreeProductMeta = const VerificationMeta(
    'isFreeProduct',
  );
  @override
  late final GeneratedColumn<bool> isFreeProduct = GeneratedColumn<bool>(
    'is_free_product',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_free_product" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDiscountProductMeta = const VerificationMeta(
    'isDiscountProduct',
  );
  @override
  late final GeneratedColumn<bool> isDiscountProduct = GeneratedColumn<bool>(
    'is_discount_product',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_discount_product" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _displayDiscountProductMeta =
      const VerificationMeta('displayDiscountProduct');
  @override
  late final GeneratedColumn<String> displayDiscountProduct =
      GeneratedColumn<String>(
        'display_discount_product',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(""),
      );
  static const VerificationMeta _discountProductPriceMeta =
      const VerificationMeta('discountProductPrice');
  @override
  late final GeneratedColumn<double> discountProductPrice =
      GeneratedColumn<double>(
        'discount_product_price',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _discountPercentageMeta =
      const VerificationMeta('discountPercentage');
  @override
  late final GeneratedColumn<double> discountPercentage =
      GeneratedColumn<double>(
        'discount_percentage',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _stock_lot_idMeta = const VerificationMeta(
    'stock_lot_id',
  );
  @override
  late final GeneratedColumn<int> stock_lot_id = GeneratedColumn<int>(
    'stock_lot_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _reward_amountMeta = const VerificationMeta(
    'reward_amount',
  );
  @override
  late final GeneratedColumn<double> reward_amount = GeneratedColumn<double>(
    'reward_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
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
    odooId,
    itineraryLineId,
    productId,
    is_reward,
    isFreeProduct,
    isDiscountProduct,
    displayDiscountProduct,
    discountProductPrice,
    discountPercentage,
    stock_lot_id,
    reward_amount,
    adQty,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_product_usage';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrderProductUsageData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('odoo_id')) {
      context.handle(
        _odooIdMeta,
        odooId.isAcceptableOrUnknown(data['odoo_id']!, _odooIdMeta),
      );
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
    if (data.containsKey('is_reward')) {
      context.handle(
        _is_rewardMeta,
        is_reward.isAcceptableOrUnknown(data['is_reward']!, _is_rewardMeta),
      );
    }
    if (data.containsKey('is_free_product')) {
      context.handle(
        _isFreeProductMeta,
        isFreeProduct.isAcceptableOrUnknown(
          data['is_free_product']!,
          _isFreeProductMeta,
        ),
      );
    }
    if (data.containsKey('is_discount_product')) {
      context.handle(
        _isDiscountProductMeta,
        isDiscountProduct.isAcceptableOrUnknown(
          data['is_discount_product']!,
          _isDiscountProductMeta,
        ),
      );
    }
    if (data.containsKey('display_discount_product')) {
      context.handle(
        _displayDiscountProductMeta,
        displayDiscountProduct.isAcceptableOrUnknown(
          data['display_discount_product']!,
          _displayDiscountProductMeta,
        ),
      );
    }
    if (data.containsKey('discount_product_price')) {
      context.handle(
        _discountProductPriceMeta,
        discountProductPrice.isAcceptableOrUnknown(
          data['discount_product_price']!,
          _discountProductPriceMeta,
        ),
      );
    }
    if (data.containsKey('discount_percentage')) {
      context.handle(
        _discountPercentageMeta,
        discountPercentage.isAcceptableOrUnknown(
          data['discount_percentage']!,
          _discountPercentageMeta,
        ),
      );
    }
    if (data.containsKey('stock_lot_id')) {
      context.handle(
        _stock_lot_idMeta,
        stock_lot_id.isAcceptableOrUnknown(
          data['stock_lot_id']!,
          _stock_lot_idMeta,
        ),
      );
    }
    if (data.containsKey('reward_amount')) {
      context.handle(
        _reward_amountMeta,
        reward_amount.isAcceptableOrUnknown(
          data['reward_amount']!,
          _reward_amountMeta,
        ),
      );
    }
    if (data.containsKey('ad_qty')) {
      context.handle(
        _adQtyMeta,
        adQty.isAcceptableOrUnknown(data['ad_qty']!, _adQtyMeta),
      );
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
  OrderProductUsageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderProductUsageData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      odooId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}odoo_id'],
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
      is_reward:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_reward'],
          )!,
      isFreeProduct:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_free_product'],
          )!,
      isDiscountProduct:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_discount_product'],
          )!,
      displayDiscountProduct:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}display_discount_product'],
          )!,
      discountProductPrice:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}discount_product_price'],
          )!,
      discountPercentage:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}discount_percentage'],
          )!,
      stock_lot_id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}stock_lot_id'],
          )!,
      reward_amount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}reward_amount'],
          )!,
      adQty:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}ad_qty'],
          )!,
      isSynced:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_synced'],
          )!,
    );
  }

  @override
  $OrderProductUsageTable createAlias(String alias) {
    return $OrderProductUsageTable(attachedDatabase, alias);
  }
}

class OrderProductUsageData extends DataClass
    implements Insertable<OrderProductUsageData> {
  final int id;
  final int odooId;
  final int itineraryLineId;
  final int productId;
  final bool is_reward;
  final bool isFreeProduct;
  final bool isDiscountProduct;
  final String displayDiscountProduct;
  final double discountProductPrice;
  final double discountPercentage;
  final int stock_lot_id;
  final double reward_amount;
  final int adQty;
  final bool isSynced;
  const OrderProductUsageData({
    required this.id,
    required this.odooId,
    required this.itineraryLineId,
    required this.productId,
    required this.is_reward,
    required this.isFreeProduct,
    required this.isDiscountProduct,
    required this.displayDiscountProduct,
    required this.discountProductPrice,
    required this.discountPercentage,
    required this.stock_lot_id,
    required this.reward_amount,
    required this.adQty,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['odoo_id'] = Variable<int>(odooId);
    map['itinerary_line_id'] = Variable<int>(itineraryLineId);
    map['product_id'] = Variable<int>(productId);
    map['is_reward'] = Variable<bool>(is_reward);
    map['is_free_product'] = Variable<bool>(isFreeProduct);
    map['is_discount_product'] = Variable<bool>(isDiscountProduct);
    map['display_discount_product'] = Variable<String>(displayDiscountProduct);
    map['discount_product_price'] = Variable<double>(discountProductPrice);
    map['discount_percentage'] = Variable<double>(discountPercentage);
    map['stock_lot_id'] = Variable<int>(stock_lot_id);
    map['reward_amount'] = Variable<double>(reward_amount);
    map['ad_qty'] = Variable<int>(adQty);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  OrderProductUsageCompanion toCompanion(bool nullToAbsent) {
    return OrderProductUsageCompanion(
      id: Value(id),
      odooId: Value(odooId),
      itineraryLineId: Value(itineraryLineId),
      productId: Value(productId),
      is_reward: Value(is_reward),
      isFreeProduct: Value(isFreeProduct),
      isDiscountProduct: Value(isDiscountProduct),
      displayDiscountProduct: Value(displayDiscountProduct),
      discountProductPrice: Value(discountProductPrice),
      discountPercentage: Value(discountPercentage),
      stock_lot_id: Value(stock_lot_id),
      reward_amount: Value(reward_amount),
      adQty: Value(adQty),
      isSynced: Value(isSynced),
    );
  }

  factory OrderProductUsageData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderProductUsageData(
      id: serializer.fromJson<int>(json['id']),
      odooId: serializer.fromJson<int>(json['odooId']),
      itineraryLineId: serializer.fromJson<int>(json['itineraryLineId']),
      productId: serializer.fromJson<int>(json['productId']),
      is_reward: serializer.fromJson<bool>(json['is_reward']),
      isFreeProduct: serializer.fromJson<bool>(json['isFreeProduct']),
      isDiscountProduct: serializer.fromJson<bool>(json['isDiscountProduct']),
      displayDiscountProduct: serializer.fromJson<String>(
        json['displayDiscountProduct'],
      ),
      discountProductPrice: serializer.fromJson<double>(
        json['discountProductPrice'],
      ),
      discountPercentage: serializer.fromJson<double>(
        json['discountPercentage'],
      ),
      stock_lot_id: serializer.fromJson<int>(json['stock_lot_id']),
      reward_amount: serializer.fromJson<double>(json['reward_amount']),
      adQty: serializer.fromJson<int>(json['adQty']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'odooId': serializer.toJson<int>(odooId),
      'itineraryLineId': serializer.toJson<int>(itineraryLineId),
      'productId': serializer.toJson<int>(productId),
      'is_reward': serializer.toJson<bool>(is_reward),
      'isFreeProduct': serializer.toJson<bool>(isFreeProduct),
      'isDiscountProduct': serializer.toJson<bool>(isDiscountProduct),
      'displayDiscountProduct': serializer.toJson<String>(
        displayDiscountProduct,
      ),
      'discountProductPrice': serializer.toJson<double>(discountProductPrice),
      'discountPercentage': serializer.toJson<double>(discountPercentage),
      'stock_lot_id': serializer.toJson<int>(stock_lot_id),
      'reward_amount': serializer.toJson<double>(reward_amount),
      'adQty': serializer.toJson<int>(adQty),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  OrderProductUsageData copyWith({
    int? id,
    int? odooId,
    int? itineraryLineId,
    int? productId,
    bool? is_reward,
    bool? isFreeProduct,
    bool? isDiscountProduct,
    String? displayDiscountProduct,
    double? discountProductPrice,
    double? discountPercentage,
    int? stock_lot_id,
    double? reward_amount,
    int? adQty,
    bool? isSynced,
  }) => OrderProductUsageData(
    id: id ?? this.id,
    odooId: odooId ?? this.odooId,
    itineraryLineId: itineraryLineId ?? this.itineraryLineId,
    productId: productId ?? this.productId,
    is_reward: is_reward ?? this.is_reward,
    isFreeProduct: isFreeProduct ?? this.isFreeProduct,
    isDiscountProduct: isDiscountProduct ?? this.isDiscountProduct,
    displayDiscountProduct:
        displayDiscountProduct ?? this.displayDiscountProduct,
    discountProductPrice: discountProductPrice ?? this.discountProductPrice,
    discountPercentage: discountPercentage ?? this.discountPercentage,
    stock_lot_id: stock_lot_id ?? this.stock_lot_id,
    reward_amount: reward_amount ?? this.reward_amount,
    adQty: adQty ?? this.adQty,
    isSynced: isSynced ?? this.isSynced,
  );
  OrderProductUsageData copyWithCompanion(OrderProductUsageCompanion data) {
    return OrderProductUsageData(
      id: data.id.present ? data.id.value : this.id,
      odooId: data.odooId.present ? data.odooId.value : this.odooId,
      itineraryLineId:
          data.itineraryLineId.present
              ? data.itineraryLineId.value
              : this.itineraryLineId,
      productId: data.productId.present ? data.productId.value : this.productId,
      is_reward: data.is_reward.present ? data.is_reward.value : this.is_reward,
      isFreeProduct:
          data.isFreeProduct.present
              ? data.isFreeProduct.value
              : this.isFreeProduct,
      isDiscountProduct:
          data.isDiscountProduct.present
              ? data.isDiscountProduct.value
              : this.isDiscountProduct,
      displayDiscountProduct:
          data.displayDiscountProduct.present
              ? data.displayDiscountProduct.value
              : this.displayDiscountProduct,
      discountProductPrice:
          data.discountProductPrice.present
              ? data.discountProductPrice.value
              : this.discountProductPrice,
      discountPercentage:
          data.discountPercentage.present
              ? data.discountPercentage.value
              : this.discountPercentage,
      stock_lot_id:
          data.stock_lot_id.present
              ? data.stock_lot_id.value
              : this.stock_lot_id,
      reward_amount:
          data.reward_amount.present
              ? data.reward_amount.value
              : this.reward_amount,
      adQty: data.adQty.present ? data.adQty.value : this.adQty,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderProductUsageData(')
          ..write('id: $id, ')
          ..write('odooId: $odooId, ')
          ..write('itineraryLineId: $itineraryLineId, ')
          ..write('productId: $productId, ')
          ..write('is_reward: $is_reward, ')
          ..write('isFreeProduct: $isFreeProduct, ')
          ..write('isDiscountProduct: $isDiscountProduct, ')
          ..write('displayDiscountProduct: $displayDiscountProduct, ')
          ..write('discountProductPrice: $discountProductPrice, ')
          ..write('discountPercentage: $discountPercentage, ')
          ..write('stock_lot_id: $stock_lot_id, ')
          ..write('reward_amount: $reward_amount, ')
          ..write('adQty: $adQty, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    odooId,
    itineraryLineId,
    productId,
    is_reward,
    isFreeProduct,
    isDiscountProduct,
    displayDiscountProduct,
    discountProductPrice,
    discountPercentage,
    stock_lot_id,
    reward_amount,
    adQty,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderProductUsageData &&
          other.id == this.id &&
          other.odooId == this.odooId &&
          other.itineraryLineId == this.itineraryLineId &&
          other.productId == this.productId &&
          other.is_reward == this.is_reward &&
          other.isFreeProduct == this.isFreeProduct &&
          other.isDiscountProduct == this.isDiscountProduct &&
          other.displayDiscountProduct == this.displayDiscountProduct &&
          other.discountProductPrice == this.discountProductPrice &&
          other.discountPercentage == this.discountPercentage &&
          other.stock_lot_id == this.stock_lot_id &&
          other.reward_amount == this.reward_amount &&
          other.adQty == this.adQty &&
          other.isSynced == this.isSynced);
}

class OrderProductUsageCompanion
    extends UpdateCompanion<OrderProductUsageData> {
  final Value<int> id;
  final Value<int> odooId;
  final Value<int> itineraryLineId;
  final Value<int> productId;
  final Value<bool> is_reward;
  final Value<bool> isFreeProduct;
  final Value<bool> isDiscountProduct;
  final Value<String> displayDiscountProduct;
  final Value<double> discountProductPrice;
  final Value<double> discountPercentage;
  final Value<int> stock_lot_id;
  final Value<double> reward_amount;
  final Value<int> adQty;
  final Value<bool> isSynced;
  const OrderProductUsageCompanion({
    this.id = const Value.absent(),
    this.odooId = const Value.absent(),
    this.itineraryLineId = const Value.absent(),
    this.productId = const Value.absent(),
    this.is_reward = const Value.absent(),
    this.isFreeProduct = const Value.absent(),
    this.isDiscountProduct = const Value.absent(),
    this.displayDiscountProduct = const Value.absent(),
    this.discountProductPrice = const Value.absent(),
    this.discountPercentage = const Value.absent(),
    this.stock_lot_id = const Value.absent(),
    this.reward_amount = const Value.absent(),
    this.adQty = const Value.absent(),
    this.isSynced = const Value.absent(),
  });
  OrderProductUsageCompanion.insert({
    this.id = const Value.absent(),
    this.odooId = const Value.absent(),
    required int itineraryLineId,
    required int productId,
    this.is_reward = const Value.absent(),
    this.isFreeProduct = const Value.absent(),
    this.isDiscountProduct = const Value.absent(),
    this.displayDiscountProduct = const Value.absent(),
    this.discountProductPrice = const Value.absent(),
    this.discountPercentage = const Value.absent(),
    this.stock_lot_id = const Value.absent(),
    this.reward_amount = const Value.absent(),
    this.adQty = const Value.absent(),
    this.isSynced = const Value.absent(),
  }) : itineraryLineId = Value(itineraryLineId),
       productId = Value(productId);
  static Insertable<OrderProductUsageData> custom({
    Expression<int>? id,
    Expression<int>? odooId,
    Expression<int>? itineraryLineId,
    Expression<int>? productId,
    Expression<bool>? is_reward,
    Expression<bool>? isFreeProduct,
    Expression<bool>? isDiscountProduct,
    Expression<String>? displayDiscountProduct,
    Expression<double>? discountProductPrice,
    Expression<double>? discountPercentage,
    Expression<int>? stock_lot_id,
    Expression<double>? reward_amount,
    Expression<int>? adQty,
    Expression<bool>? isSynced,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (odooId != null) 'odoo_id': odooId,
      if (itineraryLineId != null) 'itinerary_line_id': itineraryLineId,
      if (productId != null) 'product_id': productId,
      if (is_reward != null) 'is_reward': is_reward,
      if (isFreeProduct != null) 'is_free_product': isFreeProduct,
      if (isDiscountProduct != null) 'is_discount_product': isDiscountProduct,
      if (displayDiscountProduct != null)
        'display_discount_product': displayDiscountProduct,
      if (discountProductPrice != null)
        'discount_product_price': discountProductPrice,
      if (discountPercentage != null) 'discount_percentage': discountPercentage,
      if (stock_lot_id != null) 'stock_lot_id': stock_lot_id,
      if (reward_amount != null) 'reward_amount': reward_amount,
      if (adQty != null) 'ad_qty': adQty,
      if (isSynced != null) 'is_synced': isSynced,
    });
  }

  OrderProductUsageCompanion copyWith({
    Value<int>? id,
    Value<int>? odooId,
    Value<int>? itineraryLineId,
    Value<int>? productId,
    Value<bool>? is_reward,
    Value<bool>? isFreeProduct,
    Value<bool>? isDiscountProduct,
    Value<String>? displayDiscountProduct,
    Value<double>? discountProductPrice,
    Value<double>? discountPercentage,
    Value<int>? stock_lot_id,
    Value<double>? reward_amount,
    Value<int>? adQty,
    Value<bool>? isSynced,
  }) {
    return OrderProductUsageCompanion(
      id: id ?? this.id,
      odooId: odooId ?? this.odooId,
      itineraryLineId: itineraryLineId ?? this.itineraryLineId,
      productId: productId ?? this.productId,
      is_reward: is_reward ?? this.is_reward,
      isFreeProduct: isFreeProduct ?? this.isFreeProduct,
      isDiscountProduct: isDiscountProduct ?? this.isDiscountProduct,
      displayDiscountProduct:
          displayDiscountProduct ?? this.displayDiscountProduct,
      discountProductPrice: discountProductPrice ?? this.discountProductPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      stock_lot_id: stock_lot_id ?? this.stock_lot_id,
      reward_amount: reward_amount ?? this.reward_amount,
      adQty: adQty ?? this.adQty,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (odooId.present) {
      map['odoo_id'] = Variable<int>(odooId.value);
    }
    if (itineraryLineId.present) {
      map['itinerary_line_id'] = Variable<int>(itineraryLineId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (is_reward.present) {
      map['is_reward'] = Variable<bool>(is_reward.value);
    }
    if (isFreeProduct.present) {
      map['is_free_product'] = Variable<bool>(isFreeProduct.value);
    }
    if (isDiscountProduct.present) {
      map['is_discount_product'] = Variable<bool>(isDiscountProduct.value);
    }
    if (displayDiscountProduct.present) {
      map['display_discount_product'] = Variable<String>(
        displayDiscountProduct.value,
      );
    }
    if (discountProductPrice.present) {
      map['discount_product_price'] = Variable<double>(
        discountProductPrice.value,
      );
    }
    if (discountPercentage.present) {
      map['discount_percentage'] = Variable<double>(discountPercentage.value);
    }
    if (stock_lot_id.present) {
      map['stock_lot_id'] = Variable<int>(stock_lot_id.value);
    }
    if (reward_amount.present) {
      map['reward_amount'] = Variable<double>(reward_amount.value);
    }
    if (adQty.present) {
      map['ad_qty'] = Variable<int>(adQty.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderProductUsageCompanion(')
          ..write('id: $id, ')
          ..write('odooId: $odooId, ')
          ..write('itineraryLineId: $itineraryLineId, ')
          ..write('productId: $productId, ')
          ..write('is_reward: $is_reward, ')
          ..write('isFreeProduct: $isFreeProduct, ')
          ..write('isDiscountProduct: $isDiscountProduct, ')
          ..write('displayDiscountProduct: $displayDiscountProduct, ')
          ..write('discountProductPrice: $discountProductPrice, ')
          ..write('discountPercentage: $discountPercentage, ')
          ..write('stock_lot_id: $stock_lot_id, ')
          ..write('reward_amount: $reward_amount, ')
          ..write('adQty: $adQty, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }
}

class $ReturnProductUsageTable extends ReturnProductUsage
    with TableInfo<$ReturnProductUsageTable, ReturnProductUsageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReturnProductUsageTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _odooIdMeta = const VerificationMeta('odooId');
  @override
  late final GeneratedColumn<int> odooId = GeneratedColumn<int>(
    'odoo_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
  static const VerificationMeta _return_reasonMeta = const VerificationMeta(
    'return_reason',
  );
  @override
  late final GeneratedColumn<String> return_reason = GeneratedColumn<String>(
    'return_reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(""),
  );
  static const VerificationMeta _return_invoices_display_nameMeta =
      const VerificationMeta('return_invoices_display_name');
  @override
  late final GeneratedColumn<String> return_invoices_display_name =
      GeneratedColumn<String>(
        'return_invoices_display_name',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(""),
      );
  static const VerificationMeta _invoiceSalesPriceMeta = const VerificationMeta(
    'invoiceSalesPrice',
  );
  @override
  late final GeneratedColumn<double> invoiceSalesPrice =
      GeneratedColumn<double>(
        'invoice_sales_price',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _returnQtyMeta = const VerificationMeta(
    'returnQty',
  );
  @override
  late final GeneratedColumn<int> returnQty = GeneratedColumn<int>(
    'return_qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
  static const VerificationMeta _return_reason_idMeta = const VerificationMeta(
    'return_reason_id',
  );
  @override
  late final GeneratedColumn<int> return_reason_id = GeneratedColumn<int>(
    'return_reason_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _return_action_idMeta = const VerificationMeta(
    'return_action_id',
  );
  @override
  late final GeneratedColumn<int> return_action_id = GeneratedColumn<int>(
    'return_action_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isAddedInvoicesReturnMeta =
      const VerificationMeta('isAddedInvoicesReturn');
  @override
  late final GeneratedColumn<bool> isAddedInvoicesReturn =
      GeneratedColumn<bool>(
        'is_added_invoices_return',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_added_invoices_return" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    odooId,
    itineraryLineId,
    productId,
    return_reason,
    return_invoices_display_name,
    invoiceSalesPrice,
    returnQty,
    isSynced,
    return_reason_id,
    return_action_id,
    isAddedInvoicesReturn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'return_product_usage';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReturnProductUsageData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('odoo_id')) {
      context.handle(
        _odooIdMeta,
        odooId.isAcceptableOrUnknown(data['odoo_id']!, _odooIdMeta),
      );
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
    if (data.containsKey('return_reason')) {
      context.handle(
        _return_reasonMeta,
        return_reason.isAcceptableOrUnknown(
          data['return_reason']!,
          _return_reasonMeta,
        ),
      );
    }
    if (data.containsKey('return_invoices_display_name')) {
      context.handle(
        _return_invoices_display_nameMeta,
        return_invoices_display_name.isAcceptableOrUnknown(
          data['return_invoices_display_name']!,
          _return_invoices_display_nameMeta,
        ),
      );
    }
    if (data.containsKey('invoice_sales_price')) {
      context.handle(
        _invoiceSalesPriceMeta,
        invoiceSalesPrice.isAcceptableOrUnknown(
          data['invoice_sales_price']!,
          _invoiceSalesPriceMeta,
        ),
      );
    }
    if (data.containsKey('return_qty')) {
      context.handle(
        _returnQtyMeta,
        returnQty.isAcceptableOrUnknown(data['return_qty']!, _returnQtyMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('return_reason_id')) {
      context.handle(
        _return_reason_idMeta,
        return_reason_id.isAcceptableOrUnknown(
          data['return_reason_id']!,
          _return_reason_idMeta,
        ),
      );
    }
    if (data.containsKey('return_action_id')) {
      context.handle(
        _return_action_idMeta,
        return_action_id.isAcceptableOrUnknown(
          data['return_action_id']!,
          _return_action_idMeta,
        ),
      );
    }
    if (data.containsKey('is_added_invoices_return')) {
      context.handle(
        _isAddedInvoicesReturnMeta,
        isAddedInvoicesReturn.isAcceptableOrUnknown(
          data['is_added_invoices_return']!,
          _isAddedInvoicesReturnMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReturnProductUsageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReturnProductUsageData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      odooId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}odoo_id'],
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
      return_reason:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}return_reason'],
          )!,
      return_invoices_display_name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}return_invoices_display_name'],
          )!,
      invoiceSalesPrice:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}invoice_sales_price'],
          )!,
      returnQty:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}return_qty'],
          )!,
      isSynced:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_synced'],
          )!,
      return_reason_id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}return_reason_id'],
          )!,
      return_action_id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}return_action_id'],
          )!,
      isAddedInvoicesReturn:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_added_invoices_return'],
          )!,
    );
  }

  @override
  $ReturnProductUsageTable createAlias(String alias) {
    return $ReturnProductUsageTable(attachedDatabase, alias);
  }
}

class ReturnProductUsageData extends DataClass
    implements Insertable<ReturnProductUsageData> {
  final int id;
  final int odooId;
  final int itineraryLineId;
  final int productId;
  final String return_reason;
  final String return_invoices_display_name;
  final double invoiceSalesPrice;
  final int returnQty;
  final bool isSynced;
  final int return_reason_id;
  final int return_action_id;
  final bool isAddedInvoicesReturn;
  const ReturnProductUsageData({
    required this.id,
    required this.odooId,
    required this.itineraryLineId,
    required this.productId,
    required this.return_reason,
    required this.return_invoices_display_name,
    required this.invoiceSalesPrice,
    required this.returnQty,
    required this.isSynced,
    required this.return_reason_id,
    required this.return_action_id,
    required this.isAddedInvoicesReturn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['odoo_id'] = Variable<int>(odooId);
    map['itinerary_line_id'] = Variable<int>(itineraryLineId);
    map['product_id'] = Variable<int>(productId);
    map['return_reason'] = Variable<String>(return_reason);
    map['return_invoices_display_name'] = Variable<String>(
      return_invoices_display_name,
    );
    map['invoice_sales_price'] = Variable<double>(invoiceSalesPrice);
    map['return_qty'] = Variable<int>(returnQty);
    map['is_synced'] = Variable<bool>(isSynced);
    map['return_reason_id'] = Variable<int>(return_reason_id);
    map['return_action_id'] = Variable<int>(return_action_id);
    map['is_added_invoices_return'] = Variable<bool>(isAddedInvoicesReturn);
    return map;
  }

  ReturnProductUsageCompanion toCompanion(bool nullToAbsent) {
    return ReturnProductUsageCompanion(
      id: Value(id),
      odooId: Value(odooId),
      itineraryLineId: Value(itineraryLineId),
      productId: Value(productId),
      return_reason: Value(return_reason),
      return_invoices_display_name: Value(return_invoices_display_name),
      invoiceSalesPrice: Value(invoiceSalesPrice),
      returnQty: Value(returnQty),
      isSynced: Value(isSynced),
      return_reason_id: Value(return_reason_id),
      return_action_id: Value(return_action_id),
      isAddedInvoicesReturn: Value(isAddedInvoicesReturn),
    );
  }

  factory ReturnProductUsageData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReturnProductUsageData(
      id: serializer.fromJson<int>(json['id']),
      odooId: serializer.fromJson<int>(json['odooId']),
      itineraryLineId: serializer.fromJson<int>(json['itineraryLineId']),
      productId: serializer.fromJson<int>(json['productId']),
      return_reason: serializer.fromJson<String>(json['return_reason']),
      return_invoices_display_name: serializer.fromJson<String>(
        json['return_invoices_display_name'],
      ),
      invoiceSalesPrice: serializer.fromJson<double>(json['invoiceSalesPrice']),
      returnQty: serializer.fromJson<int>(json['returnQty']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      return_reason_id: serializer.fromJson<int>(json['return_reason_id']),
      return_action_id: serializer.fromJson<int>(json['return_action_id']),
      isAddedInvoicesReturn: serializer.fromJson<bool>(
        json['isAddedInvoicesReturn'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'odooId': serializer.toJson<int>(odooId),
      'itineraryLineId': serializer.toJson<int>(itineraryLineId),
      'productId': serializer.toJson<int>(productId),
      'return_reason': serializer.toJson<String>(return_reason),
      'return_invoices_display_name': serializer.toJson<String>(
        return_invoices_display_name,
      ),
      'invoiceSalesPrice': serializer.toJson<double>(invoiceSalesPrice),
      'returnQty': serializer.toJson<int>(returnQty),
      'isSynced': serializer.toJson<bool>(isSynced),
      'return_reason_id': serializer.toJson<int>(return_reason_id),
      'return_action_id': serializer.toJson<int>(return_action_id),
      'isAddedInvoicesReturn': serializer.toJson<bool>(isAddedInvoicesReturn),
    };
  }

  ReturnProductUsageData copyWith({
    int? id,
    int? odooId,
    int? itineraryLineId,
    int? productId,
    String? return_reason,
    String? return_invoices_display_name,
    double? invoiceSalesPrice,
    int? returnQty,
    bool? isSynced,
    int? return_reason_id,
    int? return_action_id,
    bool? isAddedInvoicesReturn,
  }) => ReturnProductUsageData(
    id: id ?? this.id,
    odooId: odooId ?? this.odooId,
    itineraryLineId: itineraryLineId ?? this.itineraryLineId,
    productId: productId ?? this.productId,
    return_reason: return_reason ?? this.return_reason,
    return_invoices_display_name:
        return_invoices_display_name ?? this.return_invoices_display_name,
    invoiceSalesPrice: invoiceSalesPrice ?? this.invoiceSalesPrice,
    returnQty: returnQty ?? this.returnQty,
    isSynced: isSynced ?? this.isSynced,
    return_reason_id: return_reason_id ?? this.return_reason_id,
    return_action_id: return_action_id ?? this.return_action_id,
    isAddedInvoicesReturn: isAddedInvoicesReturn ?? this.isAddedInvoicesReturn,
  );
  ReturnProductUsageData copyWithCompanion(ReturnProductUsageCompanion data) {
    return ReturnProductUsageData(
      id: data.id.present ? data.id.value : this.id,
      odooId: data.odooId.present ? data.odooId.value : this.odooId,
      itineraryLineId:
          data.itineraryLineId.present
              ? data.itineraryLineId.value
              : this.itineraryLineId,
      productId: data.productId.present ? data.productId.value : this.productId,
      return_reason:
          data.return_reason.present
              ? data.return_reason.value
              : this.return_reason,
      return_invoices_display_name:
          data.return_invoices_display_name.present
              ? data.return_invoices_display_name.value
              : this.return_invoices_display_name,
      invoiceSalesPrice:
          data.invoiceSalesPrice.present
              ? data.invoiceSalesPrice.value
              : this.invoiceSalesPrice,
      returnQty: data.returnQty.present ? data.returnQty.value : this.returnQty,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      return_reason_id:
          data.return_reason_id.present
              ? data.return_reason_id.value
              : this.return_reason_id,
      return_action_id:
          data.return_action_id.present
              ? data.return_action_id.value
              : this.return_action_id,
      isAddedInvoicesReturn:
          data.isAddedInvoicesReturn.present
              ? data.isAddedInvoicesReturn.value
              : this.isAddedInvoicesReturn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReturnProductUsageData(')
          ..write('id: $id, ')
          ..write('odooId: $odooId, ')
          ..write('itineraryLineId: $itineraryLineId, ')
          ..write('productId: $productId, ')
          ..write('return_reason: $return_reason, ')
          ..write(
            'return_invoices_display_name: $return_invoices_display_name, ',
          )
          ..write('invoiceSalesPrice: $invoiceSalesPrice, ')
          ..write('returnQty: $returnQty, ')
          ..write('isSynced: $isSynced, ')
          ..write('return_reason_id: $return_reason_id, ')
          ..write('return_action_id: $return_action_id, ')
          ..write('isAddedInvoicesReturn: $isAddedInvoicesReturn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    odooId,
    itineraryLineId,
    productId,
    return_reason,
    return_invoices_display_name,
    invoiceSalesPrice,
    returnQty,
    isSynced,
    return_reason_id,
    return_action_id,
    isAddedInvoicesReturn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReturnProductUsageData &&
          other.id == this.id &&
          other.odooId == this.odooId &&
          other.itineraryLineId == this.itineraryLineId &&
          other.productId == this.productId &&
          other.return_reason == this.return_reason &&
          other.return_invoices_display_name ==
              this.return_invoices_display_name &&
          other.invoiceSalesPrice == this.invoiceSalesPrice &&
          other.returnQty == this.returnQty &&
          other.isSynced == this.isSynced &&
          other.return_reason_id == this.return_reason_id &&
          other.return_action_id == this.return_action_id &&
          other.isAddedInvoicesReturn == this.isAddedInvoicesReturn);
}

class ReturnProductUsageCompanion
    extends UpdateCompanion<ReturnProductUsageData> {
  final Value<int> id;
  final Value<int> odooId;
  final Value<int> itineraryLineId;
  final Value<int> productId;
  final Value<String> return_reason;
  final Value<String> return_invoices_display_name;
  final Value<double> invoiceSalesPrice;
  final Value<int> returnQty;
  final Value<bool> isSynced;
  final Value<int> return_reason_id;
  final Value<int> return_action_id;
  final Value<bool> isAddedInvoicesReturn;
  const ReturnProductUsageCompanion({
    this.id = const Value.absent(),
    this.odooId = const Value.absent(),
    this.itineraryLineId = const Value.absent(),
    this.productId = const Value.absent(),
    this.return_reason = const Value.absent(),
    this.return_invoices_display_name = const Value.absent(),
    this.invoiceSalesPrice = const Value.absent(),
    this.returnQty = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.return_reason_id = const Value.absent(),
    this.return_action_id = const Value.absent(),
    this.isAddedInvoicesReturn = const Value.absent(),
  });
  ReturnProductUsageCompanion.insert({
    this.id = const Value.absent(),
    this.odooId = const Value.absent(),
    required int itineraryLineId,
    required int productId,
    this.return_reason = const Value.absent(),
    this.return_invoices_display_name = const Value.absent(),
    this.invoiceSalesPrice = const Value.absent(),
    this.returnQty = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.return_reason_id = const Value.absent(),
    this.return_action_id = const Value.absent(),
    this.isAddedInvoicesReturn = const Value.absent(),
  }) : itineraryLineId = Value(itineraryLineId),
       productId = Value(productId);
  static Insertable<ReturnProductUsageData> custom({
    Expression<int>? id,
    Expression<int>? odooId,
    Expression<int>? itineraryLineId,
    Expression<int>? productId,
    Expression<String>? return_reason,
    Expression<String>? return_invoices_display_name,
    Expression<double>? invoiceSalesPrice,
    Expression<int>? returnQty,
    Expression<bool>? isSynced,
    Expression<int>? return_reason_id,
    Expression<int>? return_action_id,
    Expression<bool>? isAddedInvoicesReturn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (odooId != null) 'odoo_id': odooId,
      if (itineraryLineId != null) 'itinerary_line_id': itineraryLineId,
      if (productId != null) 'product_id': productId,
      if (return_reason != null) 'return_reason': return_reason,
      if (return_invoices_display_name != null)
        'return_invoices_display_name': return_invoices_display_name,
      if (invoiceSalesPrice != null) 'invoice_sales_price': invoiceSalesPrice,
      if (returnQty != null) 'return_qty': returnQty,
      if (isSynced != null) 'is_synced': isSynced,
      if (return_reason_id != null) 'return_reason_id': return_reason_id,
      if (return_action_id != null) 'return_action_id': return_action_id,
      if (isAddedInvoicesReturn != null)
        'is_added_invoices_return': isAddedInvoicesReturn,
    });
  }

  ReturnProductUsageCompanion copyWith({
    Value<int>? id,
    Value<int>? odooId,
    Value<int>? itineraryLineId,
    Value<int>? productId,
    Value<String>? return_reason,
    Value<String>? return_invoices_display_name,
    Value<double>? invoiceSalesPrice,
    Value<int>? returnQty,
    Value<bool>? isSynced,
    Value<int>? return_reason_id,
    Value<int>? return_action_id,
    Value<bool>? isAddedInvoicesReturn,
  }) {
    return ReturnProductUsageCompanion(
      id: id ?? this.id,
      odooId: odooId ?? this.odooId,
      itineraryLineId: itineraryLineId ?? this.itineraryLineId,
      productId: productId ?? this.productId,
      return_reason: return_reason ?? this.return_reason,
      return_invoices_display_name:
          return_invoices_display_name ?? this.return_invoices_display_name,
      invoiceSalesPrice: invoiceSalesPrice ?? this.invoiceSalesPrice,
      returnQty: returnQty ?? this.returnQty,
      isSynced: isSynced ?? this.isSynced,
      return_reason_id: return_reason_id ?? this.return_reason_id,
      return_action_id: return_action_id ?? this.return_action_id,
      isAddedInvoicesReturn:
          isAddedInvoicesReturn ?? this.isAddedInvoicesReturn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (odooId.present) {
      map['odoo_id'] = Variable<int>(odooId.value);
    }
    if (itineraryLineId.present) {
      map['itinerary_line_id'] = Variable<int>(itineraryLineId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (return_reason.present) {
      map['return_reason'] = Variable<String>(return_reason.value);
    }
    if (return_invoices_display_name.present) {
      map['return_invoices_display_name'] = Variable<String>(
        return_invoices_display_name.value,
      );
    }
    if (invoiceSalesPrice.present) {
      map['invoice_sales_price'] = Variable<double>(invoiceSalesPrice.value);
    }
    if (returnQty.present) {
      map['return_qty'] = Variable<int>(returnQty.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (return_reason_id.present) {
      map['return_reason_id'] = Variable<int>(return_reason_id.value);
    }
    if (return_action_id.present) {
      map['return_action_id'] = Variable<int>(return_action_id.value);
    }
    if (isAddedInvoicesReturn.present) {
      map['is_added_invoices_return'] = Variable<bool>(
        isAddedInvoicesReturn.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReturnProductUsageCompanion(')
          ..write('id: $id, ')
          ..write('odooId: $odooId, ')
          ..write('itineraryLineId: $itineraryLineId, ')
          ..write('productId: $productId, ')
          ..write('return_reason: $return_reason, ')
          ..write(
            'return_invoices_display_name: $return_invoices_display_name, ',
          )
          ..write('invoiceSalesPrice: $invoiceSalesPrice, ')
          ..write('returnQty: $returnQty, ')
          ..write('isSynced: $isSynced, ')
          ..write('return_reason_id: $return_reason_id, ')
          ..write('return_action_id: $return_action_id, ')
          ..write('isAddedInvoicesReturn: $isAddedInvoicesReturn')
          ..write(')'))
        .toString();
  }
}

class $ReturnInvoicesTable extends ReturnInvoices
    with TableInfo<$ReturnInvoicesTable, ReturnInvoicesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReturnInvoicesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _move_idMeta = const VerificationMeta(
    'move_id',
  );
  @override
  late final GeneratedColumn<int> move_id = GeneratedColumn<int>(
    'move_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _account_move_line_idMeta =
      const VerificationMeta('account_move_line_id');
  @override
  late final GeneratedColumn<int> account_move_line_id = GeneratedColumn<int>(
    'account_move_line_id',
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
  static const VerificationMeta _productDisplayNameMeta =
      const VerificationMeta('productDisplayName');
  @override
  late final GeneratedColumn<String> productDisplayName =
      GeneratedColumn<String>(
        'product_display_name',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _return_reasonMeta = const VerificationMeta(
    'return_reason',
  );
  @override
  late final GeneratedColumn<String> return_reason = GeneratedColumn<String>(
    'return_reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _returnQtyMeta = const VerificationMeta(
    'returnQty',
  );
  @override
  late final GeneratedColumn<int> returnQty = GeneratedColumn<int>(
    'return_qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    move_id,
    account_move_line_id,
    productId,
    productDisplayName,
    return_reason,
    returnQty,
    unitPrice,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'return_invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReturnInvoicesData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('move_id')) {
      context.handle(
        _move_idMeta,
        move_id.isAcceptableOrUnknown(data['move_id']!, _move_idMeta),
      );
    } else if (isInserting) {
      context.missing(_move_idMeta);
    }
    if (data.containsKey('account_move_line_id')) {
      context.handle(
        _account_move_line_idMeta,
        account_move_line_id.isAcceptableOrUnknown(
          data['account_move_line_id']!,
          _account_move_line_idMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_account_move_line_idMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('product_display_name')) {
      context.handle(
        _productDisplayNameMeta,
        productDisplayName.isAcceptableOrUnknown(
          data['product_display_name']!,
          _productDisplayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productDisplayNameMeta);
    }
    if (data.containsKey('return_reason')) {
      context.handle(
        _return_reasonMeta,
        return_reason.isAcceptableOrUnknown(
          data['return_reason']!,
          _return_reasonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_return_reasonMeta);
    }
    if (data.containsKey('return_qty')) {
      context.handle(
        _returnQtyMeta,
        returnQty.isAcceptableOrUnknown(data['return_qty']!, _returnQtyMeta),
      );
    } else if (isInserting) {
      context.missing(_returnQtyMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReturnInvoicesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReturnInvoicesData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      move_id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}move_id'],
          )!,
      account_move_line_id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}account_move_line_id'],
          )!,
      productId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}product_id'],
          )!,
      productDisplayName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}product_display_name'],
          )!,
      return_reason:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}return_reason'],
          )!,
      returnQty:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}return_qty'],
          )!,
      unitPrice:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}unit_price'],
          )!,
    );
  }

  @override
  $ReturnInvoicesTable createAlias(String alias) {
    return $ReturnInvoicesTable(attachedDatabase, alias);
  }
}

class ReturnInvoicesData extends DataClass
    implements Insertable<ReturnInvoicesData> {
  final int id;
  final int move_id;
  final int account_move_line_id;
  final int productId;
  final String productDisplayName;
  final String return_reason;
  final int returnQty;
  final double unitPrice;
  const ReturnInvoicesData({
    required this.id,
    required this.move_id,
    required this.account_move_line_id,
    required this.productId,
    required this.productDisplayName,
    required this.return_reason,
    required this.returnQty,
    required this.unitPrice,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['move_id'] = Variable<int>(move_id);
    map['account_move_line_id'] = Variable<int>(account_move_line_id);
    map['product_id'] = Variable<int>(productId);
    map['product_display_name'] = Variable<String>(productDisplayName);
    map['return_reason'] = Variable<String>(return_reason);
    map['return_qty'] = Variable<int>(returnQty);
    map['unit_price'] = Variable<double>(unitPrice);
    return map;
  }

  ReturnInvoicesCompanion toCompanion(bool nullToAbsent) {
    return ReturnInvoicesCompanion(
      id: Value(id),
      move_id: Value(move_id),
      account_move_line_id: Value(account_move_line_id),
      productId: Value(productId),
      productDisplayName: Value(productDisplayName),
      return_reason: Value(return_reason),
      returnQty: Value(returnQty),
      unitPrice: Value(unitPrice),
    );
  }

  factory ReturnInvoicesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReturnInvoicesData(
      id: serializer.fromJson<int>(json['id']),
      move_id: serializer.fromJson<int>(json['move_id']),
      account_move_line_id: serializer.fromJson<int>(
        json['account_move_line_id'],
      ),
      productId: serializer.fromJson<int>(json['productId']),
      productDisplayName: serializer.fromJson<String>(
        json['productDisplayName'],
      ),
      return_reason: serializer.fromJson<String>(json['return_reason']),
      returnQty: serializer.fromJson<int>(json['returnQty']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'move_id': serializer.toJson<int>(move_id),
      'account_move_line_id': serializer.toJson<int>(account_move_line_id),
      'productId': serializer.toJson<int>(productId),
      'productDisplayName': serializer.toJson<String>(productDisplayName),
      'return_reason': serializer.toJson<String>(return_reason),
      'returnQty': serializer.toJson<int>(returnQty),
      'unitPrice': serializer.toJson<double>(unitPrice),
    };
  }

  ReturnInvoicesData copyWith({
    int? id,
    int? move_id,
    int? account_move_line_id,
    int? productId,
    String? productDisplayName,
    String? return_reason,
    int? returnQty,
    double? unitPrice,
  }) => ReturnInvoicesData(
    id: id ?? this.id,
    move_id: move_id ?? this.move_id,
    account_move_line_id: account_move_line_id ?? this.account_move_line_id,
    productId: productId ?? this.productId,
    productDisplayName: productDisplayName ?? this.productDisplayName,
    return_reason: return_reason ?? this.return_reason,
    returnQty: returnQty ?? this.returnQty,
    unitPrice: unitPrice ?? this.unitPrice,
  );
  ReturnInvoicesData copyWithCompanion(ReturnInvoicesCompanion data) {
    return ReturnInvoicesData(
      id: data.id.present ? data.id.value : this.id,
      move_id: data.move_id.present ? data.move_id.value : this.move_id,
      account_move_line_id:
          data.account_move_line_id.present
              ? data.account_move_line_id.value
              : this.account_move_line_id,
      productId: data.productId.present ? data.productId.value : this.productId,
      productDisplayName:
          data.productDisplayName.present
              ? data.productDisplayName.value
              : this.productDisplayName,
      return_reason:
          data.return_reason.present
              ? data.return_reason.value
              : this.return_reason,
      returnQty: data.returnQty.present ? data.returnQty.value : this.returnQty,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReturnInvoicesData(')
          ..write('id: $id, ')
          ..write('move_id: $move_id, ')
          ..write('account_move_line_id: $account_move_line_id, ')
          ..write('productId: $productId, ')
          ..write('productDisplayName: $productDisplayName, ')
          ..write('return_reason: $return_reason, ')
          ..write('returnQty: $returnQty, ')
          ..write('unitPrice: $unitPrice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    move_id,
    account_move_line_id,
    productId,
    productDisplayName,
    return_reason,
    returnQty,
    unitPrice,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReturnInvoicesData &&
          other.id == this.id &&
          other.move_id == this.move_id &&
          other.account_move_line_id == this.account_move_line_id &&
          other.productId == this.productId &&
          other.productDisplayName == this.productDisplayName &&
          other.return_reason == this.return_reason &&
          other.returnQty == this.returnQty &&
          other.unitPrice == this.unitPrice);
}

class ReturnInvoicesCompanion extends UpdateCompanion<ReturnInvoicesData> {
  final Value<int> id;
  final Value<int> move_id;
  final Value<int> account_move_line_id;
  final Value<int> productId;
  final Value<String> productDisplayName;
  final Value<String> return_reason;
  final Value<int> returnQty;
  final Value<double> unitPrice;
  const ReturnInvoicesCompanion({
    this.id = const Value.absent(),
    this.move_id = const Value.absent(),
    this.account_move_line_id = const Value.absent(),
    this.productId = const Value.absent(),
    this.productDisplayName = const Value.absent(),
    this.return_reason = const Value.absent(),
    this.returnQty = const Value.absent(),
    this.unitPrice = const Value.absent(),
  });
  ReturnInvoicesCompanion.insert({
    this.id = const Value.absent(),
    required int move_id,
    required int account_move_line_id,
    required int productId,
    required String productDisplayName,
    required String return_reason,
    required int returnQty,
    required double unitPrice,
  }) : move_id = Value(move_id),
       account_move_line_id = Value(account_move_line_id),
       productId = Value(productId),
       productDisplayName = Value(productDisplayName),
       return_reason = Value(return_reason),
       returnQty = Value(returnQty),
       unitPrice = Value(unitPrice);
  static Insertable<ReturnInvoicesData> custom({
    Expression<int>? id,
    Expression<int>? move_id,
    Expression<int>? account_move_line_id,
    Expression<int>? productId,
    Expression<String>? productDisplayName,
    Expression<String>? return_reason,
    Expression<int>? returnQty,
    Expression<double>? unitPrice,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (move_id != null) 'move_id': move_id,
      if (account_move_line_id != null)
        'account_move_line_id': account_move_line_id,
      if (productId != null) 'product_id': productId,
      if (productDisplayName != null)
        'product_display_name': productDisplayName,
      if (return_reason != null) 'return_reason': return_reason,
      if (returnQty != null) 'return_qty': returnQty,
      if (unitPrice != null) 'unit_price': unitPrice,
    });
  }

  ReturnInvoicesCompanion copyWith({
    Value<int>? id,
    Value<int>? move_id,
    Value<int>? account_move_line_id,
    Value<int>? productId,
    Value<String>? productDisplayName,
    Value<String>? return_reason,
    Value<int>? returnQty,
    Value<double>? unitPrice,
  }) {
    return ReturnInvoicesCompanion(
      id: id ?? this.id,
      move_id: move_id ?? this.move_id,
      account_move_line_id: account_move_line_id ?? this.account_move_line_id,
      productId: productId ?? this.productId,
      productDisplayName: productDisplayName ?? this.productDisplayName,
      return_reason: return_reason ?? this.return_reason,
      returnQty: returnQty ?? this.returnQty,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (move_id.present) {
      map['move_id'] = Variable<int>(move_id.value);
    }
    if (account_move_line_id.present) {
      map['account_move_line_id'] = Variable<int>(account_move_line_id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (productDisplayName.present) {
      map['product_display_name'] = Variable<String>(productDisplayName.value);
    }
    if (return_reason.present) {
      map['return_reason'] = Variable<String>(return_reason.value);
    }
    if (returnQty.present) {
      map['return_qty'] = Variable<int>(returnQty.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReturnInvoicesCompanion(')
          ..write('id: $id, ')
          ..write('move_id: $move_id, ')
          ..write('account_move_line_id: $account_move_line_id, ')
          ..write('productId: $productId, ')
          ..write('productDisplayName: $productDisplayName, ')
          ..write('return_reason: $return_reason, ')
          ..write('returnQty: $returnQty, ')
          ..write('unitPrice: $unitPrice')
          ..write(')'))
        .toString();
  }
}

class $ProductCategoryTable extends ProductCategory
    with TableInfo<$ProductCategoryTable, ProductCategoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductCategoryTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itinerary_discount_idsMeta =
      const VerificationMeta('itinerary_discount_ids');
  @override
  late final GeneratedColumn<String> itinerary_discount_ids =
      GeneratedColumn<String>(
        'itinerary_discount_ids',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoryId,
    displayName,
    itinerary_discount_ids,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_category';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductCategoryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('itinerary_discount_ids')) {
      context.handle(
        _itinerary_discount_idsMeta,
        itinerary_discount_ids.isAcceptableOrUnknown(
          data['itinerary_discount_ids']!,
          _itinerary_discount_idsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_itinerary_discount_idsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductCategoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductCategoryData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      categoryId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}category_id'],
          )!,
      displayName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}display_name'],
          )!,
      itinerary_discount_ids:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}itinerary_discount_ids'],
          )!,
    );
  }

  @override
  $ProductCategoryTable createAlias(String alias) {
    return $ProductCategoryTable(attachedDatabase, alias);
  }
}

class ProductCategoryData extends DataClass
    implements Insertable<ProductCategoryData> {
  final int id;
  final int categoryId;
  final String displayName;
  final String itinerary_discount_ids;
  const ProductCategoryData({
    required this.id,
    required this.categoryId,
    required this.displayName,
    required this.itinerary_discount_ids,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_id'] = Variable<int>(categoryId);
    map['display_name'] = Variable<String>(displayName);
    map['itinerary_discount_ids'] = Variable<String>(itinerary_discount_ids);
    return map;
  }

  ProductCategoryCompanion toCompanion(bool nullToAbsent) {
    return ProductCategoryCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      displayName: Value(displayName),
      itinerary_discount_ids: Value(itinerary_discount_ids),
    );
  }

  factory ProductCategoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductCategoryData(
      id: serializer.fromJson<int>(json['id']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      displayName: serializer.fromJson<String>(json['displayName']),
      itinerary_discount_ids: serializer.fromJson<String>(
        json['itinerary_discount_ids'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryId': serializer.toJson<int>(categoryId),
      'displayName': serializer.toJson<String>(displayName),
      'itinerary_discount_ids': serializer.toJson<String>(
        itinerary_discount_ids,
      ),
    };
  }

  ProductCategoryData copyWith({
    int? id,
    int? categoryId,
    String? displayName,
    String? itinerary_discount_ids,
  }) => ProductCategoryData(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    displayName: displayName ?? this.displayName,
    itinerary_discount_ids:
        itinerary_discount_ids ?? this.itinerary_discount_ids,
  );
  ProductCategoryData copyWithCompanion(ProductCategoryCompanion data) {
    return ProductCategoryData(
      id: data.id.present ? data.id.value : this.id,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      itinerary_discount_ids:
          data.itinerary_discount_ids.present
              ? data.itinerary_discount_ids.value
              : this.itinerary_discount_ids,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductCategoryData(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('displayName: $displayName, ')
          ..write('itinerary_discount_ids: $itinerary_discount_ids')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, categoryId, displayName, itinerary_discount_ids);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductCategoryData &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.displayName == this.displayName &&
          other.itinerary_discount_ids == this.itinerary_discount_ids);
}

class ProductCategoryCompanion extends UpdateCompanion<ProductCategoryData> {
  final Value<int> id;
  final Value<int> categoryId;
  final Value<String> displayName;
  final Value<String> itinerary_discount_ids;
  const ProductCategoryCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.itinerary_discount_ids = const Value.absent(),
  });
  ProductCategoryCompanion.insert({
    this.id = const Value.absent(),
    required int categoryId,
    required String displayName,
    required String itinerary_discount_ids,
  }) : categoryId = Value(categoryId),
       displayName = Value(displayName),
       itinerary_discount_ids = Value(itinerary_discount_ids);
  static Insertable<ProductCategoryData> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<String>? displayName,
    Expression<String>? itinerary_discount_ids,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (displayName != null) 'display_name': displayName,
      if (itinerary_discount_ids != null)
        'itinerary_discount_ids': itinerary_discount_ids,
    });
  }

  ProductCategoryCompanion copyWith({
    Value<int>? id,
    Value<int>? categoryId,
    Value<String>? displayName,
    Value<String>? itinerary_discount_ids,
  }) {
    return ProductCategoryCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      displayName: displayName ?? this.displayName,
      itinerary_discount_ids:
          itinerary_discount_ids ?? this.itinerary_discount_ids,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (itinerary_discount_ids.present) {
      map['itinerary_discount_ids'] = Variable<String>(
        itinerary_discount_ids.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductCategoryCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('displayName: $displayName, ')
          ..write('itinerary_discount_ids: $itinerary_discount_ids')
          ..write(')'))
        .toString();
  }
}

class $ItineraryPaymentLinesTable extends ItineraryPaymentLines
    with TableInfo<$ItineraryPaymentLinesTable, ItineraryPaymentLineData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItineraryPaymentLinesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _payment_line_idMeta = const VerificationMeta(
    'payment_line_id',
  );
  @override
  late final GeneratedColumn<int> payment_line_id = GeneratedColumn<int>(
    'payment_line_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoice_idMeta = const VerificationMeta(
    'invoice_id',
  );
  @override
  late final GeneratedColumn<int> invoice_id = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoice_nameMeta = const VerificationMeta(
    'invoice_name',
  );
  @override
  late final GeneratedColumn<String> invoice_name = GeneratedColumn<String>(
    'invoice_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoice_dateMeta = const VerificationMeta(
    'invoice_date',
  );
  @override
  late final GeneratedColumn<String> invoice_date = GeneratedColumn<String>(
    'invoice_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payment_methodMeta = const VerificationMeta(
    'payment_method',
  );
  @override
  late final GeneratedColumn<String> payment_method = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cheque_numberMeta = const VerificationMeta(
    'cheque_number',
  );
  @override
  late final GeneratedColumn<String> cheque_number = GeneratedColumn<String>(
    'cheque_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cheque_dateMeta = const VerificationMeta(
    'cheque_date',
  );
  @override
  late final GeneratedColumn<String> cheque_date = GeneratedColumn<String>(
    'cheque_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _invoice_amountMeta = const VerificationMeta(
    'invoice_amount',
  );
  @override
  late final GeneratedColumn<double> invoice_amount = GeneratedColumn<double>(
    'invoice_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    payment_line_id,
    itinerary_line_id,
    date,
    invoice_id,
    invoice_name,
    invoice_date,
    payment_method,
    cheque_number,
    cheque_date,
    invoice_amount,
    amount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'itinerary_payment_lines';
  @override
  VerificationContext validateIntegrity(
    Insertable<ItineraryPaymentLineData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('payment_line_id')) {
      context.handle(
        _payment_line_idMeta,
        payment_line_id.isAcceptableOrUnknown(
          data['payment_line_id']!,
          _payment_line_idMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payment_line_idMeta);
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
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoice_idMeta,
        invoice_id.isAcceptableOrUnknown(data['invoice_id']!, _invoice_idMeta),
      );
    } else if (isInserting) {
      context.missing(_invoice_idMeta);
    }
    if (data.containsKey('invoice_name')) {
      context.handle(
        _invoice_nameMeta,
        invoice_name.isAcceptableOrUnknown(
          data['invoice_name']!,
          _invoice_nameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoice_nameMeta);
    }
    if (data.containsKey('invoice_date')) {
      context.handle(
        _invoice_dateMeta,
        invoice_date.isAcceptableOrUnknown(
          data['invoice_date']!,
          _invoice_dateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoice_dateMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _payment_methodMeta,
        payment_method.isAcceptableOrUnknown(
          data['payment_method']!,
          _payment_methodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payment_methodMeta);
    }
    if (data.containsKey('cheque_number')) {
      context.handle(
        _cheque_numberMeta,
        cheque_number.isAcceptableOrUnknown(
          data['cheque_number']!,
          _cheque_numberMeta,
        ),
      );
    }
    if (data.containsKey('cheque_date')) {
      context.handle(
        _cheque_dateMeta,
        cheque_date.isAcceptableOrUnknown(
          data['cheque_date']!,
          _cheque_dateMeta,
        ),
      );
    }
    if (data.containsKey('invoice_amount')) {
      context.handle(
        _invoice_amountMeta,
        invoice_amount.isAcceptableOrUnknown(
          data['invoice_amount']!,
          _invoice_amountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoice_amountMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItineraryPaymentLineData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItineraryPaymentLineData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      payment_line_id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}payment_line_id'],
          )!,
      itinerary_line_id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}itinerary_line_id'],
          )!,
      date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}date'],
          )!,
      invoice_id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}invoice_id'],
          )!,
      invoice_name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}invoice_name'],
          )!,
      invoice_date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}invoice_date'],
          )!,
      payment_method:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}payment_method'],
          )!,
      cheque_number: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cheque_number'],
      ),
      cheque_date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cheque_date'],
      ),
      invoice_amount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}invoice_amount'],
          )!,
      amount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}amount'],
          )!,
    );
  }

  @override
  $ItineraryPaymentLinesTable createAlias(String alias) {
    return $ItineraryPaymentLinesTable(attachedDatabase, alias);
  }
}

class ItineraryPaymentLineData extends DataClass
    implements Insertable<ItineraryPaymentLineData> {
  final int id;
  final int payment_line_id;
  final int itinerary_line_id;
  final String date;
  final int invoice_id;
  final String invoice_name;
  final String invoice_date;
  final String payment_method;
  final String? cheque_number;
  final String? cheque_date;
  final double invoice_amount;
  final double amount;
  const ItineraryPaymentLineData({
    required this.id,
    required this.payment_line_id,
    required this.itinerary_line_id,
    required this.date,
    required this.invoice_id,
    required this.invoice_name,
    required this.invoice_date,
    required this.payment_method,
    this.cheque_number,
    this.cheque_date,
    required this.invoice_amount,
    required this.amount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['payment_line_id'] = Variable<int>(payment_line_id);
    map['itinerary_line_id'] = Variable<int>(itinerary_line_id);
    map['date'] = Variable<String>(date);
    map['invoice_id'] = Variable<int>(invoice_id);
    map['invoice_name'] = Variable<String>(invoice_name);
    map['invoice_date'] = Variable<String>(invoice_date);
    map['payment_method'] = Variable<String>(payment_method);
    if (!nullToAbsent || cheque_number != null) {
      map['cheque_number'] = Variable<String>(cheque_number);
    }
    if (!nullToAbsent || cheque_date != null) {
      map['cheque_date'] = Variable<String>(cheque_date);
    }
    map['invoice_amount'] = Variable<double>(invoice_amount);
    map['amount'] = Variable<double>(amount);
    return map;
  }

  ItineraryPaymentLinesCompanion toCompanion(bool nullToAbsent) {
    return ItineraryPaymentLinesCompanion(
      id: Value(id),
      payment_line_id: Value(payment_line_id),
      itinerary_line_id: Value(itinerary_line_id),
      date: Value(date),
      invoice_id: Value(invoice_id),
      invoice_name: Value(invoice_name),
      invoice_date: Value(invoice_date),
      payment_method: Value(payment_method),
      cheque_number:
          cheque_number == null && nullToAbsent
              ? const Value.absent()
              : Value(cheque_number),
      cheque_date:
          cheque_date == null && nullToAbsent
              ? const Value.absent()
              : Value(cheque_date),
      invoice_amount: Value(invoice_amount),
      amount: Value(amount),
    );
  }

  factory ItineraryPaymentLineData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItineraryPaymentLineData(
      id: serializer.fromJson<int>(json['id']),
      payment_line_id: serializer.fromJson<int>(json['payment_line_id']),
      itinerary_line_id: serializer.fromJson<int>(json['itinerary_line_id']),
      date: serializer.fromJson<String>(json['date']),
      invoice_id: serializer.fromJson<int>(json['invoice_id']),
      invoice_name: serializer.fromJson<String>(json['invoice_name']),
      invoice_date: serializer.fromJson<String>(json['invoice_date']),
      payment_method: serializer.fromJson<String>(json['payment_method']),
      cheque_number: serializer.fromJson<String?>(json['cheque_number']),
      cheque_date: serializer.fromJson<String?>(json['cheque_date']),
      invoice_amount: serializer.fromJson<double>(json['invoice_amount']),
      amount: serializer.fromJson<double>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'payment_line_id': serializer.toJson<int>(payment_line_id),
      'itinerary_line_id': serializer.toJson<int>(itinerary_line_id),
      'date': serializer.toJson<String>(date),
      'invoice_id': serializer.toJson<int>(invoice_id),
      'invoice_name': serializer.toJson<String>(invoice_name),
      'invoice_date': serializer.toJson<String>(invoice_date),
      'payment_method': serializer.toJson<String>(payment_method),
      'cheque_number': serializer.toJson<String?>(cheque_number),
      'cheque_date': serializer.toJson<String?>(cheque_date),
      'invoice_amount': serializer.toJson<double>(invoice_amount),
      'amount': serializer.toJson<double>(amount),
    };
  }

  ItineraryPaymentLineData copyWith({
    int? id,
    int? payment_line_id,
    int? itinerary_line_id,
    String? date,
    int? invoice_id,
    String? invoice_name,
    String? invoice_date,
    String? payment_method,
    Value<String?> cheque_number = const Value.absent(),
    Value<String?> cheque_date = const Value.absent(),
    double? invoice_amount,
    double? amount,
  }) => ItineraryPaymentLineData(
    id: id ?? this.id,
    payment_line_id: payment_line_id ?? this.payment_line_id,
    itinerary_line_id: itinerary_line_id ?? this.itinerary_line_id,
    date: date ?? this.date,
    invoice_id: invoice_id ?? this.invoice_id,
    invoice_name: invoice_name ?? this.invoice_name,
    invoice_date: invoice_date ?? this.invoice_date,
    payment_method: payment_method ?? this.payment_method,
    cheque_number:
        cheque_number.present ? cheque_number.value : this.cheque_number,
    cheque_date: cheque_date.present ? cheque_date.value : this.cheque_date,
    invoice_amount: invoice_amount ?? this.invoice_amount,
    amount: amount ?? this.amount,
  );
  ItineraryPaymentLineData copyWithCompanion(
    ItineraryPaymentLinesCompanion data,
  ) {
    return ItineraryPaymentLineData(
      id: data.id.present ? data.id.value : this.id,
      payment_line_id:
          data.payment_line_id.present
              ? data.payment_line_id.value
              : this.payment_line_id,
      itinerary_line_id:
          data.itinerary_line_id.present
              ? data.itinerary_line_id.value
              : this.itinerary_line_id,
      date: data.date.present ? data.date.value : this.date,
      invoice_id:
          data.invoice_id.present ? data.invoice_id.value : this.invoice_id,
      invoice_name:
          data.invoice_name.present
              ? data.invoice_name.value
              : this.invoice_name,
      invoice_date:
          data.invoice_date.present
              ? data.invoice_date.value
              : this.invoice_date,
      payment_method:
          data.payment_method.present
              ? data.payment_method.value
              : this.payment_method,
      cheque_number:
          data.cheque_number.present
              ? data.cheque_number.value
              : this.cheque_number,
      cheque_date:
          data.cheque_date.present ? data.cheque_date.value : this.cheque_date,
      invoice_amount:
          data.invoice_amount.present
              ? data.invoice_amount.value
              : this.invoice_amount,
      amount: data.amount.present ? data.amount.value : this.amount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItineraryPaymentLineData(')
          ..write('id: $id, ')
          ..write('payment_line_id: $payment_line_id, ')
          ..write('itinerary_line_id: $itinerary_line_id, ')
          ..write('date: $date, ')
          ..write('invoice_id: $invoice_id, ')
          ..write('invoice_name: $invoice_name, ')
          ..write('invoice_date: $invoice_date, ')
          ..write('payment_method: $payment_method, ')
          ..write('cheque_number: $cheque_number, ')
          ..write('cheque_date: $cheque_date, ')
          ..write('invoice_amount: $invoice_amount, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    payment_line_id,
    itinerary_line_id,
    date,
    invoice_id,
    invoice_name,
    invoice_date,
    payment_method,
    cheque_number,
    cheque_date,
    invoice_amount,
    amount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItineraryPaymentLineData &&
          other.id == this.id &&
          other.payment_line_id == this.payment_line_id &&
          other.itinerary_line_id == this.itinerary_line_id &&
          other.date == this.date &&
          other.invoice_id == this.invoice_id &&
          other.invoice_name == this.invoice_name &&
          other.invoice_date == this.invoice_date &&
          other.payment_method == this.payment_method &&
          other.cheque_number == this.cheque_number &&
          other.cheque_date == this.cheque_date &&
          other.invoice_amount == this.invoice_amount &&
          other.amount == this.amount);
}

class ItineraryPaymentLinesCompanion
    extends UpdateCompanion<ItineraryPaymentLineData> {
  final Value<int> id;
  final Value<int> payment_line_id;
  final Value<int> itinerary_line_id;
  final Value<String> date;
  final Value<int> invoice_id;
  final Value<String> invoice_name;
  final Value<String> invoice_date;
  final Value<String> payment_method;
  final Value<String?> cheque_number;
  final Value<String?> cheque_date;
  final Value<double> invoice_amount;
  final Value<double> amount;
  const ItineraryPaymentLinesCompanion({
    this.id = const Value.absent(),
    this.payment_line_id = const Value.absent(),
    this.itinerary_line_id = const Value.absent(),
    this.date = const Value.absent(),
    this.invoice_id = const Value.absent(),
    this.invoice_name = const Value.absent(),
    this.invoice_date = const Value.absent(),
    this.payment_method = const Value.absent(),
    this.cheque_number = const Value.absent(),
    this.cheque_date = const Value.absent(),
    this.invoice_amount = const Value.absent(),
    this.amount = const Value.absent(),
  });
  ItineraryPaymentLinesCompanion.insert({
    this.id = const Value.absent(),
    required int payment_line_id,
    required int itinerary_line_id,
    required String date,
    required int invoice_id,
    required String invoice_name,
    required String invoice_date,
    required String payment_method,
    this.cheque_number = const Value.absent(),
    this.cheque_date = const Value.absent(),
    required double invoice_amount,
    required double amount,
  }) : payment_line_id = Value(payment_line_id),
       itinerary_line_id = Value(itinerary_line_id),
       date = Value(date),
       invoice_id = Value(invoice_id),
       invoice_name = Value(invoice_name),
       invoice_date = Value(invoice_date),
       payment_method = Value(payment_method),
       invoice_amount = Value(invoice_amount),
       amount = Value(amount);
  static Insertable<ItineraryPaymentLineData> custom({
    Expression<int>? id,
    Expression<int>? payment_line_id,
    Expression<int>? itinerary_line_id,
    Expression<String>? date,
    Expression<int>? invoice_id,
    Expression<String>? invoice_name,
    Expression<String>? invoice_date,
    Expression<String>? payment_method,
    Expression<String>? cheque_number,
    Expression<String>? cheque_date,
    Expression<double>? invoice_amount,
    Expression<double>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (payment_line_id != null) 'payment_line_id': payment_line_id,
      if (itinerary_line_id != null) 'itinerary_line_id': itinerary_line_id,
      if (date != null) 'date': date,
      if (invoice_id != null) 'invoice_id': invoice_id,
      if (invoice_name != null) 'invoice_name': invoice_name,
      if (invoice_date != null) 'invoice_date': invoice_date,
      if (payment_method != null) 'payment_method': payment_method,
      if (cheque_number != null) 'cheque_number': cheque_number,
      if (cheque_date != null) 'cheque_date': cheque_date,
      if (invoice_amount != null) 'invoice_amount': invoice_amount,
      if (amount != null) 'amount': amount,
    });
  }

  ItineraryPaymentLinesCompanion copyWith({
    Value<int>? id,
    Value<int>? payment_line_id,
    Value<int>? itinerary_line_id,
    Value<String>? date,
    Value<int>? invoice_id,
    Value<String>? invoice_name,
    Value<String>? invoice_date,
    Value<String>? payment_method,
    Value<String?>? cheque_number,
    Value<String?>? cheque_date,
    Value<double>? invoice_amount,
    Value<double>? amount,
  }) {
    return ItineraryPaymentLinesCompanion(
      id: id ?? this.id,
      payment_line_id: payment_line_id ?? this.payment_line_id,
      itinerary_line_id: itinerary_line_id ?? this.itinerary_line_id,
      date: date ?? this.date,
      invoice_id: invoice_id ?? this.invoice_id,
      invoice_name: invoice_name ?? this.invoice_name,
      invoice_date: invoice_date ?? this.invoice_date,
      payment_method: payment_method ?? this.payment_method,
      cheque_number: cheque_number ?? this.cheque_number,
      cheque_date: cheque_date ?? this.cheque_date,
      invoice_amount: invoice_amount ?? this.invoice_amount,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (payment_line_id.present) {
      map['payment_line_id'] = Variable<int>(payment_line_id.value);
    }
    if (itinerary_line_id.present) {
      map['itinerary_line_id'] = Variable<int>(itinerary_line_id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (invoice_id.present) {
      map['invoice_id'] = Variable<int>(invoice_id.value);
    }
    if (invoice_name.present) {
      map['invoice_name'] = Variable<String>(invoice_name.value);
    }
    if (invoice_date.present) {
      map['invoice_date'] = Variable<String>(invoice_date.value);
    }
    if (payment_method.present) {
      map['payment_method'] = Variable<String>(payment_method.value);
    }
    if (cheque_number.present) {
      map['cheque_number'] = Variable<String>(cheque_number.value);
    }
    if (cheque_date.present) {
      map['cheque_date'] = Variable<String>(cheque_date.value);
    }
    if (invoice_amount.present) {
      map['invoice_amount'] = Variable<double>(invoice_amount.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItineraryPaymentLinesCompanion(')
          ..write('id: $id, ')
          ..write('payment_line_id: $payment_line_id, ')
          ..write('itinerary_line_id: $itinerary_line_id, ')
          ..write('date: $date, ')
          ..write('invoice_id: $invoice_id, ')
          ..write('invoice_name: $invoice_name, ')
          ..write('invoice_date: $invoice_date, ')
          ..write('payment_method: $payment_method, ')
          ..write('cheque_number: $cheque_number, ')
          ..write('cheque_date: $cheque_date, ')
          ..write('invoice_amount: $invoice_amount, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

class $InvoicesDataLinesTable extends InvoicesDataLines
    with TableInfo<$InvoicesDataLinesTable, InvoicesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesDataLinesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _partner_idMeta = const VerificationMeta(
    'partner_id',
  );
  @override
  late final GeneratedColumn<int> partner_id = GeneratedColumn<int>(
    'partner_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoice_idMeta = const VerificationMeta(
    'invoice_id',
  );
  @override
  late final GeneratedColumn<int> invoice_id = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoice_nameMeta = const VerificationMeta(
    'invoice_name',
  );
  @override
  late final GeneratedColumn<String> invoice_name = GeneratedColumn<String>(
    'invoice_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoice_due_dateMeta = const VerificationMeta(
    'invoice_due_date',
  );
  @override
  late final GeneratedColumn<String> invoice_due_date = GeneratedColumn<String>(
    'invoice_due_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoice_dateMeta = const VerificationMeta(
    'invoice_date',
  );
  @override
  late final GeneratedColumn<String> invoice_date = GeneratedColumn<String>(
    'invoice_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payment_statusMeta = const VerificationMeta(
    'payment_status',
  );
  @override
  late final GeneratedColumn<String> payment_status = GeneratedColumn<String>(
    'payment_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amount_residualMeta = const VerificationMeta(
    'amount_residual',
  );
  @override
  late final GeneratedColumn<double> amount_residual = GeneratedColumn<double>(
    'amount_residual',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _move_typeMeta = const VerificationMeta(
    'move_type',
  );
  @override
  late final GeneratedColumn<String> move_type = GeneratedColumn<String>(
    'move_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoice_amountMeta = const VerificationMeta(
    'invoice_amount',
  );
  @override
  late final GeneratedColumn<double> invoice_amount = GeneratedColumn<double>(
    'invoice_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    partner_id,
    invoice_id,
    invoice_name,
    invoice_due_date,
    invoice_date,
    payment_status,
    amount_residual,
    move_type,
    state,
    invoice_amount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices_data_lines';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvoicesData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('partner_id')) {
      context.handle(
        _partner_idMeta,
        partner_id.isAcceptableOrUnknown(data['partner_id']!, _partner_idMeta),
      );
    } else if (isInserting) {
      context.missing(_partner_idMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoice_idMeta,
        invoice_id.isAcceptableOrUnknown(data['invoice_id']!, _invoice_idMeta),
      );
    } else if (isInserting) {
      context.missing(_invoice_idMeta);
    }
    if (data.containsKey('invoice_name')) {
      context.handle(
        _invoice_nameMeta,
        invoice_name.isAcceptableOrUnknown(
          data['invoice_name']!,
          _invoice_nameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoice_nameMeta);
    }
    if (data.containsKey('invoice_due_date')) {
      context.handle(
        _invoice_due_dateMeta,
        invoice_due_date.isAcceptableOrUnknown(
          data['invoice_due_date']!,
          _invoice_due_dateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoice_due_dateMeta);
    }
    if (data.containsKey('invoice_date')) {
      context.handle(
        _invoice_dateMeta,
        invoice_date.isAcceptableOrUnknown(
          data['invoice_date']!,
          _invoice_dateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoice_dateMeta);
    }
    if (data.containsKey('payment_status')) {
      context.handle(
        _payment_statusMeta,
        payment_status.isAcceptableOrUnknown(
          data['payment_status']!,
          _payment_statusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payment_statusMeta);
    }
    if (data.containsKey('amount_residual')) {
      context.handle(
        _amount_residualMeta,
        amount_residual.isAcceptableOrUnknown(
          data['amount_residual']!,
          _amount_residualMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amount_residualMeta);
    }
    if (data.containsKey('move_type')) {
      context.handle(
        _move_typeMeta,
        move_type.isAcceptableOrUnknown(data['move_type']!, _move_typeMeta),
      );
    } else if (isInserting) {
      context.missing(_move_typeMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('invoice_amount')) {
      context.handle(
        _invoice_amountMeta,
        invoice_amount.isAcceptableOrUnknown(
          data['invoice_amount']!,
          _invoice_amountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoice_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoicesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoicesData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      partner_id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}partner_id'],
          )!,
      invoice_id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}invoice_id'],
          )!,
      invoice_name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}invoice_name'],
          )!,
      invoice_due_date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}invoice_due_date'],
          )!,
      invoice_date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}invoice_date'],
          )!,
      payment_status:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}payment_status'],
          )!,
      amount_residual:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}amount_residual'],
          )!,
      move_type:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}move_type'],
          )!,
      state:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}state'],
          )!,
      invoice_amount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}invoice_amount'],
          )!,
    );
  }

  @override
  $InvoicesDataLinesTable createAlias(String alias) {
    return $InvoicesDataLinesTable(attachedDatabase, alias);
  }
}

class InvoicesData extends DataClass implements Insertable<InvoicesData> {
  final int id;
  final int partner_id;
  final int invoice_id;
  final String invoice_name;
  final String invoice_due_date;
  final String invoice_date;
  final String payment_status;
  final double amount_residual;
  final String move_type;
  final String state;
  final double invoice_amount;
  const InvoicesData({
    required this.id,
    required this.partner_id,
    required this.invoice_id,
    required this.invoice_name,
    required this.invoice_due_date,
    required this.invoice_date,
    required this.payment_status,
    required this.amount_residual,
    required this.move_type,
    required this.state,
    required this.invoice_amount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['partner_id'] = Variable<int>(partner_id);
    map['invoice_id'] = Variable<int>(invoice_id);
    map['invoice_name'] = Variable<String>(invoice_name);
    map['invoice_due_date'] = Variable<String>(invoice_due_date);
    map['invoice_date'] = Variable<String>(invoice_date);
    map['payment_status'] = Variable<String>(payment_status);
    map['amount_residual'] = Variable<double>(amount_residual);
    map['move_type'] = Variable<String>(move_type);
    map['state'] = Variable<String>(state);
    map['invoice_amount'] = Variable<double>(invoice_amount);
    return map;
  }

  InvoicesDataLinesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesDataLinesCompanion(
      id: Value(id),
      partner_id: Value(partner_id),
      invoice_id: Value(invoice_id),
      invoice_name: Value(invoice_name),
      invoice_due_date: Value(invoice_due_date),
      invoice_date: Value(invoice_date),
      payment_status: Value(payment_status),
      amount_residual: Value(amount_residual),
      move_type: Value(move_type),
      state: Value(state),
      invoice_amount: Value(invoice_amount),
    );
  }

  factory InvoicesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoicesData(
      id: serializer.fromJson<int>(json['id']),
      partner_id: serializer.fromJson<int>(json['partner_id']),
      invoice_id: serializer.fromJson<int>(json['invoice_id']),
      invoice_name: serializer.fromJson<String>(json['invoice_name']),
      invoice_due_date: serializer.fromJson<String>(json['invoice_due_date']),
      invoice_date: serializer.fromJson<String>(json['invoice_date']),
      payment_status: serializer.fromJson<String>(json['payment_status']),
      amount_residual: serializer.fromJson<double>(json['amount_residual']),
      move_type: serializer.fromJson<String>(json['move_type']),
      state: serializer.fromJson<String>(json['state']),
      invoice_amount: serializer.fromJson<double>(json['invoice_amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'partner_id': serializer.toJson<int>(partner_id),
      'invoice_id': serializer.toJson<int>(invoice_id),
      'invoice_name': serializer.toJson<String>(invoice_name),
      'invoice_due_date': serializer.toJson<String>(invoice_due_date),
      'invoice_date': serializer.toJson<String>(invoice_date),
      'payment_status': serializer.toJson<String>(payment_status),
      'amount_residual': serializer.toJson<double>(amount_residual),
      'move_type': serializer.toJson<String>(move_type),
      'state': serializer.toJson<String>(state),
      'invoice_amount': serializer.toJson<double>(invoice_amount),
    };
  }

  InvoicesData copyWith({
    int? id,
    int? partner_id,
    int? invoice_id,
    String? invoice_name,
    String? invoice_due_date,
    String? invoice_date,
    String? payment_status,
    double? amount_residual,
    String? move_type,
    String? state,
    double? invoice_amount,
  }) => InvoicesData(
    id: id ?? this.id,
    partner_id: partner_id ?? this.partner_id,
    invoice_id: invoice_id ?? this.invoice_id,
    invoice_name: invoice_name ?? this.invoice_name,
    invoice_due_date: invoice_due_date ?? this.invoice_due_date,
    invoice_date: invoice_date ?? this.invoice_date,
    payment_status: payment_status ?? this.payment_status,
    amount_residual: amount_residual ?? this.amount_residual,
    move_type: move_type ?? this.move_type,
    state: state ?? this.state,
    invoice_amount: invoice_amount ?? this.invoice_amount,
  );
  InvoicesData copyWithCompanion(InvoicesDataLinesCompanion data) {
    return InvoicesData(
      id: data.id.present ? data.id.value : this.id,
      partner_id:
          data.partner_id.present ? data.partner_id.value : this.partner_id,
      invoice_id:
          data.invoice_id.present ? data.invoice_id.value : this.invoice_id,
      invoice_name:
          data.invoice_name.present
              ? data.invoice_name.value
              : this.invoice_name,
      invoice_due_date:
          data.invoice_due_date.present
              ? data.invoice_due_date.value
              : this.invoice_due_date,
      invoice_date:
          data.invoice_date.present
              ? data.invoice_date.value
              : this.invoice_date,
      payment_status:
          data.payment_status.present
              ? data.payment_status.value
              : this.payment_status,
      amount_residual:
          data.amount_residual.present
              ? data.amount_residual.value
              : this.amount_residual,
      move_type: data.move_type.present ? data.move_type.value : this.move_type,
      state: data.state.present ? data.state.value : this.state,
      invoice_amount:
          data.invoice_amount.present
              ? data.invoice_amount.value
              : this.invoice_amount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesData(')
          ..write('id: $id, ')
          ..write('partner_id: $partner_id, ')
          ..write('invoice_id: $invoice_id, ')
          ..write('invoice_name: $invoice_name, ')
          ..write('invoice_due_date: $invoice_due_date, ')
          ..write('invoice_date: $invoice_date, ')
          ..write('payment_status: $payment_status, ')
          ..write('amount_residual: $amount_residual, ')
          ..write('move_type: $move_type, ')
          ..write('state: $state, ')
          ..write('invoice_amount: $invoice_amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    partner_id,
    invoice_id,
    invoice_name,
    invoice_due_date,
    invoice_date,
    payment_status,
    amount_residual,
    move_type,
    state,
    invoice_amount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoicesData &&
          other.id == this.id &&
          other.partner_id == this.partner_id &&
          other.invoice_id == this.invoice_id &&
          other.invoice_name == this.invoice_name &&
          other.invoice_due_date == this.invoice_due_date &&
          other.invoice_date == this.invoice_date &&
          other.payment_status == this.payment_status &&
          other.amount_residual == this.amount_residual &&
          other.move_type == this.move_type &&
          other.state == this.state &&
          other.invoice_amount == this.invoice_amount);
}

class InvoicesDataLinesCompanion extends UpdateCompanion<InvoicesData> {
  final Value<int> id;
  final Value<int> partner_id;
  final Value<int> invoice_id;
  final Value<String> invoice_name;
  final Value<String> invoice_due_date;
  final Value<String> invoice_date;
  final Value<String> payment_status;
  final Value<double> amount_residual;
  final Value<String> move_type;
  final Value<String> state;
  final Value<double> invoice_amount;
  const InvoicesDataLinesCompanion({
    this.id = const Value.absent(),
    this.partner_id = const Value.absent(),
    this.invoice_id = const Value.absent(),
    this.invoice_name = const Value.absent(),
    this.invoice_due_date = const Value.absent(),
    this.invoice_date = const Value.absent(),
    this.payment_status = const Value.absent(),
    this.amount_residual = const Value.absent(),
    this.move_type = const Value.absent(),
    this.state = const Value.absent(),
    this.invoice_amount = const Value.absent(),
  });
  InvoicesDataLinesCompanion.insert({
    this.id = const Value.absent(),
    required int partner_id,
    required int invoice_id,
    required String invoice_name,
    required String invoice_due_date,
    required String invoice_date,
    required String payment_status,
    required double amount_residual,
    required String move_type,
    required String state,
    required double invoice_amount,
  }) : partner_id = Value(partner_id),
       invoice_id = Value(invoice_id),
       invoice_name = Value(invoice_name),
       invoice_due_date = Value(invoice_due_date),
       invoice_date = Value(invoice_date),
       payment_status = Value(payment_status),
       amount_residual = Value(amount_residual),
       move_type = Value(move_type),
       state = Value(state),
       invoice_amount = Value(invoice_amount);
  static Insertable<InvoicesData> custom({
    Expression<int>? id,
    Expression<int>? partner_id,
    Expression<int>? invoice_id,
    Expression<String>? invoice_name,
    Expression<String>? invoice_due_date,
    Expression<String>? invoice_date,
    Expression<String>? payment_status,
    Expression<double>? amount_residual,
    Expression<String>? move_type,
    Expression<String>? state,
    Expression<double>? invoice_amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (partner_id != null) 'partner_id': partner_id,
      if (invoice_id != null) 'invoice_id': invoice_id,
      if (invoice_name != null) 'invoice_name': invoice_name,
      if (invoice_due_date != null) 'invoice_due_date': invoice_due_date,
      if (invoice_date != null) 'invoice_date': invoice_date,
      if (payment_status != null) 'payment_status': payment_status,
      if (amount_residual != null) 'amount_residual': amount_residual,
      if (move_type != null) 'move_type': move_type,
      if (state != null) 'state': state,
      if (invoice_amount != null) 'invoice_amount': invoice_amount,
    });
  }

  InvoicesDataLinesCompanion copyWith({
    Value<int>? id,
    Value<int>? partner_id,
    Value<int>? invoice_id,
    Value<String>? invoice_name,
    Value<String>? invoice_due_date,
    Value<String>? invoice_date,
    Value<String>? payment_status,
    Value<double>? amount_residual,
    Value<String>? move_type,
    Value<String>? state,
    Value<double>? invoice_amount,
  }) {
    return InvoicesDataLinesCompanion(
      id: id ?? this.id,
      partner_id: partner_id ?? this.partner_id,
      invoice_id: invoice_id ?? this.invoice_id,
      invoice_name: invoice_name ?? this.invoice_name,
      invoice_due_date: invoice_due_date ?? this.invoice_due_date,
      invoice_date: invoice_date ?? this.invoice_date,
      payment_status: payment_status ?? this.payment_status,
      amount_residual: amount_residual ?? this.amount_residual,
      move_type: move_type ?? this.move_type,
      state: state ?? this.state,
      invoice_amount: invoice_amount ?? this.invoice_amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (partner_id.present) {
      map['partner_id'] = Variable<int>(partner_id.value);
    }
    if (invoice_id.present) {
      map['invoice_id'] = Variable<int>(invoice_id.value);
    }
    if (invoice_name.present) {
      map['invoice_name'] = Variable<String>(invoice_name.value);
    }
    if (invoice_due_date.present) {
      map['invoice_due_date'] = Variable<String>(invoice_due_date.value);
    }
    if (invoice_date.present) {
      map['invoice_date'] = Variable<String>(invoice_date.value);
    }
    if (payment_status.present) {
      map['payment_status'] = Variable<String>(payment_status.value);
    }
    if (amount_residual.present) {
      map['amount_residual'] = Variable<double>(amount_residual.value);
    }
    if (move_type.present) {
      map['move_type'] = Variable<String>(move_type.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (invoice_amount.present) {
      map['invoice_amount'] = Variable<double>(invoice_amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesDataLinesCompanion(')
          ..write('id: $id, ')
          ..write('partner_id: $partner_id, ')
          ..write('invoice_id: $invoice_id, ')
          ..write('invoice_name: $invoice_name, ')
          ..write('invoice_due_date: $invoice_due_date, ')
          ..write('invoice_date: $invoice_date, ')
          ..write('payment_status: $payment_status, ')
          ..write('amount_residual: $amount_residual, ')
          ..write('move_type: $move_type, ')
          ..write('state: $state, ')
          ..write('invoice_amount: $invoice_amount')
          ..write(')'))
        .toString();
  }
}

class $PaymentUsageTable extends PaymentUsage
    with TableInfo<$PaymentUsageTable, PaymentUsageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentUsageTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _odooIdMeta = const VerificationMeta('odooId');
  @override
  late final GeneratedColumn<int> odooId = GeneratedColumn<int>(
    'odoo_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _payment_line_idMeta = const VerificationMeta(
    'payment_line_id',
  );
  @override
  late final GeneratedColumn<int> payment_line_id = GeneratedColumn<int>(
    'payment_line_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoice_idMeta = const VerificationMeta(
    'invoice_id',
  );
  @override
  late final GeneratedColumn<int> invoice_id = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoice_nameMeta = const VerificationMeta(
    'invoice_name',
  );
  @override
  late final GeneratedColumn<String> invoice_name = GeneratedColumn<String>(
    'invoice_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoice_dateMeta = const VerificationMeta(
    'invoice_date',
  );
  @override
  late final GeneratedColumn<String> invoice_date = GeneratedColumn<String>(
    'invoice_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payment_methodMeta = const VerificationMeta(
    'payment_method',
  );
  @override
  late final GeneratedColumn<String> payment_method = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cheque_numberMeta = const VerificationMeta(
    'cheque_number',
  );
  @override
  late final GeneratedColumn<String> cheque_number = GeneratedColumn<String>(
    'cheque_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cheque_dateMeta = const VerificationMeta(
    'cheque_date',
  );
  @override
  late final GeneratedColumn<String> cheque_date = GeneratedColumn<String>(
    'cheque_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _invoice_amountMeta = const VerificationMeta(
    'invoice_amount',
  );
  @override
  late final GeneratedColumn<double> invoice_amount = GeneratedColumn<double>(
    'invoice_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isExciteOrNewMeta = const VerificationMeta(
    'isExciteOrNew',
  );
  @override
  late final GeneratedColumn<bool> isExciteOrNew = GeneratedColumn<bool>(
    'is_excite_or_new',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_excite_or_new" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    odooId,
    payment_line_id,
    itinerary_line_id,
    date,
    invoice_id,
    invoice_name,
    invoice_date,
    payment_method,
    cheque_number,
    cheque_date,
    invoice_amount,
    amount,
    isExciteOrNew,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payment_usage';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentUsageData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('odoo_id')) {
      context.handle(
        _odooIdMeta,
        odooId.isAcceptableOrUnknown(data['odoo_id']!, _odooIdMeta),
      );
    }
    if (data.containsKey('payment_line_id')) {
      context.handle(
        _payment_line_idMeta,
        payment_line_id.isAcceptableOrUnknown(
          data['payment_line_id']!,
          _payment_line_idMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payment_line_idMeta);
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
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoice_idMeta,
        invoice_id.isAcceptableOrUnknown(data['invoice_id']!, _invoice_idMeta),
      );
    } else if (isInserting) {
      context.missing(_invoice_idMeta);
    }
    if (data.containsKey('invoice_name')) {
      context.handle(
        _invoice_nameMeta,
        invoice_name.isAcceptableOrUnknown(
          data['invoice_name']!,
          _invoice_nameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoice_nameMeta);
    }
    if (data.containsKey('invoice_date')) {
      context.handle(
        _invoice_dateMeta,
        invoice_date.isAcceptableOrUnknown(
          data['invoice_date']!,
          _invoice_dateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoice_dateMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _payment_methodMeta,
        payment_method.isAcceptableOrUnknown(
          data['payment_method']!,
          _payment_methodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payment_methodMeta);
    }
    if (data.containsKey('cheque_number')) {
      context.handle(
        _cheque_numberMeta,
        cheque_number.isAcceptableOrUnknown(
          data['cheque_number']!,
          _cheque_numberMeta,
        ),
      );
    }
    if (data.containsKey('cheque_date')) {
      context.handle(
        _cheque_dateMeta,
        cheque_date.isAcceptableOrUnknown(
          data['cheque_date']!,
          _cheque_dateMeta,
        ),
      );
    }
    if (data.containsKey('invoice_amount')) {
      context.handle(
        _invoice_amountMeta,
        invoice_amount.isAcceptableOrUnknown(
          data['invoice_amount']!,
          _invoice_amountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoice_amountMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('is_excite_or_new')) {
      context.handle(
        _isExciteOrNewMeta,
        isExciteOrNew.isAcceptableOrUnknown(
          data['is_excite_or_new']!,
          _isExciteOrNewMeta,
        ),
      );
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
  PaymentUsageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentUsageData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      odooId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}odoo_id'],
          )!,
      payment_line_id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}payment_line_id'],
          )!,
      itinerary_line_id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}itinerary_line_id'],
          )!,
      date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}date'],
          )!,
      invoice_id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}invoice_id'],
          )!,
      invoice_name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}invoice_name'],
          )!,
      invoice_date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}invoice_date'],
          )!,
      payment_method:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}payment_method'],
          )!,
      cheque_number: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cheque_number'],
      ),
      cheque_date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cheque_date'],
      ),
      invoice_amount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}invoice_amount'],
          )!,
      amount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}amount'],
          )!,
      isExciteOrNew:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_excite_or_new'],
          )!,
      isSynced:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_synced'],
          )!,
    );
  }

  @override
  $PaymentUsageTable createAlias(String alias) {
    return $PaymentUsageTable(attachedDatabase, alias);
  }
}

class PaymentUsageData extends DataClass
    implements Insertable<PaymentUsageData> {
  final int id;
  final int odooId;
  final int payment_line_id;
  final int itinerary_line_id;
  final String date;
  final int invoice_id;
  final String invoice_name;
  final String invoice_date;
  final String payment_method;
  final String? cheque_number;
  final String? cheque_date;
  final double invoice_amount;
  final double amount;
  final bool isExciteOrNew;
  final bool isSynced;
  const PaymentUsageData({
    required this.id,
    required this.odooId,
    required this.payment_line_id,
    required this.itinerary_line_id,
    required this.date,
    required this.invoice_id,
    required this.invoice_name,
    required this.invoice_date,
    required this.payment_method,
    this.cheque_number,
    this.cheque_date,
    required this.invoice_amount,
    required this.amount,
    required this.isExciteOrNew,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['odoo_id'] = Variable<int>(odooId);
    map['payment_line_id'] = Variable<int>(payment_line_id);
    map['itinerary_line_id'] = Variable<int>(itinerary_line_id);
    map['date'] = Variable<String>(date);
    map['invoice_id'] = Variable<int>(invoice_id);
    map['invoice_name'] = Variable<String>(invoice_name);
    map['invoice_date'] = Variable<String>(invoice_date);
    map['payment_method'] = Variable<String>(payment_method);
    if (!nullToAbsent || cheque_number != null) {
      map['cheque_number'] = Variable<String>(cheque_number);
    }
    if (!nullToAbsent || cheque_date != null) {
      map['cheque_date'] = Variable<String>(cheque_date);
    }
    map['invoice_amount'] = Variable<double>(invoice_amount);
    map['amount'] = Variable<double>(amount);
    map['is_excite_or_new'] = Variable<bool>(isExciteOrNew);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  PaymentUsageCompanion toCompanion(bool nullToAbsent) {
    return PaymentUsageCompanion(
      id: Value(id),
      odooId: Value(odooId),
      payment_line_id: Value(payment_line_id),
      itinerary_line_id: Value(itinerary_line_id),
      date: Value(date),
      invoice_id: Value(invoice_id),
      invoice_name: Value(invoice_name),
      invoice_date: Value(invoice_date),
      payment_method: Value(payment_method),
      cheque_number:
          cheque_number == null && nullToAbsent
              ? const Value.absent()
              : Value(cheque_number),
      cheque_date:
          cheque_date == null && nullToAbsent
              ? const Value.absent()
              : Value(cheque_date),
      invoice_amount: Value(invoice_amount),
      amount: Value(amount),
      isExciteOrNew: Value(isExciteOrNew),
      isSynced: Value(isSynced),
    );
  }

  factory PaymentUsageData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentUsageData(
      id: serializer.fromJson<int>(json['id']),
      odooId: serializer.fromJson<int>(json['odooId']),
      payment_line_id: serializer.fromJson<int>(json['payment_line_id']),
      itinerary_line_id: serializer.fromJson<int>(json['itinerary_line_id']),
      date: serializer.fromJson<String>(json['date']),
      invoice_id: serializer.fromJson<int>(json['invoice_id']),
      invoice_name: serializer.fromJson<String>(json['invoice_name']),
      invoice_date: serializer.fromJson<String>(json['invoice_date']),
      payment_method: serializer.fromJson<String>(json['payment_method']),
      cheque_number: serializer.fromJson<String?>(json['cheque_number']),
      cheque_date: serializer.fromJson<String?>(json['cheque_date']),
      invoice_amount: serializer.fromJson<double>(json['invoice_amount']),
      amount: serializer.fromJson<double>(json['amount']),
      isExciteOrNew: serializer.fromJson<bool>(json['isExciteOrNew']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'odooId': serializer.toJson<int>(odooId),
      'payment_line_id': serializer.toJson<int>(payment_line_id),
      'itinerary_line_id': serializer.toJson<int>(itinerary_line_id),
      'date': serializer.toJson<String>(date),
      'invoice_id': serializer.toJson<int>(invoice_id),
      'invoice_name': serializer.toJson<String>(invoice_name),
      'invoice_date': serializer.toJson<String>(invoice_date),
      'payment_method': serializer.toJson<String>(payment_method),
      'cheque_number': serializer.toJson<String?>(cheque_number),
      'cheque_date': serializer.toJson<String?>(cheque_date),
      'invoice_amount': serializer.toJson<double>(invoice_amount),
      'amount': serializer.toJson<double>(amount),
      'isExciteOrNew': serializer.toJson<bool>(isExciteOrNew),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  PaymentUsageData copyWith({
    int? id,
    int? odooId,
    int? payment_line_id,
    int? itinerary_line_id,
    String? date,
    int? invoice_id,
    String? invoice_name,
    String? invoice_date,
    String? payment_method,
    Value<String?> cheque_number = const Value.absent(),
    Value<String?> cheque_date = const Value.absent(),
    double? invoice_amount,
    double? amount,
    bool? isExciteOrNew,
    bool? isSynced,
  }) => PaymentUsageData(
    id: id ?? this.id,
    odooId: odooId ?? this.odooId,
    payment_line_id: payment_line_id ?? this.payment_line_id,
    itinerary_line_id: itinerary_line_id ?? this.itinerary_line_id,
    date: date ?? this.date,
    invoice_id: invoice_id ?? this.invoice_id,
    invoice_name: invoice_name ?? this.invoice_name,
    invoice_date: invoice_date ?? this.invoice_date,
    payment_method: payment_method ?? this.payment_method,
    cheque_number:
        cheque_number.present ? cheque_number.value : this.cheque_number,
    cheque_date: cheque_date.present ? cheque_date.value : this.cheque_date,
    invoice_amount: invoice_amount ?? this.invoice_amount,
    amount: amount ?? this.amount,
    isExciteOrNew: isExciteOrNew ?? this.isExciteOrNew,
    isSynced: isSynced ?? this.isSynced,
  );
  PaymentUsageData copyWithCompanion(PaymentUsageCompanion data) {
    return PaymentUsageData(
      id: data.id.present ? data.id.value : this.id,
      odooId: data.odooId.present ? data.odooId.value : this.odooId,
      payment_line_id:
          data.payment_line_id.present
              ? data.payment_line_id.value
              : this.payment_line_id,
      itinerary_line_id:
          data.itinerary_line_id.present
              ? data.itinerary_line_id.value
              : this.itinerary_line_id,
      date: data.date.present ? data.date.value : this.date,
      invoice_id:
          data.invoice_id.present ? data.invoice_id.value : this.invoice_id,
      invoice_name:
          data.invoice_name.present
              ? data.invoice_name.value
              : this.invoice_name,
      invoice_date:
          data.invoice_date.present
              ? data.invoice_date.value
              : this.invoice_date,
      payment_method:
          data.payment_method.present
              ? data.payment_method.value
              : this.payment_method,
      cheque_number:
          data.cheque_number.present
              ? data.cheque_number.value
              : this.cheque_number,
      cheque_date:
          data.cheque_date.present ? data.cheque_date.value : this.cheque_date,
      invoice_amount:
          data.invoice_amount.present
              ? data.invoice_amount.value
              : this.invoice_amount,
      amount: data.amount.present ? data.amount.value : this.amount,
      isExciteOrNew:
          data.isExciteOrNew.present
              ? data.isExciteOrNew.value
              : this.isExciteOrNew,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentUsageData(')
          ..write('id: $id, ')
          ..write('odooId: $odooId, ')
          ..write('payment_line_id: $payment_line_id, ')
          ..write('itinerary_line_id: $itinerary_line_id, ')
          ..write('date: $date, ')
          ..write('invoice_id: $invoice_id, ')
          ..write('invoice_name: $invoice_name, ')
          ..write('invoice_date: $invoice_date, ')
          ..write('payment_method: $payment_method, ')
          ..write('cheque_number: $cheque_number, ')
          ..write('cheque_date: $cheque_date, ')
          ..write('invoice_amount: $invoice_amount, ')
          ..write('amount: $amount, ')
          ..write('isExciteOrNew: $isExciteOrNew, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    odooId,
    payment_line_id,
    itinerary_line_id,
    date,
    invoice_id,
    invoice_name,
    invoice_date,
    payment_method,
    cheque_number,
    cheque_date,
    invoice_amount,
    amount,
    isExciteOrNew,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentUsageData &&
          other.id == this.id &&
          other.odooId == this.odooId &&
          other.payment_line_id == this.payment_line_id &&
          other.itinerary_line_id == this.itinerary_line_id &&
          other.date == this.date &&
          other.invoice_id == this.invoice_id &&
          other.invoice_name == this.invoice_name &&
          other.invoice_date == this.invoice_date &&
          other.payment_method == this.payment_method &&
          other.cheque_number == this.cheque_number &&
          other.cheque_date == this.cheque_date &&
          other.invoice_amount == this.invoice_amount &&
          other.amount == this.amount &&
          other.isExciteOrNew == this.isExciteOrNew &&
          other.isSynced == this.isSynced);
}

class PaymentUsageCompanion extends UpdateCompanion<PaymentUsageData> {
  final Value<int> id;
  final Value<int> odooId;
  final Value<int> payment_line_id;
  final Value<int> itinerary_line_id;
  final Value<String> date;
  final Value<int> invoice_id;
  final Value<String> invoice_name;
  final Value<String> invoice_date;
  final Value<String> payment_method;
  final Value<String?> cheque_number;
  final Value<String?> cheque_date;
  final Value<double> invoice_amount;
  final Value<double> amount;
  final Value<bool> isExciteOrNew;
  final Value<bool> isSynced;
  const PaymentUsageCompanion({
    this.id = const Value.absent(),
    this.odooId = const Value.absent(),
    this.payment_line_id = const Value.absent(),
    this.itinerary_line_id = const Value.absent(),
    this.date = const Value.absent(),
    this.invoice_id = const Value.absent(),
    this.invoice_name = const Value.absent(),
    this.invoice_date = const Value.absent(),
    this.payment_method = const Value.absent(),
    this.cheque_number = const Value.absent(),
    this.cheque_date = const Value.absent(),
    this.invoice_amount = const Value.absent(),
    this.amount = const Value.absent(),
    this.isExciteOrNew = const Value.absent(),
    this.isSynced = const Value.absent(),
  });
  PaymentUsageCompanion.insert({
    this.id = const Value.absent(),
    this.odooId = const Value.absent(),
    required int payment_line_id,
    required int itinerary_line_id,
    required String date,
    required int invoice_id,
    required String invoice_name,
    required String invoice_date,
    required String payment_method,
    this.cheque_number = const Value.absent(),
    this.cheque_date = const Value.absent(),
    required double invoice_amount,
    required double amount,
    this.isExciteOrNew = const Value.absent(),
    this.isSynced = const Value.absent(),
  }) : payment_line_id = Value(payment_line_id),
       itinerary_line_id = Value(itinerary_line_id),
       date = Value(date),
       invoice_id = Value(invoice_id),
       invoice_name = Value(invoice_name),
       invoice_date = Value(invoice_date),
       payment_method = Value(payment_method),
       invoice_amount = Value(invoice_amount),
       amount = Value(amount);
  static Insertable<PaymentUsageData> custom({
    Expression<int>? id,
    Expression<int>? odooId,
    Expression<int>? payment_line_id,
    Expression<int>? itinerary_line_id,
    Expression<String>? date,
    Expression<int>? invoice_id,
    Expression<String>? invoice_name,
    Expression<String>? invoice_date,
    Expression<String>? payment_method,
    Expression<String>? cheque_number,
    Expression<String>? cheque_date,
    Expression<double>? invoice_amount,
    Expression<double>? amount,
    Expression<bool>? isExciteOrNew,
    Expression<bool>? isSynced,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (odooId != null) 'odoo_id': odooId,
      if (payment_line_id != null) 'payment_line_id': payment_line_id,
      if (itinerary_line_id != null) 'itinerary_line_id': itinerary_line_id,
      if (date != null) 'date': date,
      if (invoice_id != null) 'invoice_id': invoice_id,
      if (invoice_name != null) 'invoice_name': invoice_name,
      if (invoice_date != null) 'invoice_date': invoice_date,
      if (payment_method != null) 'payment_method': payment_method,
      if (cheque_number != null) 'cheque_number': cheque_number,
      if (cheque_date != null) 'cheque_date': cheque_date,
      if (invoice_amount != null) 'invoice_amount': invoice_amount,
      if (amount != null) 'amount': amount,
      if (isExciteOrNew != null) 'is_excite_or_new': isExciteOrNew,
      if (isSynced != null) 'is_synced': isSynced,
    });
  }

  PaymentUsageCompanion copyWith({
    Value<int>? id,
    Value<int>? odooId,
    Value<int>? payment_line_id,
    Value<int>? itinerary_line_id,
    Value<String>? date,
    Value<int>? invoice_id,
    Value<String>? invoice_name,
    Value<String>? invoice_date,
    Value<String>? payment_method,
    Value<String?>? cheque_number,
    Value<String?>? cheque_date,
    Value<double>? invoice_amount,
    Value<double>? amount,
    Value<bool>? isExciteOrNew,
    Value<bool>? isSynced,
  }) {
    return PaymentUsageCompanion(
      id: id ?? this.id,
      odooId: odooId ?? this.odooId,
      payment_line_id: payment_line_id ?? this.payment_line_id,
      itinerary_line_id: itinerary_line_id ?? this.itinerary_line_id,
      date: date ?? this.date,
      invoice_id: invoice_id ?? this.invoice_id,
      invoice_name: invoice_name ?? this.invoice_name,
      invoice_date: invoice_date ?? this.invoice_date,
      payment_method: payment_method ?? this.payment_method,
      cheque_number: cheque_number ?? this.cheque_number,
      cheque_date: cheque_date ?? this.cheque_date,
      invoice_amount: invoice_amount ?? this.invoice_amount,
      amount: amount ?? this.amount,
      isExciteOrNew: isExciteOrNew ?? this.isExciteOrNew,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (odooId.present) {
      map['odoo_id'] = Variable<int>(odooId.value);
    }
    if (payment_line_id.present) {
      map['payment_line_id'] = Variable<int>(payment_line_id.value);
    }
    if (itinerary_line_id.present) {
      map['itinerary_line_id'] = Variable<int>(itinerary_line_id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (invoice_id.present) {
      map['invoice_id'] = Variable<int>(invoice_id.value);
    }
    if (invoice_name.present) {
      map['invoice_name'] = Variable<String>(invoice_name.value);
    }
    if (invoice_date.present) {
      map['invoice_date'] = Variable<String>(invoice_date.value);
    }
    if (payment_method.present) {
      map['payment_method'] = Variable<String>(payment_method.value);
    }
    if (cheque_number.present) {
      map['cheque_number'] = Variable<String>(cheque_number.value);
    }
    if (cheque_date.present) {
      map['cheque_date'] = Variable<String>(cheque_date.value);
    }
    if (invoice_amount.present) {
      map['invoice_amount'] = Variable<double>(invoice_amount.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (isExciteOrNew.present) {
      map['is_excite_or_new'] = Variable<bool>(isExciteOrNew.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentUsageCompanion(')
          ..write('id: $id, ')
          ..write('odooId: $odooId, ')
          ..write('payment_line_id: $payment_line_id, ')
          ..write('itinerary_line_id: $itinerary_line_id, ')
          ..write('date: $date, ')
          ..write('invoice_id: $invoice_id, ')
          ..write('invoice_name: $invoice_name, ')
          ..write('invoice_date: $invoice_date, ')
          ..write('payment_method: $payment_method, ')
          ..write('cheque_number: $cheque_number, ')
          ..write('cheque_date: $cheque_date, ')
          ..write('invoice_amount: $invoice_amount, ')
          ..write('amount: $amount, ')
          ..write('isExciteOrNew: $isExciteOrNew, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }
}

class $VisitStatusDataLinesTable extends VisitStatusDataLines
    with TableInfo<$VisitStatusDataLinesTable, VisitStatus> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VisitStatusDataLinesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _status_idMeta = const VerificationMeta(
    'status_id',
  );
  @override
  late final GeneratedColumn<int> status_id = GeneratedColumn<int>(
    'status_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _visitStatusMeta = const VerificationMeta(
    'visitStatus',
  );
  @override
  late final GeneratedColumn<String> visitStatus = GeneratedColumn<String>(
    'visit_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, status_id, visitStatus];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'visit_status_data_lines';
  @override
  VerificationContext validateIntegrity(
    Insertable<VisitStatus> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('status_id')) {
      context.handle(
        _status_idMeta,
        status_id.isAcceptableOrUnknown(data['status_id']!, _status_idMeta),
      );
    } else if (isInserting) {
      context.missing(_status_idMeta);
    }
    if (data.containsKey('visit_status')) {
      context.handle(
        _visitStatusMeta,
        visitStatus.isAcceptableOrUnknown(
          data['visit_status']!,
          _visitStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_visitStatusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VisitStatus map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VisitStatus(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      status_id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}status_id'],
          )!,
      visitStatus:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}visit_status'],
          )!,
    );
  }

  @override
  $VisitStatusDataLinesTable createAlias(String alias) {
    return $VisitStatusDataLinesTable(attachedDatabase, alias);
  }
}

class VisitStatus extends DataClass implements Insertable<VisitStatus> {
  final int id;
  final int status_id;
  final String visitStatus;
  const VisitStatus({
    required this.id,
    required this.status_id,
    required this.visitStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['status_id'] = Variable<int>(status_id);
    map['visit_status'] = Variable<String>(visitStatus);
    return map;
  }

  VisitStatusDataLinesCompanion toCompanion(bool nullToAbsent) {
    return VisitStatusDataLinesCompanion(
      id: Value(id),
      status_id: Value(status_id),
      visitStatus: Value(visitStatus),
    );
  }

  factory VisitStatus.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VisitStatus(
      id: serializer.fromJson<int>(json['id']),
      status_id: serializer.fromJson<int>(json['status_id']),
      visitStatus: serializer.fromJson<String>(json['visitStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'status_id': serializer.toJson<int>(status_id),
      'visitStatus': serializer.toJson<String>(visitStatus),
    };
  }

  VisitStatus copyWith({int? id, int? status_id, String? visitStatus}) =>
      VisitStatus(
        id: id ?? this.id,
        status_id: status_id ?? this.status_id,
        visitStatus: visitStatus ?? this.visitStatus,
      );
  VisitStatus copyWithCompanion(VisitStatusDataLinesCompanion data) {
    return VisitStatus(
      id: data.id.present ? data.id.value : this.id,
      status_id: data.status_id.present ? data.status_id.value : this.status_id,
      visitStatus:
          data.visitStatus.present ? data.visitStatus.value : this.visitStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VisitStatus(')
          ..write('id: $id, ')
          ..write('status_id: $status_id, ')
          ..write('visitStatus: $visitStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, status_id, visitStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VisitStatus &&
          other.id == this.id &&
          other.status_id == this.status_id &&
          other.visitStatus == this.visitStatus);
}

class VisitStatusDataLinesCompanion extends UpdateCompanion<VisitStatus> {
  final Value<int> id;
  final Value<int> status_id;
  final Value<String> visitStatus;
  const VisitStatusDataLinesCompanion({
    this.id = const Value.absent(),
    this.status_id = const Value.absent(),
    this.visitStatus = const Value.absent(),
  });
  VisitStatusDataLinesCompanion.insert({
    this.id = const Value.absent(),
    required int status_id,
    required String visitStatus,
  }) : status_id = Value(status_id),
       visitStatus = Value(visitStatus);
  static Insertable<VisitStatus> custom({
    Expression<int>? id,
    Expression<int>? status_id,
    Expression<String>? visitStatus,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (status_id != null) 'status_id': status_id,
      if (visitStatus != null) 'visit_status': visitStatus,
    });
  }

  VisitStatusDataLinesCompanion copyWith({
    Value<int>? id,
    Value<int>? status_id,
    Value<String>? visitStatus,
  }) {
    return VisitStatusDataLinesCompanion(
      id: id ?? this.id,
      status_id: status_id ?? this.status_id,
      visitStatus: visitStatus ?? this.visitStatus,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (status_id.present) {
      map['status_id'] = Variable<int>(status_id.value);
    }
    if (visitStatus.present) {
      map['visit_status'] = Variable<String>(visitStatus.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VisitStatusDataLinesCompanion(')
          ..write('id: $id, ')
          ..write('status_id: $status_id, ')
          ..write('visitStatus: $visitStatus')
          ..write(')'))
        .toString();
  }
}

class $LoyaltyFreeIssueDataLinesTable extends LoyaltyFreeIssueDataLines
    with TableInfo<$LoyaltyFreeIssueDataLinesTable, LoyaltyFreeIssue> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LoyaltyFreeIssueDataLinesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minimumQtyMeta = const VerificationMeta(
    'minimumQty',
  );
  @override
  late final GeneratedColumn<int> minimumQty = GeneratedColumn<int>(
    'minimum_qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stock_lot_idMeta = const VerificationMeta(
    'stock_lot_id',
  );
  @override
  late final GeneratedColumn<int> stock_lot_id = GeneratedColumn<int>(
    'stock_lot_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reward_product_qtyMeta =
      const VerificationMeta('reward_product_qty');
  @override
  late final GeneratedColumn<int> reward_product_qty = GeneratedColumn<int>(
    'reward_product_qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    displayName,
    minimumQty,
    stock_lot_id,
    reward_product_qty,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'loyalty_free_issue_data_lines';
  @override
  VerificationContext validateIntegrity(
    Insertable<LoyaltyFreeIssue> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('minimum_qty')) {
      context.handle(
        _minimumQtyMeta,
        minimumQty.isAcceptableOrUnknown(data['minimum_qty']!, _minimumQtyMeta),
      );
    } else if (isInserting) {
      context.missing(_minimumQtyMeta);
    }
    if (data.containsKey('stock_lot_id')) {
      context.handle(
        _stock_lot_idMeta,
        stock_lot_id.isAcceptableOrUnknown(
          data['stock_lot_id']!,
          _stock_lot_idMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stock_lot_idMeta);
    }
    if (data.containsKey('reward_product_qty')) {
      context.handle(
        _reward_product_qtyMeta,
        reward_product_qty.isAcceptableOrUnknown(
          data['reward_product_qty']!,
          _reward_product_qtyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reward_product_qtyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LoyaltyFreeIssue map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LoyaltyFreeIssue(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      productId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}product_id'],
          )!,
      displayName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}display_name'],
          )!,
      minimumQty:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}minimum_qty'],
          )!,
      stock_lot_id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}stock_lot_id'],
          )!,
      reward_product_qty:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}reward_product_qty'],
          )!,
    );
  }

  @override
  $LoyaltyFreeIssueDataLinesTable createAlias(String alias) {
    return $LoyaltyFreeIssueDataLinesTable(attachedDatabase, alias);
  }
}

class LoyaltyFreeIssue extends DataClass
    implements Insertable<LoyaltyFreeIssue> {
  final int id;
  final int productId;
  final String displayName;
  final int minimumQty;
  final int stock_lot_id;
  final int reward_product_qty;
  const LoyaltyFreeIssue({
    required this.id,
    required this.productId,
    required this.displayName,
    required this.minimumQty,
    required this.stock_lot_id,
    required this.reward_product_qty,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['display_name'] = Variable<String>(displayName);
    map['minimum_qty'] = Variable<int>(minimumQty);
    map['stock_lot_id'] = Variable<int>(stock_lot_id);
    map['reward_product_qty'] = Variable<int>(reward_product_qty);
    return map;
  }

  LoyaltyFreeIssueDataLinesCompanion toCompanion(bool nullToAbsent) {
    return LoyaltyFreeIssueDataLinesCompanion(
      id: Value(id),
      productId: Value(productId),
      displayName: Value(displayName),
      minimumQty: Value(minimumQty),
      stock_lot_id: Value(stock_lot_id),
      reward_product_qty: Value(reward_product_qty),
    );
  }

  factory LoyaltyFreeIssue.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LoyaltyFreeIssue(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      displayName: serializer.fromJson<String>(json['displayName']),
      minimumQty: serializer.fromJson<int>(json['minimumQty']),
      stock_lot_id: serializer.fromJson<int>(json['stock_lot_id']),
      reward_product_qty: serializer.fromJson<int>(json['reward_product_qty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'displayName': serializer.toJson<String>(displayName),
      'minimumQty': serializer.toJson<int>(minimumQty),
      'stock_lot_id': serializer.toJson<int>(stock_lot_id),
      'reward_product_qty': serializer.toJson<int>(reward_product_qty),
    };
  }

  LoyaltyFreeIssue copyWith({
    int? id,
    int? productId,
    String? displayName,
    int? minimumQty,
    int? stock_lot_id,
    int? reward_product_qty,
  }) => LoyaltyFreeIssue(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    displayName: displayName ?? this.displayName,
    minimumQty: minimumQty ?? this.minimumQty,
    stock_lot_id: stock_lot_id ?? this.stock_lot_id,
    reward_product_qty: reward_product_qty ?? this.reward_product_qty,
  );
  LoyaltyFreeIssue copyWithCompanion(LoyaltyFreeIssueDataLinesCompanion data) {
    return LoyaltyFreeIssue(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      minimumQty:
          data.minimumQty.present ? data.minimumQty.value : this.minimumQty,
      stock_lot_id:
          data.stock_lot_id.present
              ? data.stock_lot_id.value
              : this.stock_lot_id,
      reward_product_qty:
          data.reward_product_qty.present
              ? data.reward_product_qty.value
              : this.reward_product_qty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LoyaltyFreeIssue(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('displayName: $displayName, ')
          ..write('minimumQty: $minimumQty, ')
          ..write('stock_lot_id: $stock_lot_id, ')
          ..write('reward_product_qty: $reward_product_qty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    displayName,
    minimumQty,
    stock_lot_id,
    reward_product_qty,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoyaltyFreeIssue &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.displayName == this.displayName &&
          other.minimumQty == this.minimumQty &&
          other.stock_lot_id == this.stock_lot_id &&
          other.reward_product_qty == this.reward_product_qty);
}

class LoyaltyFreeIssueDataLinesCompanion
    extends UpdateCompanion<LoyaltyFreeIssue> {
  final Value<int> id;
  final Value<int> productId;
  final Value<String> displayName;
  final Value<int> minimumQty;
  final Value<int> stock_lot_id;
  final Value<int> reward_product_qty;
  const LoyaltyFreeIssueDataLinesCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.minimumQty = const Value.absent(),
    this.stock_lot_id = const Value.absent(),
    this.reward_product_qty = const Value.absent(),
  });
  LoyaltyFreeIssueDataLinesCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required String displayName,
    required int minimumQty,
    required int stock_lot_id,
    required int reward_product_qty,
  }) : productId = Value(productId),
       displayName = Value(displayName),
       minimumQty = Value(minimumQty),
       stock_lot_id = Value(stock_lot_id),
       reward_product_qty = Value(reward_product_qty);
  static Insertable<LoyaltyFreeIssue> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<String>? displayName,
    Expression<int>? minimumQty,
    Expression<int>? stock_lot_id,
    Expression<int>? reward_product_qty,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (displayName != null) 'display_name': displayName,
      if (minimumQty != null) 'minimum_qty': minimumQty,
      if (stock_lot_id != null) 'stock_lot_id': stock_lot_id,
      if (reward_product_qty != null) 'reward_product_qty': reward_product_qty,
    });
  }

  LoyaltyFreeIssueDataLinesCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<String>? displayName,
    Value<int>? minimumQty,
    Value<int>? stock_lot_id,
    Value<int>? reward_product_qty,
  }) {
    return LoyaltyFreeIssueDataLinesCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      displayName: displayName ?? this.displayName,
      minimumQty: minimumQty ?? this.minimumQty,
      stock_lot_id: stock_lot_id ?? this.stock_lot_id,
      reward_product_qty: reward_product_qty ?? this.reward_product_qty,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (minimumQty.present) {
      map['minimum_qty'] = Variable<int>(minimumQty.value);
    }
    if (stock_lot_id.present) {
      map['stock_lot_id'] = Variable<int>(stock_lot_id.value);
    }
    if (reward_product_qty.present) {
      map['reward_product_qty'] = Variable<int>(reward_product_qty.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LoyaltyFreeIssueDataLinesCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('displayName: $displayName, ')
          ..write('minimumQty: $minimumQty, ')
          ..write('stock_lot_id: $stock_lot_id, ')
          ..write('reward_product_qty: $reward_product_qty')
          ..write(')'))
        .toString();
  }
}

class $DiscountDataOperationsTable extends DiscountDataOperations
    with TableInfo<$DiscountDataOperationsTable, DiscountData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiscountDataOperationsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _discount_idMeta = const VerificationMeta(
    'discount_id',
  );
  @override
  late final GeneratedColumn<int> discount_id = GeneratedColumn<int>(
    'discount_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discount_percentageMeta =
      const VerificationMeta('discount_percentage');
  @override
  late final GeneratedColumn<double> discount_percentage =
      GeneratedColumn<double>(
        'discount_percentage',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _start_dateMeta = const VerificationMeta(
    'start_date',
  );
  @override
  late final GeneratedColumn<String> start_date = GeneratedColumn<String>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _end_dateMeta = const VerificationMeta(
    'end_date',
  );
  @override
  late final GeneratedColumn<String> end_date = GeneratedColumn<String>(
    'end_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discount_product_idMeta =
      const VerificationMeta('discount_product_id');
  @override
  late final GeneratedColumn<int> discount_product_id = GeneratedColumn<int>(
    'discount_product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discount_product_nameMeta =
      const VerificationMeta('discount_product_name');
  @override
  late final GeneratedColumn<String> discount_product_name =
      GeneratedColumn<String>(
        'discount_product_name',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _is_activeMeta = const VerificationMeta(
    'is_active',
  );
  @override
  late final GeneratedColumn<bool> is_active = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
  );
  static const VerificationMeta _minimum_amountMeta = const VerificationMeta(
    'minimum_amount',
  );
  @override
  late final GeneratedColumn<double> minimum_amount = GeneratedColumn<double>(
    'minimum_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maximum_amountMeta = const VerificationMeta(
    'maximum_amount',
  );
  @override
  late final GeneratedColumn<double> maximum_amount = GeneratedColumn<double>(
    'maximum_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _not_issue_discount_products_idsMeta =
      const VerificationMeta('not_issue_discount_products_ids');
  @override
  late final GeneratedColumn<String> not_issue_discount_products_ids =
      GeneratedColumn<String>(
        'not_issue_discount_products_ids',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    discount_id,
    name,
    discount_percentage,
    start_date,
    end_date,
    discount_product_id,
    discount_product_name,
    is_active,
    minimum_amount,
    maximum_amount,
    not_issue_discount_products_ids,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'discount_data_operations';
  @override
  VerificationContext validateIntegrity(
    Insertable<DiscountData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('discount_id')) {
      context.handle(
        _discount_idMeta,
        discount_id.isAcceptableOrUnknown(
          data['discount_id']!,
          _discount_idMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_discount_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('discount_percentage')) {
      context.handle(
        _discount_percentageMeta,
        discount_percentage.isAcceptableOrUnknown(
          data['discount_percentage']!,
          _discount_percentageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_discount_percentageMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _start_dateMeta,
        start_date.isAcceptableOrUnknown(data['start_date']!, _start_dateMeta),
      );
    } else if (isInserting) {
      context.missing(_start_dateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _end_dateMeta,
        end_date.isAcceptableOrUnknown(data['end_date']!, _end_dateMeta),
      );
    } else if (isInserting) {
      context.missing(_end_dateMeta);
    }
    if (data.containsKey('discount_product_id')) {
      context.handle(
        _discount_product_idMeta,
        discount_product_id.isAcceptableOrUnknown(
          data['discount_product_id']!,
          _discount_product_idMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_discount_product_idMeta);
    }
    if (data.containsKey('discount_product_name')) {
      context.handle(
        _discount_product_nameMeta,
        discount_product_name.isAcceptableOrUnknown(
          data['discount_product_name']!,
          _discount_product_nameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_discount_product_nameMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _is_activeMeta,
        is_active.isAcceptableOrUnknown(data['is_active']!, _is_activeMeta),
      );
    } else if (isInserting) {
      context.missing(_is_activeMeta);
    }
    if (data.containsKey('minimum_amount')) {
      context.handle(
        _minimum_amountMeta,
        minimum_amount.isAcceptableOrUnknown(
          data['minimum_amount']!,
          _minimum_amountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_minimum_amountMeta);
    }
    if (data.containsKey('maximum_amount')) {
      context.handle(
        _maximum_amountMeta,
        maximum_amount.isAcceptableOrUnknown(
          data['maximum_amount']!,
          _maximum_amountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maximum_amountMeta);
    }
    if (data.containsKey('not_issue_discount_products_ids')) {
      context.handle(
        _not_issue_discount_products_idsMeta,
        not_issue_discount_products_ids.isAcceptableOrUnknown(
          data['not_issue_discount_products_ids']!,
          _not_issue_discount_products_idsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_not_issue_discount_products_idsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DiscountData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DiscountData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      discount_id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}discount_id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      discount_percentage:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}discount_percentage'],
          )!,
      start_date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}start_date'],
          )!,
      end_date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}end_date'],
          )!,
      discount_product_id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}discount_product_id'],
          )!,
      discount_product_name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}discount_product_name'],
          )!,
      is_active:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_active'],
          )!,
      minimum_amount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}minimum_amount'],
          )!,
      maximum_amount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}maximum_amount'],
          )!,
      not_issue_discount_products_ids:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}not_issue_discount_products_ids'],
          )!,
    );
  }

  @override
  $DiscountDataOperationsTable createAlias(String alias) {
    return $DiscountDataOperationsTable(attachedDatabase, alias);
  }
}

class DiscountData extends DataClass implements Insertable<DiscountData> {
  final int id;
  final int discount_id;
  final String name;
  final double discount_percentage;
  final String start_date;
  final String end_date;
  final int discount_product_id;
  final String discount_product_name;
  final bool is_active;
  final double minimum_amount;
  final double maximum_amount;
  final String not_issue_discount_products_ids;
  const DiscountData({
    required this.id,
    required this.discount_id,
    required this.name,
    required this.discount_percentage,
    required this.start_date,
    required this.end_date,
    required this.discount_product_id,
    required this.discount_product_name,
    required this.is_active,
    required this.minimum_amount,
    required this.maximum_amount,
    required this.not_issue_discount_products_ids,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['discount_id'] = Variable<int>(discount_id);
    map['name'] = Variable<String>(name);
    map['discount_percentage'] = Variable<double>(discount_percentage);
    map['start_date'] = Variable<String>(start_date);
    map['end_date'] = Variable<String>(end_date);
    map['discount_product_id'] = Variable<int>(discount_product_id);
    map['discount_product_name'] = Variable<String>(discount_product_name);
    map['is_active'] = Variable<bool>(is_active);
    map['minimum_amount'] = Variable<double>(minimum_amount);
    map['maximum_amount'] = Variable<double>(maximum_amount);
    map['not_issue_discount_products_ids'] = Variable<String>(
      not_issue_discount_products_ids,
    );
    return map;
  }

  DiscountDataOperationsCompanion toCompanion(bool nullToAbsent) {
    return DiscountDataOperationsCompanion(
      id: Value(id),
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
    );
  }

  factory DiscountData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DiscountData(
      id: serializer.fromJson<int>(json['id']),
      discount_id: serializer.fromJson<int>(json['discount_id']),
      name: serializer.fromJson<String>(json['name']),
      discount_percentage: serializer.fromJson<double>(
        json['discount_percentage'],
      ),
      start_date: serializer.fromJson<String>(json['start_date']),
      end_date: serializer.fromJson<String>(json['end_date']),
      discount_product_id: serializer.fromJson<int>(
        json['discount_product_id'],
      ),
      discount_product_name: serializer.fromJson<String>(
        json['discount_product_name'],
      ),
      is_active: serializer.fromJson<bool>(json['is_active']),
      minimum_amount: serializer.fromJson<double>(json['minimum_amount']),
      maximum_amount: serializer.fromJson<double>(json['maximum_amount']),
      not_issue_discount_products_ids: serializer.fromJson<String>(
        json['not_issue_discount_products_ids'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'discount_id': serializer.toJson<int>(discount_id),
      'name': serializer.toJson<String>(name),
      'discount_percentage': serializer.toJson<double>(discount_percentage),
      'start_date': serializer.toJson<String>(start_date),
      'end_date': serializer.toJson<String>(end_date),
      'discount_product_id': serializer.toJson<int>(discount_product_id),
      'discount_product_name': serializer.toJson<String>(discount_product_name),
      'is_active': serializer.toJson<bool>(is_active),
      'minimum_amount': serializer.toJson<double>(minimum_amount),
      'maximum_amount': serializer.toJson<double>(maximum_amount),
      'not_issue_discount_products_ids': serializer.toJson<String>(
        not_issue_discount_products_ids,
      ),
    };
  }

  DiscountData copyWith({
    int? id,
    int? discount_id,
    String? name,
    double? discount_percentage,
    String? start_date,
    String? end_date,
    int? discount_product_id,
    String? discount_product_name,
    bool? is_active,
    double? minimum_amount,
    double? maximum_amount,
    String? not_issue_discount_products_ids,
  }) => DiscountData(
    id: id ?? this.id,
    discount_id: discount_id ?? this.discount_id,
    name: name ?? this.name,
    discount_percentage: discount_percentage ?? this.discount_percentage,
    start_date: start_date ?? this.start_date,
    end_date: end_date ?? this.end_date,
    discount_product_id: discount_product_id ?? this.discount_product_id,
    discount_product_name: discount_product_name ?? this.discount_product_name,
    is_active: is_active ?? this.is_active,
    minimum_amount: minimum_amount ?? this.minimum_amount,
    maximum_amount: maximum_amount ?? this.maximum_amount,
    not_issue_discount_products_ids:
        not_issue_discount_products_ids ?? this.not_issue_discount_products_ids,
  );
  DiscountData copyWithCompanion(DiscountDataOperationsCompanion data) {
    return DiscountData(
      id: data.id.present ? data.id.value : this.id,
      discount_id:
          data.discount_id.present ? data.discount_id.value : this.discount_id,
      name: data.name.present ? data.name.value : this.name,
      discount_percentage:
          data.discount_percentage.present
              ? data.discount_percentage.value
              : this.discount_percentage,
      start_date:
          data.start_date.present ? data.start_date.value : this.start_date,
      end_date: data.end_date.present ? data.end_date.value : this.end_date,
      discount_product_id:
          data.discount_product_id.present
              ? data.discount_product_id.value
              : this.discount_product_id,
      discount_product_name:
          data.discount_product_name.present
              ? data.discount_product_name.value
              : this.discount_product_name,
      is_active: data.is_active.present ? data.is_active.value : this.is_active,
      minimum_amount:
          data.minimum_amount.present
              ? data.minimum_amount.value
              : this.minimum_amount,
      maximum_amount:
          data.maximum_amount.present
              ? data.maximum_amount.value
              : this.maximum_amount,
      not_issue_discount_products_ids:
          data.not_issue_discount_products_ids.present
              ? data.not_issue_discount_products_ids.value
              : this.not_issue_discount_products_ids,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DiscountData(')
          ..write('id: $id, ')
          ..write('discount_id: $discount_id, ')
          ..write('name: $name, ')
          ..write('discount_percentage: $discount_percentage, ')
          ..write('start_date: $start_date, ')
          ..write('end_date: $end_date, ')
          ..write('discount_product_id: $discount_product_id, ')
          ..write('discount_product_name: $discount_product_name, ')
          ..write('is_active: $is_active, ')
          ..write('minimum_amount: $minimum_amount, ')
          ..write('maximum_amount: $maximum_amount, ')
          ..write(
            'not_issue_discount_products_ids: $not_issue_discount_products_ids',
          )
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    discount_id,
    name,
    discount_percentage,
    start_date,
    end_date,
    discount_product_id,
    discount_product_name,
    is_active,
    minimum_amount,
    maximum_amount,
    not_issue_discount_products_ids,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DiscountData &&
          other.id == this.id &&
          other.discount_id == this.discount_id &&
          other.name == this.name &&
          other.discount_percentage == this.discount_percentage &&
          other.start_date == this.start_date &&
          other.end_date == this.end_date &&
          other.discount_product_id == this.discount_product_id &&
          other.discount_product_name == this.discount_product_name &&
          other.is_active == this.is_active &&
          other.minimum_amount == this.minimum_amount &&
          other.maximum_amount == this.maximum_amount &&
          other.not_issue_discount_products_ids ==
              this.not_issue_discount_products_ids);
}

class DiscountDataOperationsCompanion extends UpdateCompanion<DiscountData> {
  final Value<int> id;
  final Value<int> discount_id;
  final Value<String> name;
  final Value<double> discount_percentage;
  final Value<String> start_date;
  final Value<String> end_date;
  final Value<int> discount_product_id;
  final Value<String> discount_product_name;
  final Value<bool> is_active;
  final Value<double> minimum_amount;
  final Value<double> maximum_amount;
  final Value<String> not_issue_discount_products_ids;
  const DiscountDataOperationsCompanion({
    this.id = const Value.absent(),
    this.discount_id = const Value.absent(),
    this.name = const Value.absent(),
    this.discount_percentage = const Value.absent(),
    this.start_date = const Value.absent(),
    this.end_date = const Value.absent(),
    this.discount_product_id = const Value.absent(),
    this.discount_product_name = const Value.absent(),
    this.is_active = const Value.absent(),
    this.minimum_amount = const Value.absent(),
    this.maximum_amount = const Value.absent(),
    this.not_issue_discount_products_ids = const Value.absent(),
  });
  DiscountDataOperationsCompanion.insert({
    this.id = const Value.absent(),
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
  }) : discount_id = Value(discount_id),
       name = Value(name),
       discount_percentage = Value(discount_percentage),
       start_date = Value(start_date),
       end_date = Value(end_date),
       discount_product_id = Value(discount_product_id),
       discount_product_name = Value(discount_product_name),
       is_active = Value(is_active),
       minimum_amount = Value(minimum_amount),
       maximum_amount = Value(maximum_amount),
       not_issue_discount_products_ids = Value(not_issue_discount_products_ids);
  static Insertable<DiscountData> custom({
    Expression<int>? id,
    Expression<int>? discount_id,
    Expression<String>? name,
    Expression<double>? discount_percentage,
    Expression<String>? start_date,
    Expression<String>? end_date,
    Expression<int>? discount_product_id,
    Expression<String>? discount_product_name,
    Expression<bool>? is_active,
    Expression<double>? minimum_amount,
    Expression<double>? maximum_amount,
    Expression<String>? not_issue_discount_products_ids,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (discount_id != null) 'discount_id': discount_id,
      if (name != null) 'name': name,
      if (discount_percentage != null)
        'discount_percentage': discount_percentage,
      if (start_date != null) 'start_date': start_date,
      if (end_date != null) 'end_date': end_date,
      if (discount_product_id != null)
        'discount_product_id': discount_product_id,
      if (discount_product_name != null)
        'discount_product_name': discount_product_name,
      if (is_active != null) 'is_active': is_active,
      if (minimum_amount != null) 'minimum_amount': minimum_amount,
      if (maximum_amount != null) 'maximum_amount': maximum_amount,
      if (not_issue_discount_products_ids != null)
        'not_issue_discount_products_ids': not_issue_discount_products_ids,
    });
  }

  DiscountDataOperationsCompanion copyWith({
    Value<int>? id,
    Value<int>? discount_id,
    Value<String>? name,
    Value<double>? discount_percentage,
    Value<String>? start_date,
    Value<String>? end_date,
    Value<int>? discount_product_id,
    Value<String>? discount_product_name,
    Value<bool>? is_active,
    Value<double>? minimum_amount,
    Value<double>? maximum_amount,
    Value<String>? not_issue_discount_products_ids,
  }) {
    return DiscountDataOperationsCompanion(
      id: id ?? this.id,
      discount_id: discount_id ?? this.discount_id,
      name: name ?? this.name,
      discount_percentage: discount_percentage ?? this.discount_percentage,
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
      discount_product_id: discount_product_id ?? this.discount_product_id,
      discount_product_name:
          discount_product_name ?? this.discount_product_name,
      is_active: is_active ?? this.is_active,
      minimum_amount: minimum_amount ?? this.minimum_amount,
      maximum_amount: maximum_amount ?? this.maximum_amount,
      not_issue_discount_products_ids:
          not_issue_discount_products_ids ??
          this.not_issue_discount_products_ids,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (discount_id.present) {
      map['discount_id'] = Variable<int>(discount_id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (discount_percentage.present) {
      map['discount_percentage'] = Variable<double>(discount_percentage.value);
    }
    if (start_date.present) {
      map['start_date'] = Variable<String>(start_date.value);
    }
    if (end_date.present) {
      map['end_date'] = Variable<String>(end_date.value);
    }
    if (discount_product_id.present) {
      map['discount_product_id'] = Variable<int>(discount_product_id.value);
    }
    if (discount_product_name.present) {
      map['discount_product_name'] = Variable<String>(
        discount_product_name.value,
      );
    }
    if (is_active.present) {
      map['is_active'] = Variable<bool>(is_active.value);
    }
    if (minimum_amount.present) {
      map['minimum_amount'] = Variable<double>(minimum_amount.value);
    }
    if (maximum_amount.present) {
      map['maximum_amount'] = Variable<double>(maximum_amount.value);
    }
    if (not_issue_discount_products_ids.present) {
      map['not_issue_discount_products_ids'] = Variable<String>(
        not_issue_discount_products_ids.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiscountDataOperationsCompanion(')
          ..write('id: $id, ')
          ..write('discount_id: $discount_id, ')
          ..write('name: $name, ')
          ..write('discount_percentage: $discount_percentage, ')
          ..write('start_date: $start_date, ')
          ..write('end_date: $end_date, ')
          ..write('discount_product_id: $discount_product_id, ')
          ..write('discount_product_name: $discount_product_name, ')
          ..write('is_active: $is_active, ')
          ..write('minimum_amount: $minimum_amount, ')
          ..write('maximum_amount: $maximum_amount, ')
          ..write(
            'not_issue_discount_products_ids: $not_issue_discount_products_ids',
          )
          ..write(')'))
        .toString();
  }
}

class $ResPartnerDataOperationsTable extends ResPartnerDataOperations
    with TableInfo<$ResPartnerDataOperationsTable, ResPartnerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ResPartnerDataOperationsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _res_partner_idMeta = const VerificationMeta(
    'res_partner_id',
  );
  @override
  late final GeneratedColumn<int> res_partner_id = GeneratedColumn<int>(
    'res_partner_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creditMeta = const VerificationMeta('credit');
  @override
  late final GeneratedColumn<double> credit = GeneratedColumn<double>(
    'credit',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _use_partner_credit_limitMeta =
      const VerificationMeta('use_partner_credit_limit');
  @override
  late final GeneratedColumn<double> use_partner_credit_limit =
      GeneratedColumn<double>(
        'use_partner_credit_limit',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _credit_periodMeta = const VerificationMeta(
    'credit_period',
  );
  @override
  late final GeneratedColumn<int> credit_period = GeneratedColumn<int>(
    'credit_period',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    res_partner_id,
    name,
    credit,
    use_partner_credit_limit,
    credit_period,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'res_partner_data_operations';
  @override
  VerificationContext validateIntegrity(
    Insertable<ResPartnerData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('res_partner_id')) {
      context.handle(
        _res_partner_idMeta,
        res_partner_id.isAcceptableOrUnknown(
          data['res_partner_id']!,
          _res_partner_idMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_res_partner_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('credit')) {
      context.handle(
        _creditMeta,
        credit.isAcceptableOrUnknown(data['credit']!, _creditMeta),
      );
    } else if (isInserting) {
      context.missing(_creditMeta);
    }
    if (data.containsKey('use_partner_credit_limit')) {
      context.handle(
        _use_partner_credit_limitMeta,
        use_partner_credit_limit.isAcceptableOrUnknown(
          data['use_partner_credit_limit']!,
          _use_partner_credit_limitMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_use_partner_credit_limitMeta);
    }
    if (data.containsKey('credit_period')) {
      context.handle(
        _credit_periodMeta,
        credit_period.isAcceptableOrUnknown(
          data['credit_period']!,
          _credit_periodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_credit_periodMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ResPartnerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ResPartnerData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      res_partner_id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}res_partner_id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      credit:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}credit'],
          )!,
      use_partner_credit_limit:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}use_partner_credit_limit'],
          )!,
      credit_period:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}credit_period'],
          )!,
    );
  }

  @override
  $ResPartnerDataOperationsTable createAlias(String alias) {
    return $ResPartnerDataOperationsTable(attachedDatabase, alias);
  }
}

class ResPartnerData extends DataClass implements Insertable<ResPartnerData> {
  final int id;
  final int res_partner_id;
  final String name;
  final double credit;
  final double use_partner_credit_limit;
  final int credit_period;
  const ResPartnerData({
    required this.id,
    required this.res_partner_id,
    required this.name,
    required this.credit,
    required this.use_partner_credit_limit,
    required this.credit_period,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['res_partner_id'] = Variable<int>(res_partner_id);
    map['name'] = Variable<String>(name);
    map['credit'] = Variable<double>(credit);
    map['use_partner_credit_limit'] = Variable<double>(
      use_partner_credit_limit,
    );
    map['credit_period'] = Variable<int>(credit_period);
    return map;
  }

  ResPartnerDataOperationsCompanion toCompanion(bool nullToAbsent) {
    return ResPartnerDataOperationsCompanion(
      id: Value(id),
      res_partner_id: Value(res_partner_id),
      name: Value(name),
      credit: Value(credit),
      use_partner_credit_limit: Value(use_partner_credit_limit),
      credit_period: Value(credit_period),
    );
  }

  factory ResPartnerData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ResPartnerData(
      id: serializer.fromJson<int>(json['id']),
      res_partner_id: serializer.fromJson<int>(json['res_partner_id']),
      name: serializer.fromJson<String>(json['name']),
      credit: serializer.fromJson<double>(json['credit']),
      use_partner_credit_limit: serializer.fromJson<double>(
        json['use_partner_credit_limit'],
      ),
      credit_period: serializer.fromJson<int>(json['credit_period']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'res_partner_id': serializer.toJson<int>(res_partner_id),
      'name': serializer.toJson<String>(name),
      'credit': serializer.toJson<double>(credit),
      'use_partner_credit_limit': serializer.toJson<double>(
        use_partner_credit_limit,
      ),
      'credit_period': serializer.toJson<int>(credit_period),
    };
  }

  ResPartnerData copyWith({
    int? id,
    int? res_partner_id,
    String? name,
    double? credit,
    double? use_partner_credit_limit,
    int? credit_period,
  }) => ResPartnerData(
    id: id ?? this.id,
    res_partner_id: res_partner_id ?? this.res_partner_id,
    name: name ?? this.name,
    credit: credit ?? this.credit,
    use_partner_credit_limit:
        use_partner_credit_limit ?? this.use_partner_credit_limit,
    credit_period: credit_period ?? this.credit_period,
  );
  ResPartnerData copyWithCompanion(ResPartnerDataOperationsCompanion data) {
    return ResPartnerData(
      id: data.id.present ? data.id.value : this.id,
      res_partner_id:
          data.res_partner_id.present
              ? data.res_partner_id.value
              : this.res_partner_id,
      name: data.name.present ? data.name.value : this.name,
      credit: data.credit.present ? data.credit.value : this.credit,
      use_partner_credit_limit:
          data.use_partner_credit_limit.present
              ? data.use_partner_credit_limit.value
              : this.use_partner_credit_limit,
      credit_period:
          data.credit_period.present
              ? data.credit_period.value
              : this.credit_period,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ResPartnerData(')
          ..write('id: $id, ')
          ..write('res_partner_id: $res_partner_id, ')
          ..write('name: $name, ')
          ..write('credit: $credit, ')
          ..write('use_partner_credit_limit: $use_partner_credit_limit, ')
          ..write('credit_period: $credit_period')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    res_partner_id,
    name,
    credit,
    use_partner_credit_limit,
    credit_period,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ResPartnerData &&
          other.id == this.id &&
          other.res_partner_id == this.res_partner_id &&
          other.name == this.name &&
          other.credit == this.credit &&
          other.use_partner_credit_limit == this.use_partner_credit_limit &&
          other.credit_period == this.credit_period);
}

class ResPartnerDataOperationsCompanion
    extends UpdateCompanion<ResPartnerData> {
  final Value<int> id;
  final Value<int> res_partner_id;
  final Value<String> name;
  final Value<double> credit;
  final Value<double> use_partner_credit_limit;
  final Value<int> credit_period;
  const ResPartnerDataOperationsCompanion({
    this.id = const Value.absent(),
    this.res_partner_id = const Value.absent(),
    this.name = const Value.absent(),
    this.credit = const Value.absent(),
    this.use_partner_credit_limit = const Value.absent(),
    this.credit_period = const Value.absent(),
  });
  ResPartnerDataOperationsCompanion.insert({
    this.id = const Value.absent(),
    required int res_partner_id,
    required String name,
    required double credit,
    required double use_partner_credit_limit,
    required int credit_period,
  }) : res_partner_id = Value(res_partner_id),
       name = Value(name),
       credit = Value(credit),
       use_partner_credit_limit = Value(use_partner_credit_limit),
       credit_period = Value(credit_period);
  static Insertable<ResPartnerData> custom({
    Expression<int>? id,
    Expression<int>? res_partner_id,
    Expression<String>? name,
    Expression<double>? credit,
    Expression<double>? use_partner_credit_limit,
    Expression<int>? credit_period,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (res_partner_id != null) 'res_partner_id': res_partner_id,
      if (name != null) 'name': name,
      if (credit != null) 'credit': credit,
      if (use_partner_credit_limit != null)
        'use_partner_credit_limit': use_partner_credit_limit,
      if (credit_period != null) 'credit_period': credit_period,
    });
  }

  ResPartnerDataOperationsCompanion copyWith({
    Value<int>? id,
    Value<int>? res_partner_id,
    Value<String>? name,
    Value<double>? credit,
    Value<double>? use_partner_credit_limit,
    Value<int>? credit_period,
  }) {
    return ResPartnerDataOperationsCompanion(
      id: id ?? this.id,
      res_partner_id: res_partner_id ?? this.res_partner_id,
      name: name ?? this.name,
      credit: credit ?? this.credit,
      use_partner_credit_limit:
          use_partner_credit_limit ?? this.use_partner_credit_limit,
      credit_period: credit_period ?? this.credit_period,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (res_partner_id.present) {
      map['res_partner_id'] = Variable<int>(res_partner_id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (credit.present) {
      map['credit'] = Variable<double>(credit.value);
    }
    if (use_partner_credit_limit.present) {
      map['use_partner_credit_limit'] = Variable<double>(
        use_partner_credit_limit.value,
      );
    }
    if (credit_period.present) {
      map['credit_period'] = Variable<int>(credit_period.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ResPartnerDataOperationsCompanion(')
          ..write('id: $id, ')
          ..write('res_partner_id: $res_partner_id, ')
          ..write('name: $name, ')
          ..write('credit: $credit, ')
          ..write('use_partner_credit_limit: $use_partner_credit_limit, ')
          ..write('credit_period: $credit_period')
          ..write(')'))
        .toString();
  }
}

class $ReturnTypeDataOperationsTable extends ReturnTypeDataOperations
    with TableInfo<$ReturnTypeDataOperationsTable, ReturnTypeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReturnTypeDataOperationsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _return_type_idMeta = const VerificationMeta(
    'return_type_id',
  );
  @override
  late final GeneratedColumn<int> return_type_id = GeneratedColumn<int>(
    'return_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _return_type_nameMeta = const VerificationMeta(
    'return_type_name',
  );
  @override
  late final GeneratedColumn<String> return_type_name = GeneratedColumn<String>(
    'return_type_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, return_type_id, return_type_name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'return_type_data_operations';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReturnTypeData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('return_type_id')) {
      context.handle(
        _return_type_idMeta,
        return_type_id.isAcceptableOrUnknown(
          data['return_type_id']!,
          _return_type_idMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_return_type_idMeta);
    }
    if (data.containsKey('return_type_name')) {
      context.handle(
        _return_type_nameMeta,
        return_type_name.isAcceptableOrUnknown(
          data['return_type_name']!,
          _return_type_nameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_return_type_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReturnTypeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReturnTypeData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      return_type_id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}return_type_id'],
          )!,
      return_type_name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}return_type_name'],
          )!,
    );
  }

  @override
  $ReturnTypeDataOperationsTable createAlias(String alias) {
    return $ReturnTypeDataOperationsTable(attachedDatabase, alias);
  }
}

class ReturnTypeData extends DataClass implements Insertable<ReturnTypeData> {
  final int id;
  final int return_type_id;
  final String return_type_name;
  const ReturnTypeData({
    required this.id,
    required this.return_type_id,
    required this.return_type_name,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['return_type_id'] = Variable<int>(return_type_id);
    map['return_type_name'] = Variable<String>(return_type_name);
    return map;
  }

  ReturnTypeDataOperationsCompanion toCompanion(bool nullToAbsent) {
    return ReturnTypeDataOperationsCompanion(
      id: Value(id),
      return_type_id: Value(return_type_id),
      return_type_name: Value(return_type_name),
    );
  }

  factory ReturnTypeData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReturnTypeData(
      id: serializer.fromJson<int>(json['id']),
      return_type_id: serializer.fromJson<int>(json['return_type_id']),
      return_type_name: serializer.fromJson<String>(json['return_type_name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'return_type_id': serializer.toJson<int>(return_type_id),
      'return_type_name': serializer.toJson<String>(return_type_name),
    };
  }

  ReturnTypeData copyWith({
    int? id,
    int? return_type_id,
    String? return_type_name,
  }) => ReturnTypeData(
    id: id ?? this.id,
    return_type_id: return_type_id ?? this.return_type_id,
    return_type_name: return_type_name ?? this.return_type_name,
  );
  ReturnTypeData copyWithCompanion(ReturnTypeDataOperationsCompanion data) {
    return ReturnTypeData(
      id: data.id.present ? data.id.value : this.id,
      return_type_id:
          data.return_type_id.present
              ? data.return_type_id.value
              : this.return_type_id,
      return_type_name:
          data.return_type_name.present
              ? data.return_type_name.value
              : this.return_type_name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReturnTypeData(')
          ..write('id: $id, ')
          ..write('return_type_id: $return_type_id, ')
          ..write('return_type_name: $return_type_name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, return_type_id, return_type_name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReturnTypeData &&
          other.id == this.id &&
          other.return_type_id == this.return_type_id &&
          other.return_type_name == this.return_type_name);
}

class ReturnTypeDataOperationsCompanion
    extends UpdateCompanion<ReturnTypeData> {
  final Value<int> id;
  final Value<int> return_type_id;
  final Value<String> return_type_name;
  const ReturnTypeDataOperationsCompanion({
    this.id = const Value.absent(),
    this.return_type_id = const Value.absent(),
    this.return_type_name = const Value.absent(),
  });
  ReturnTypeDataOperationsCompanion.insert({
    this.id = const Value.absent(),
    required int return_type_id,
    required String return_type_name,
  }) : return_type_id = Value(return_type_id),
       return_type_name = Value(return_type_name);
  static Insertable<ReturnTypeData> custom({
    Expression<int>? id,
    Expression<int>? return_type_id,
    Expression<String>? return_type_name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (return_type_id != null) 'return_type_id': return_type_id,
      if (return_type_name != null) 'return_type_name': return_type_name,
    });
  }

  ReturnTypeDataOperationsCompanion copyWith({
    Value<int>? id,
    Value<int>? return_type_id,
    Value<String>? return_type_name,
  }) {
    return ReturnTypeDataOperationsCompanion(
      id: id ?? this.id,
      return_type_id: return_type_id ?? this.return_type_id,
      return_type_name: return_type_name ?? this.return_type_name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (return_type_id.present) {
      map['return_type_id'] = Variable<int>(return_type_id.value);
    }
    if (return_type_name.present) {
      map['return_type_name'] = Variable<String>(return_type_name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReturnTypeDataOperationsCompanion(')
          ..write('id: $id, ')
          ..write('return_type_id: $return_type_id, ')
          ..write('return_type_name: $return_type_name')
          ..write(')'))
        .toString();
  }
}

class $ReturnActionDataOperationsTable extends ReturnActionDataOperations
    with TableInfo<$ReturnActionDataOperationsTable, ReturnActionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReturnActionDataOperationsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _return_action_idMeta = const VerificationMeta(
    'return_action_id',
  );
  @override
  late final GeneratedColumn<int> return_action_id = GeneratedColumn<int>(
    'return_action_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _return_action_nameMeta =
      const VerificationMeta('return_action_name');
  @override
  late final GeneratedColumn<String> return_action_name =
      GeneratedColumn<String>(
        'return_action_name',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    return_action_id,
    return_action_name,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'return_action_data_operations';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReturnActionData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('return_action_id')) {
      context.handle(
        _return_action_idMeta,
        return_action_id.isAcceptableOrUnknown(
          data['return_action_id']!,
          _return_action_idMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_return_action_idMeta);
    }
    if (data.containsKey('return_action_name')) {
      context.handle(
        _return_action_nameMeta,
        return_action_name.isAcceptableOrUnknown(
          data['return_action_name']!,
          _return_action_nameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_return_action_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReturnActionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReturnActionData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      return_action_id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}return_action_id'],
          )!,
      return_action_name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}return_action_name'],
          )!,
    );
  }

  @override
  $ReturnActionDataOperationsTable createAlias(String alias) {
    return $ReturnActionDataOperationsTable(attachedDatabase, alias);
  }
}

class ReturnActionData extends DataClass
    implements Insertable<ReturnActionData> {
  final int id;
  final int return_action_id;
  final String return_action_name;
  const ReturnActionData({
    required this.id,
    required this.return_action_id,
    required this.return_action_name,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['return_action_id'] = Variable<int>(return_action_id);
    map['return_action_name'] = Variable<String>(return_action_name);
    return map;
  }

  ReturnActionDataOperationsCompanion toCompanion(bool nullToAbsent) {
    return ReturnActionDataOperationsCompanion(
      id: Value(id),
      return_action_id: Value(return_action_id),
      return_action_name: Value(return_action_name),
    );
  }

  factory ReturnActionData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReturnActionData(
      id: serializer.fromJson<int>(json['id']),
      return_action_id: serializer.fromJson<int>(json['return_action_id']),
      return_action_name: serializer.fromJson<String>(
        json['return_action_name'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'return_action_id': serializer.toJson<int>(return_action_id),
      'return_action_name': serializer.toJson<String>(return_action_name),
    };
  }

  ReturnActionData copyWith({
    int? id,
    int? return_action_id,
    String? return_action_name,
  }) => ReturnActionData(
    id: id ?? this.id,
    return_action_id: return_action_id ?? this.return_action_id,
    return_action_name: return_action_name ?? this.return_action_name,
  );
  ReturnActionData copyWithCompanion(ReturnActionDataOperationsCompanion data) {
    return ReturnActionData(
      id: data.id.present ? data.id.value : this.id,
      return_action_id:
          data.return_action_id.present
              ? data.return_action_id.value
              : this.return_action_id,
      return_action_name:
          data.return_action_name.present
              ? data.return_action_name.value
              : this.return_action_name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReturnActionData(')
          ..write('id: $id, ')
          ..write('return_action_id: $return_action_id, ')
          ..write('return_action_name: $return_action_name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, return_action_id, return_action_name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReturnActionData &&
          other.id == this.id &&
          other.return_action_id == this.return_action_id &&
          other.return_action_name == this.return_action_name);
}

class ReturnActionDataOperationsCompanion
    extends UpdateCompanion<ReturnActionData> {
  final Value<int> id;
  final Value<int> return_action_id;
  final Value<String> return_action_name;
  const ReturnActionDataOperationsCompanion({
    this.id = const Value.absent(),
    this.return_action_id = const Value.absent(),
    this.return_action_name = const Value.absent(),
  });
  ReturnActionDataOperationsCompanion.insert({
    this.id = const Value.absent(),
    required int return_action_id,
    required String return_action_name,
  }) : return_action_id = Value(return_action_id),
       return_action_name = Value(return_action_name);
  static Insertable<ReturnActionData> custom({
    Expression<int>? id,
    Expression<int>? return_action_id,
    Expression<String>? return_action_name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (return_action_id != null) 'return_action_id': return_action_id,
      if (return_action_name != null) 'return_action_name': return_action_name,
    });
  }

  ReturnActionDataOperationsCompanion copyWith({
    Value<int>? id,
    Value<int>? return_action_id,
    Value<String>? return_action_name,
  }) {
    return ReturnActionDataOperationsCompanion(
      id: id ?? this.id,
      return_action_id: return_action_id ?? this.return_action_id,
      return_action_name: return_action_name ?? this.return_action_name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (return_action_id.present) {
      map['return_action_id'] = Variable<int>(return_action_id.value);
    }
    if (return_action_name.present) {
      map['return_action_name'] = Variable<String>(return_action_name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReturnActionDataOperationsCompanion(')
          ..write('id: $id, ')
          ..write('return_action_id: $return_action_id, ')
          ..write('return_action_name: $return_action_name')
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
  late final $OrderProductUsageTable orderProductUsage =
      $OrderProductUsageTable(this);
  late final $ReturnProductUsageTable returnProductUsage =
      $ReturnProductUsageTable(this);
  late final $ReturnInvoicesTable returnInvoices = $ReturnInvoicesTable(this);
  late final $ProductCategoryTable productCategory = $ProductCategoryTable(
    this,
  );
  late final $ItineraryPaymentLinesTable itineraryPaymentLines =
      $ItineraryPaymentLinesTable(this);
  late final $InvoicesDataLinesTable invoicesDataLines =
      $InvoicesDataLinesTable(this);
  late final $PaymentUsageTable paymentUsage = $PaymentUsageTable(this);
  late final $VisitStatusDataLinesTable visitStatusDataLines =
      $VisitStatusDataLinesTable(this);
  late final $LoyaltyFreeIssueDataLinesTable loyaltyFreeIssueDataLines =
      $LoyaltyFreeIssueDataLinesTable(this);
  late final $DiscountDataOperationsTable discountDataOperations =
      $DiscountDataOperationsTable(this);
  late final $ResPartnerDataOperationsTable resPartnerDataOperations =
      $ResPartnerDataOperationsTable(this);
  late final $ReturnTypeDataOperationsTable returnTypeDataOperations =
      $ReturnTypeDataOperationsTable(this);
  late final $ReturnActionDataOperationsTable returnActionDataOperations =
      $ReturnActionDataOperationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    salesPersonDataOperations,
    productMaster,
    orderProductUsage,
    returnProductUsage,
    returnInvoices,
    productCategory,
    itineraryPaymentLines,
    invoicesDataLines,
    paymentUsage,
    visitStatusDataLines,
    loyaltyFreeIssueDataLines,
    discountDataOperations,
    resPartnerDataOperations,
    returnTypeDataOperations,
    returnActionDataOperations,
  ];
}

typedef $$SalesPersonDataOperationsTableCreateCompanionBuilder =
    SalesPersonDataOperationsCompanion Function({
      Value<int> id,
      required int itinerary_line_id,
      required int partner_id,
      required String partner_name,
      required String date,
      required String route_code,
      required String route_name,
      required double cusOutstandingAmount,
      Value<double?> itinerary_latitude,
      Value<double?> itinerary_longitude,
      Value<String> visit_status,
      Value<bool> isSynced,
      Value<bool> isVisited,
    });
typedef $$SalesPersonDataOperationsTableUpdateCompanionBuilder =
    SalesPersonDataOperationsCompanion Function({
      Value<int> id,
      Value<int> itinerary_line_id,
      Value<int> partner_id,
      Value<String> partner_name,
      Value<String> date,
      Value<String> route_code,
      Value<String> route_name,
      Value<double> cusOutstandingAmount,
      Value<double?> itinerary_latitude,
      Value<double?> itinerary_longitude,
      Value<String> visit_status,
      Value<bool> isSynced,
      Value<bool> isVisited,
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

  ColumnFilters<int> get partner_id => $composableBuilder(
    column: $table.partner_id,
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

  ColumnFilters<double> get cusOutstandingAmount => $composableBuilder(
    column: $table.cusOutstandingAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get itinerary_latitude => $composableBuilder(
    column: $table.itinerary_latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get itinerary_longitude => $composableBuilder(
    column: $table.itinerary_longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get visit_status => $composableBuilder(
    column: $table.visit_status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVisited => $composableBuilder(
    column: $table.isVisited,
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

  ColumnOrderings<int> get partner_id => $composableBuilder(
    column: $table.partner_id,
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

  ColumnOrderings<double> get cusOutstandingAmount => $composableBuilder(
    column: $table.cusOutstandingAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get itinerary_latitude => $composableBuilder(
    column: $table.itinerary_latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get itinerary_longitude => $composableBuilder(
    column: $table.itinerary_longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get visit_status => $composableBuilder(
    column: $table.visit_status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVisited => $composableBuilder(
    column: $table.isVisited,
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

  GeneratedColumn<int> get partner_id => $composableBuilder(
    column: $table.partner_id,
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

  GeneratedColumn<double> get cusOutstandingAmount => $composableBuilder(
    column: $table.cusOutstandingAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get itinerary_latitude => $composableBuilder(
    column: $table.itinerary_latitude,
    builder: (column) => column,
  );

  GeneratedColumn<double> get itinerary_longitude => $composableBuilder(
    column: $table.itinerary_longitude,
    builder: (column) => column,
  );

  GeneratedColumn<String> get visit_status => $composableBuilder(
    column: $table.visit_status,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<bool> get isVisited =>
      $composableBuilder(column: $table.isVisited, builder: (column) => column);
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
                Value<int> partner_id = const Value.absent(),
                Value<String> partner_name = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> route_code = const Value.absent(),
                Value<String> route_name = const Value.absent(),
                Value<double> cusOutstandingAmount = const Value.absent(),
                Value<double?> itinerary_latitude = const Value.absent(),
                Value<double?> itinerary_longitude = const Value.absent(),
                Value<String> visit_status = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> isVisited = const Value.absent(),
              }) => SalesPersonDataOperationsCompanion(
                id: id,
                itinerary_line_id: itinerary_line_id,
                partner_id: partner_id,
                partner_name: partner_name,
                date: date,
                route_code: route_code,
                route_name: route_name,
                cusOutstandingAmount: cusOutstandingAmount,
                itinerary_latitude: itinerary_latitude,
                itinerary_longitude: itinerary_longitude,
                visit_status: visit_status,
                isSynced: isSynced,
                isVisited: isVisited,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int itinerary_line_id,
                required int partner_id,
                required String partner_name,
                required String date,
                required String route_code,
                required String route_name,
                required double cusOutstandingAmount,
                Value<double?> itinerary_latitude = const Value.absent(),
                Value<double?> itinerary_longitude = const Value.absent(),
                Value<String> visit_status = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> isVisited = const Value.absent(),
              }) => SalesPersonDataOperationsCompanion.insert(
                id: id,
                itinerary_line_id: itinerary_line_id,
                partner_id: partner_id,
                partner_name: partner_name,
                date: date,
                route_code: route_code,
                route_name: route_name,
                cusOutstandingAmount: cusOutstandingAmount,
                itinerary_latitude: itinerary_latitude,
                itinerary_longitude: itinerary_longitude,
                visit_status: visit_status,
                isSynced: isSynced,
                isVisited: isVisited,
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
      required int productId,
      required String productName,
      required String displayName,
      required String imageUrl,
      required double salesPrice,
      required String itemCode,
      Value<int?> productCategoryId,
      Value<bool> isSynced,
      required bool is_discount_product,
    });
typedef $$ProductMasterTableUpdateCompanionBuilder =
    ProductMasterCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<String> productName,
      Value<String> displayName,
      Value<String> imageUrl,
      Value<double> salesPrice,
      Value<String> itemCode,
      Value<int?> productCategoryId,
      Value<bool> isSynced,
      Value<bool> is_discount_product,
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

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
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

  ColumnFilters<int> get productCategoryId => $composableBuilder(
    column: $table.productCategoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get is_discount_product => $composableBuilder(
    column: $table.is_discount_product,
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

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
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

  ColumnOrderings<int> get productCategoryId => $composableBuilder(
    column: $table.productCategoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get is_discount_product => $composableBuilder(
    column: $table.is_discount_product,
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

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
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

  GeneratedColumn<int> get productCategoryId => $composableBuilder(
    column: $table.productCategoryId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<bool> get is_discount_product => $composableBuilder(
    column: $table.is_discount_product,
    builder: (column) => column,
  );
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
                Value<int> productId = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<double> salesPrice = const Value.absent(),
                Value<String> itemCode = const Value.absent(),
                Value<int?> productCategoryId = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<bool> is_discount_product = const Value.absent(),
              }) => ProductMasterCompanion(
                id: id,
                productId: productId,
                productName: productName,
                displayName: displayName,
                imageUrl: imageUrl,
                salesPrice: salesPrice,
                itemCode: itemCode,
                productCategoryId: productCategoryId,
                isSynced: isSynced,
                is_discount_product: is_discount_product,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                required String productName,
                required String displayName,
                required String imageUrl,
                required double salesPrice,
                required String itemCode,
                Value<int?> productCategoryId = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                required bool is_discount_product,
              }) => ProductMasterCompanion.insert(
                id: id,
                productId: productId,
                productName: productName,
                displayName: displayName,
                imageUrl: imageUrl,
                salesPrice: salesPrice,
                itemCode: itemCode,
                productCategoryId: productCategoryId,
                isSynced: isSynced,
                is_discount_product: is_discount_product,
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
typedef $$OrderProductUsageTableCreateCompanionBuilder =
    OrderProductUsageCompanion Function({
      Value<int> id,
      Value<int> odooId,
      required int itineraryLineId,
      required int productId,
      Value<bool> is_reward,
      Value<bool> isFreeProduct,
      Value<bool> isDiscountProduct,
      Value<String> displayDiscountProduct,
      Value<double> discountProductPrice,
      Value<double> discountPercentage,
      Value<int> stock_lot_id,
      Value<double> reward_amount,
      Value<int> adQty,
      Value<bool> isSynced,
    });
typedef $$OrderProductUsageTableUpdateCompanionBuilder =
    OrderProductUsageCompanion Function({
      Value<int> id,
      Value<int> odooId,
      Value<int> itineraryLineId,
      Value<int> productId,
      Value<bool> is_reward,
      Value<bool> isFreeProduct,
      Value<bool> isDiscountProduct,
      Value<String> displayDiscountProduct,
      Value<double> discountProductPrice,
      Value<double> discountPercentage,
      Value<int> stock_lot_id,
      Value<double> reward_amount,
      Value<int> adQty,
      Value<bool> isSynced,
    });

class $$OrderProductUsageTableFilterComposer
    extends Composer<_$AppDatabase, $OrderProductUsageTable> {
  $$OrderProductUsageTableFilterComposer({
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

  ColumnFilters<int> get odooId => $composableBuilder(
    column: $table.odooId,
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

  ColumnFilters<bool> get is_reward => $composableBuilder(
    column: $table.is_reward,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFreeProduct => $composableBuilder(
    column: $table.isFreeProduct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDiscountProduct => $composableBuilder(
    column: $table.isDiscountProduct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayDiscountProduct => $composableBuilder(
    column: $table.displayDiscountProduct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discountProductPrice => $composableBuilder(
    column: $table.discountProductPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discountPercentage => $composableBuilder(
    column: $table.discountPercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stock_lot_id => $composableBuilder(
    column: $table.stock_lot_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get reward_amount => $composableBuilder(
    column: $table.reward_amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get adQty => $composableBuilder(
    column: $table.adQty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OrderProductUsageTableOrderingComposer
    extends Composer<_$AppDatabase, $OrderProductUsageTable> {
  $$OrderProductUsageTableOrderingComposer({
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

  ColumnOrderings<int> get odooId => $composableBuilder(
    column: $table.odooId,
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

  ColumnOrderings<bool> get is_reward => $composableBuilder(
    column: $table.is_reward,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFreeProduct => $composableBuilder(
    column: $table.isFreeProduct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDiscountProduct => $composableBuilder(
    column: $table.isDiscountProduct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayDiscountProduct => $composableBuilder(
    column: $table.displayDiscountProduct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discountProductPrice => $composableBuilder(
    column: $table.discountProductPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discountPercentage => $composableBuilder(
    column: $table.discountPercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stock_lot_id => $composableBuilder(
    column: $table.stock_lot_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get reward_amount => $composableBuilder(
    column: $table.reward_amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get adQty => $composableBuilder(
    column: $table.adQty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OrderProductUsageTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrderProductUsageTable> {
  $$OrderProductUsageTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get odooId =>
      $composableBuilder(column: $table.odooId, builder: (column) => column);

  GeneratedColumn<int> get itineraryLineId => $composableBuilder(
    column: $table.itineraryLineId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<bool> get is_reward =>
      $composableBuilder(column: $table.is_reward, builder: (column) => column);

  GeneratedColumn<bool> get isFreeProduct => $composableBuilder(
    column: $table.isFreeProduct,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDiscountProduct => $composableBuilder(
    column: $table.isDiscountProduct,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayDiscountProduct => $composableBuilder(
    column: $table.displayDiscountProduct,
    builder: (column) => column,
  );

  GeneratedColumn<double> get discountProductPrice => $composableBuilder(
    column: $table.discountProductPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get discountPercentage => $composableBuilder(
    column: $table.discountPercentage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stock_lot_id => $composableBuilder(
    column: $table.stock_lot_id,
    builder: (column) => column,
  );

  GeneratedColumn<double> get reward_amount => $composableBuilder(
    column: $table.reward_amount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get adQty =>
      $composableBuilder(column: $table.adQty, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$OrderProductUsageTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrderProductUsageTable,
          OrderProductUsageData,
          $$OrderProductUsageTableFilterComposer,
          $$OrderProductUsageTableOrderingComposer,
          $$OrderProductUsageTableAnnotationComposer,
          $$OrderProductUsageTableCreateCompanionBuilder,
          $$OrderProductUsageTableUpdateCompanionBuilder,
          (
            OrderProductUsageData,
            BaseReferences<
              _$AppDatabase,
              $OrderProductUsageTable,
              OrderProductUsageData
            >,
          ),
          OrderProductUsageData,
          PrefetchHooks Function()
        > {
  $$OrderProductUsageTableTableManager(
    _$AppDatabase db,
    $OrderProductUsageTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$OrderProductUsageTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$OrderProductUsageTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$OrderProductUsageTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> odooId = const Value.absent(),
                Value<int> itineraryLineId = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<bool> is_reward = const Value.absent(),
                Value<bool> isFreeProduct = const Value.absent(),
                Value<bool> isDiscountProduct = const Value.absent(),
                Value<String> displayDiscountProduct = const Value.absent(),
                Value<double> discountProductPrice = const Value.absent(),
                Value<double> discountPercentage = const Value.absent(),
                Value<int> stock_lot_id = const Value.absent(),
                Value<double> reward_amount = const Value.absent(),
                Value<int> adQty = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
              }) => OrderProductUsageCompanion(
                id: id,
                odooId: odooId,
                itineraryLineId: itineraryLineId,
                productId: productId,
                is_reward: is_reward,
                isFreeProduct: isFreeProduct,
                isDiscountProduct: isDiscountProduct,
                displayDiscountProduct: displayDiscountProduct,
                discountProductPrice: discountProductPrice,
                discountPercentage: discountPercentage,
                stock_lot_id: stock_lot_id,
                reward_amount: reward_amount,
                adQty: adQty,
                isSynced: isSynced,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> odooId = const Value.absent(),
                required int itineraryLineId,
                required int productId,
                Value<bool> is_reward = const Value.absent(),
                Value<bool> isFreeProduct = const Value.absent(),
                Value<bool> isDiscountProduct = const Value.absent(),
                Value<String> displayDiscountProduct = const Value.absent(),
                Value<double> discountProductPrice = const Value.absent(),
                Value<double> discountPercentage = const Value.absent(),
                Value<int> stock_lot_id = const Value.absent(),
                Value<double> reward_amount = const Value.absent(),
                Value<int> adQty = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
              }) => OrderProductUsageCompanion.insert(
                id: id,
                odooId: odooId,
                itineraryLineId: itineraryLineId,
                productId: productId,
                is_reward: is_reward,
                isFreeProduct: isFreeProduct,
                isDiscountProduct: isDiscountProduct,
                displayDiscountProduct: displayDiscountProduct,
                discountProductPrice: discountProductPrice,
                discountPercentage: discountPercentage,
                stock_lot_id: stock_lot_id,
                reward_amount: reward_amount,
                adQty: adQty,
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

typedef $$OrderProductUsageTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrderProductUsageTable,
      OrderProductUsageData,
      $$OrderProductUsageTableFilterComposer,
      $$OrderProductUsageTableOrderingComposer,
      $$OrderProductUsageTableAnnotationComposer,
      $$OrderProductUsageTableCreateCompanionBuilder,
      $$OrderProductUsageTableUpdateCompanionBuilder,
      (
        OrderProductUsageData,
        BaseReferences<
          _$AppDatabase,
          $OrderProductUsageTable,
          OrderProductUsageData
        >,
      ),
      OrderProductUsageData,
      PrefetchHooks Function()
    >;
typedef $$ReturnProductUsageTableCreateCompanionBuilder =
    ReturnProductUsageCompanion Function({
      Value<int> id,
      Value<int> odooId,
      required int itineraryLineId,
      required int productId,
      Value<String> return_reason,
      Value<String> return_invoices_display_name,
      Value<double> invoiceSalesPrice,
      Value<int> returnQty,
      Value<bool> isSynced,
      Value<int> return_reason_id,
      Value<int> return_action_id,
      Value<bool> isAddedInvoicesReturn,
    });
typedef $$ReturnProductUsageTableUpdateCompanionBuilder =
    ReturnProductUsageCompanion Function({
      Value<int> id,
      Value<int> odooId,
      Value<int> itineraryLineId,
      Value<int> productId,
      Value<String> return_reason,
      Value<String> return_invoices_display_name,
      Value<double> invoiceSalesPrice,
      Value<int> returnQty,
      Value<bool> isSynced,
      Value<int> return_reason_id,
      Value<int> return_action_id,
      Value<bool> isAddedInvoicesReturn,
    });

class $$ReturnProductUsageTableFilterComposer
    extends Composer<_$AppDatabase, $ReturnProductUsageTable> {
  $$ReturnProductUsageTableFilterComposer({
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

  ColumnFilters<int> get odooId => $composableBuilder(
    column: $table.odooId,
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

  ColumnFilters<String> get return_reason => $composableBuilder(
    column: $table.return_reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get return_invoices_display_name => $composableBuilder(
    column: $table.return_invoices_display_name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get invoiceSalesPrice => $composableBuilder(
    column: $table.invoiceSalesPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get returnQty => $composableBuilder(
    column: $table.returnQty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get return_reason_id => $composableBuilder(
    column: $table.return_reason_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get return_action_id => $composableBuilder(
    column: $table.return_action_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAddedInvoicesReturn => $composableBuilder(
    column: $table.isAddedInvoicesReturn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReturnProductUsageTableOrderingComposer
    extends Composer<_$AppDatabase, $ReturnProductUsageTable> {
  $$ReturnProductUsageTableOrderingComposer({
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

  ColumnOrderings<int> get odooId => $composableBuilder(
    column: $table.odooId,
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

  ColumnOrderings<String> get return_reason => $composableBuilder(
    column: $table.return_reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get return_invoices_display_name =>
      $composableBuilder(
        column: $table.return_invoices_display_name,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<double> get invoiceSalesPrice => $composableBuilder(
    column: $table.invoiceSalesPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get returnQty => $composableBuilder(
    column: $table.returnQty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get return_reason_id => $composableBuilder(
    column: $table.return_reason_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get return_action_id => $composableBuilder(
    column: $table.return_action_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAddedInvoicesReturn => $composableBuilder(
    column: $table.isAddedInvoicesReturn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReturnProductUsageTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReturnProductUsageTable> {
  $$ReturnProductUsageTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get odooId =>
      $composableBuilder(column: $table.odooId, builder: (column) => column);

  GeneratedColumn<int> get itineraryLineId => $composableBuilder(
    column: $table.itineraryLineId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get return_reason => $composableBuilder(
    column: $table.return_reason,
    builder: (column) => column,
  );

  GeneratedColumn<String> get return_invoices_display_name =>
      $composableBuilder(
        column: $table.return_invoices_display_name,
        builder: (column) => column,
      );

  GeneratedColumn<double> get invoiceSalesPrice => $composableBuilder(
    column: $table.invoiceSalesPrice,
    builder: (column) => column,
  );

  GeneratedColumn<int> get returnQty =>
      $composableBuilder(column: $table.returnQty, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<int> get return_reason_id => $composableBuilder(
    column: $table.return_reason_id,
    builder: (column) => column,
  );

  GeneratedColumn<int> get return_action_id => $composableBuilder(
    column: $table.return_action_id,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isAddedInvoicesReturn => $composableBuilder(
    column: $table.isAddedInvoicesReturn,
    builder: (column) => column,
  );
}

class $$ReturnProductUsageTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReturnProductUsageTable,
          ReturnProductUsageData,
          $$ReturnProductUsageTableFilterComposer,
          $$ReturnProductUsageTableOrderingComposer,
          $$ReturnProductUsageTableAnnotationComposer,
          $$ReturnProductUsageTableCreateCompanionBuilder,
          $$ReturnProductUsageTableUpdateCompanionBuilder,
          (
            ReturnProductUsageData,
            BaseReferences<
              _$AppDatabase,
              $ReturnProductUsageTable,
              ReturnProductUsageData
            >,
          ),
          ReturnProductUsageData,
          PrefetchHooks Function()
        > {
  $$ReturnProductUsageTableTableManager(
    _$AppDatabase db,
    $ReturnProductUsageTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ReturnProductUsageTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$ReturnProductUsageTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$ReturnProductUsageTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> odooId = const Value.absent(),
                Value<int> itineraryLineId = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<String> return_reason = const Value.absent(),
                Value<String> return_invoices_display_name =
                    const Value.absent(),
                Value<double> invoiceSalesPrice = const Value.absent(),
                Value<int> returnQty = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> return_reason_id = const Value.absent(),
                Value<int> return_action_id = const Value.absent(),
                Value<bool> isAddedInvoicesReturn = const Value.absent(),
              }) => ReturnProductUsageCompanion(
                id: id,
                odooId: odooId,
                itineraryLineId: itineraryLineId,
                productId: productId,
                return_reason: return_reason,
                return_invoices_display_name: return_invoices_display_name,
                invoiceSalesPrice: invoiceSalesPrice,
                returnQty: returnQty,
                isSynced: isSynced,
                return_reason_id: return_reason_id,
                return_action_id: return_action_id,
                isAddedInvoicesReturn: isAddedInvoicesReturn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> odooId = const Value.absent(),
                required int itineraryLineId,
                required int productId,
                Value<String> return_reason = const Value.absent(),
                Value<String> return_invoices_display_name =
                    const Value.absent(),
                Value<double> invoiceSalesPrice = const Value.absent(),
                Value<int> returnQty = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> return_reason_id = const Value.absent(),
                Value<int> return_action_id = const Value.absent(),
                Value<bool> isAddedInvoicesReturn = const Value.absent(),
              }) => ReturnProductUsageCompanion.insert(
                id: id,
                odooId: odooId,
                itineraryLineId: itineraryLineId,
                productId: productId,
                return_reason: return_reason,
                return_invoices_display_name: return_invoices_display_name,
                invoiceSalesPrice: invoiceSalesPrice,
                returnQty: returnQty,
                isSynced: isSynced,
                return_reason_id: return_reason_id,
                return_action_id: return_action_id,
                isAddedInvoicesReturn: isAddedInvoicesReturn,
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

typedef $$ReturnProductUsageTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReturnProductUsageTable,
      ReturnProductUsageData,
      $$ReturnProductUsageTableFilterComposer,
      $$ReturnProductUsageTableOrderingComposer,
      $$ReturnProductUsageTableAnnotationComposer,
      $$ReturnProductUsageTableCreateCompanionBuilder,
      $$ReturnProductUsageTableUpdateCompanionBuilder,
      (
        ReturnProductUsageData,
        BaseReferences<
          _$AppDatabase,
          $ReturnProductUsageTable,
          ReturnProductUsageData
        >,
      ),
      ReturnProductUsageData,
      PrefetchHooks Function()
    >;
typedef $$ReturnInvoicesTableCreateCompanionBuilder =
    ReturnInvoicesCompanion Function({
      Value<int> id,
      required int move_id,
      required int account_move_line_id,
      required int productId,
      required String productDisplayName,
      required String return_reason,
      required int returnQty,
      required double unitPrice,
    });
typedef $$ReturnInvoicesTableUpdateCompanionBuilder =
    ReturnInvoicesCompanion Function({
      Value<int> id,
      Value<int> move_id,
      Value<int> account_move_line_id,
      Value<int> productId,
      Value<String> productDisplayName,
      Value<String> return_reason,
      Value<int> returnQty,
      Value<double> unitPrice,
    });

class $$ReturnInvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $ReturnInvoicesTable> {
  $$ReturnInvoicesTableFilterComposer({
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

  ColumnFilters<int> get move_id => $composableBuilder(
    column: $table.move_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get account_move_line_id => $composableBuilder(
    column: $table.account_move_line_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productDisplayName => $composableBuilder(
    column: $table.productDisplayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get return_reason => $composableBuilder(
    column: $table.return_reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get returnQty => $composableBuilder(
    column: $table.returnQty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReturnInvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $ReturnInvoicesTable> {
  $$ReturnInvoicesTableOrderingComposer({
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

  ColumnOrderings<int> get move_id => $composableBuilder(
    column: $table.move_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get account_move_line_id => $composableBuilder(
    column: $table.account_move_line_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productDisplayName => $composableBuilder(
    column: $table.productDisplayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get return_reason => $composableBuilder(
    column: $table.return_reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get returnQty => $composableBuilder(
    column: $table.returnQty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReturnInvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReturnInvoicesTable> {
  $$ReturnInvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get move_id =>
      $composableBuilder(column: $table.move_id, builder: (column) => column);

  GeneratedColumn<int> get account_move_line_id => $composableBuilder(
    column: $table.account_move_line_id,
    builder: (column) => column,
  );

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get productDisplayName => $composableBuilder(
    column: $table.productDisplayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get return_reason => $composableBuilder(
    column: $table.return_reason,
    builder: (column) => column,
  );

  GeneratedColumn<int> get returnQty =>
      $composableBuilder(column: $table.returnQty, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);
}

class $$ReturnInvoicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReturnInvoicesTable,
          ReturnInvoicesData,
          $$ReturnInvoicesTableFilterComposer,
          $$ReturnInvoicesTableOrderingComposer,
          $$ReturnInvoicesTableAnnotationComposer,
          $$ReturnInvoicesTableCreateCompanionBuilder,
          $$ReturnInvoicesTableUpdateCompanionBuilder,
          (
            ReturnInvoicesData,
            BaseReferences<
              _$AppDatabase,
              $ReturnInvoicesTable,
              ReturnInvoicesData
            >,
          ),
          ReturnInvoicesData,
          PrefetchHooks Function()
        > {
  $$ReturnInvoicesTableTableManager(
    _$AppDatabase db,
    $ReturnInvoicesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ReturnInvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$ReturnInvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ReturnInvoicesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> move_id = const Value.absent(),
                Value<int> account_move_line_id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<String> productDisplayName = const Value.absent(),
                Value<String> return_reason = const Value.absent(),
                Value<int> returnQty = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
              }) => ReturnInvoicesCompanion(
                id: id,
                move_id: move_id,
                account_move_line_id: account_move_line_id,
                productId: productId,
                productDisplayName: productDisplayName,
                return_reason: return_reason,
                returnQty: returnQty,
                unitPrice: unitPrice,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int move_id,
                required int account_move_line_id,
                required int productId,
                required String productDisplayName,
                required String return_reason,
                required int returnQty,
                required double unitPrice,
              }) => ReturnInvoicesCompanion.insert(
                id: id,
                move_id: move_id,
                account_move_line_id: account_move_line_id,
                productId: productId,
                productDisplayName: productDisplayName,
                return_reason: return_reason,
                returnQty: returnQty,
                unitPrice: unitPrice,
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

typedef $$ReturnInvoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReturnInvoicesTable,
      ReturnInvoicesData,
      $$ReturnInvoicesTableFilterComposer,
      $$ReturnInvoicesTableOrderingComposer,
      $$ReturnInvoicesTableAnnotationComposer,
      $$ReturnInvoicesTableCreateCompanionBuilder,
      $$ReturnInvoicesTableUpdateCompanionBuilder,
      (
        ReturnInvoicesData,
        BaseReferences<_$AppDatabase, $ReturnInvoicesTable, ReturnInvoicesData>,
      ),
      ReturnInvoicesData,
      PrefetchHooks Function()
    >;
typedef $$ProductCategoryTableCreateCompanionBuilder =
    ProductCategoryCompanion Function({
      Value<int> id,
      required int categoryId,
      required String displayName,
      required String itinerary_discount_ids,
    });
typedef $$ProductCategoryTableUpdateCompanionBuilder =
    ProductCategoryCompanion Function({
      Value<int> id,
      Value<int> categoryId,
      Value<String> displayName,
      Value<String> itinerary_discount_ids,
    });

class $$ProductCategoryTableFilterComposer
    extends Composer<_$AppDatabase, $ProductCategoryTable> {
  $$ProductCategoryTableFilterComposer({
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

  ColumnFilters<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itinerary_discount_ids => $composableBuilder(
    column: $table.itinerary_discount_ids,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductCategoryTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductCategoryTable> {
  $$ProductCategoryTableOrderingComposer({
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

  ColumnOrderings<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itinerary_discount_ids => $composableBuilder(
    column: $table.itinerary_discount_ids,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductCategoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductCategoryTable> {
  $$ProductCategoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get itinerary_discount_ids => $composableBuilder(
    column: $table.itinerary_discount_ids,
    builder: (column) => column,
  );
}

class $$ProductCategoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductCategoryTable,
          ProductCategoryData,
          $$ProductCategoryTableFilterComposer,
          $$ProductCategoryTableOrderingComposer,
          $$ProductCategoryTableAnnotationComposer,
          $$ProductCategoryTableCreateCompanionBuilder,
          $$ProductCategoryTableUpdateCompanionBuilder,
          (
            ProductCategoryData,
            BaseReferences<
              _$AppDatabase,
              $ProductCategoryTable,
              ProductCategoryData
            >,
          ),
          ProductCategoryData,
          PrefetchHooks Function()
        > {
  $$ProductCategoryTableTableManager(
    _$AppDatabase db,
    $ProductCategoryTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$ProductCategoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ProductCategoryTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$ProductCategoryTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> itinerary_discount_ids = const Value.absent(),
              }) => ProductCategoryCompanion(
                id: id,
                categoryId: categoryId,
                displayName: displayName,
                itinerary_discount_ids: itinerary_discount_ids,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int categoryId,
                required String displayName,
                required String itinerary_discount_ids,
              }) => ProductCategoryCompanion.insert(
                id: id,
                categoryId: categoryId,
                displayName: displayName,
                itinerary_discount_ids: itinerary_discount_ids,
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

typedef $$ProductCategoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductCategoryTable,
      ProductCategoryData,
      $$ProductCategoryTableFilterComposer,
      $$ProductCategoryTableOrderingComposer,
      $$ProductCategoryTableAnnotationComposer,
      $$ProductCategoryTableCreateCompanionBuilder,
      $$ProductCategoryTableUpdateCompanionBuilder,
      (
        ProductCategoryData,
        BaseReferences<
          _$AppDatabase,
          $ProductCategoryTable,
          ProductCategoryData
        >,
      ),
      ProductCategoryData,
      PrefetchHooks Function()
    >;
typedef $$ItineraryPaymentLinesTableCreateCompanionBuilder =
    ItineraryPaymentLinesCompanion Function({
      Value<int> id,
      required int payment_line_id,
      required int itinerary_line_id,
      required String date,
      required int invoice_id,
      required String invoice_name,
      required String invoice_date,
      required String payment_method,
      Value<String?> cheque_number,
      Value<String?> cheque_date,
      required double invoice_amount,
      required double amount,
    });
typedef $$ItineraryPaymentLinesTableUpdateCompanionBuilder =
    ItineraryPaymentLinesCompanion Function({
      Value<int> id,
      Value<int> payment_line_id,
      Value<int> itinerary_line_id,
      Value<String> date,
      Value<int> invoice_id,
      Value<String> invoice_name,
      Value<String> invoice_date,
      Value<String> payment_method,
      Value<String?> cheque_number,
      Value<String?> cheque_date,
      Value<double> invoice_amount,
      Value<double> amount,
    });

class $$ItineraryPaymentLinesTableFilterComposer
    extends Composer<_$AppDatabase, $ItineraryPaymentLinesTable> {
  $$ItineraryPaymentLinesTableFilterComposer({
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

  ColumnFilters<int> get payment_line_id => $composableBuilder(
    column: $table.payment_line_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get itinerary_line_id => $composableBuilder(
    column: $table.itinerary_line_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get invoice_id => $composableBuilder(
    column: $table.invoice_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoice_name => $composableBuilder(
    column: $table.invoice_name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoice_date => $composableBuilder(
    column: $table.invoice_date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payment_method => $composableBuilder(
    column: $table.payment_method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cheque_number => $composableBuilder(
    column: $table.cheque_number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cheque_date => $composableBuilder(
    column: $table.cheque_date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get invoice_amount => $composableBuilder(
    column: $table.invoice_amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ItineraryPaymentLinesTableOrderingComposer
    extends Composer<_$AppDatabase, $ItineraryPaymentLinesTable> {
  $$ItineraryPaymentLinesTableOrderingComposer({
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

  ColumnOrderings<int> get payment_line_id => $composableBuilder(
    column: $table.payment_line_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get itinerary_line_id => $composableBuilder(
    column: $table.itinerary_line_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get invoice_id => $composableBuilder(
    column: $table.invoice_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoice_name => $composableBuilder(
    column: $table.invoice_name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoice_date => $composableBuilder(
    column: $table.invoice_date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payment_method => $composableBuilder(
    column: $table.payment_method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cheque_number => $composableBuilder(
    column: $table.cheque_number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cheque_date => $composableBuilder(
    column: $table.cheque_date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get invoice_amount => $composableBuilder(
    column: $table.invoice_amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ItineraryPaymentLinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItineraryPaymentLinesTable> {
  $$ItineraryPaymentLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get payment_line_id => $composableBuilder(
    column: $table.payment_line_id,
    builder: (column) => column,
  );

  GeneratedColumn<int> get itinerary_line_id => $composableBuilder(
    column: $table.itinerary_line_id,
    builder: (column) => column,
  );

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get invoice_id => $composableBuilder(
    column: $table.invoice_id,
    builder: (column) => column,
  );

  GeneratedColumn<String> get invoice_name => $composableBuilder(
    column: $table.invoice_name,
    builder: (column) => column,
  );

  GeneratedColumn<String> get invoice_date => $composableBuilder(
    column: $table.invoice_date,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payment_method => $composableBuilder(
    column: $table.payment_method,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cheque_number => $composableBuilder(
    column: $table.cheque_number,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cheque_date => $composableBuilder(
    column: $table.cheque_date,
    builder: (column) => column,
  );

  GeneratedColumn<double> get invoice_amount => $composableBuilder(
    column: $table.invoice_amount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);
}

class $$ItineraryPaymentLinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ItineraryPaymentLinesTable,
          ItineraryPaymentLineData,
          $$ItineraryPaymentLinesTableFilterComposer,
          $$ItineraryPaymentLinesTableOrderingComposer,
          $$ItineraryPaymentLinesTableAnnotationComposer,
          $$ItineraryPaymentLinesTableCreateCompanionBuilder,
          $$ItineraryPaymentLinesTableUpdateCompanionBuilder,
          (
            ItineraryPaymentLineData,
            BaseReferences<
              _$AppDatabase,
              $ItineraryPaymentLinesTable,
              ItineraryPaymentLineData
            >,
          ),
          ItineraryPaymentLineData,
          PrefetchHooks Function()
        > {
  $$ItineraryPaymentLinesTableTableManager(
    _$AppDatabase db,
    $ItineraryPaymentLinesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ItineraryPaymentLinesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$ItineraryPaymentLinesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$ItineraryPaymentLinesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> payment_line_id = const Value.absent(),
                Value<int> itinerary_line_id = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<int> invoice_id = const Value.absent(),
                Value<String> invoice_name = const Value.absent(),
                Value<String> invoice_date = const Value.absent(),
                Value<String> payment_method = const Value.absent(),
                Value<String?> cheque_number = const Value.absent(),
                Value<String?> cheque_date = const Value.absent(),
                Value<double> invoice_amount = const Value.absent(),
                Value<double> amount = const Value.absent(),
              }) => ItineraryPaymentLinesCompanion(
                id: id,
                payment_line_id: payment_line_id,
                itinerary_line_id: itinerary_line_id,
                date: date,
                invoice_id: invoice_id,
                invoice_name: invoice_name,
                invoice_date: invoice_date,
                payment_method: payment_method,
                cheque_number: cheque_number,
                cheque_date: cheque_date,
                invoice_amount: invoice_amount,
                amount: amount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int payment_line_id,
                required int itinerary_line_id,
                required String date,
                required int invoice_id,
                required String invoice_name,
                required String invoice_date,
                required String payment_method,
                Value<String?> cheque_number = const Value.absent(),
                Value<String?> cheque_date = const Value.absent(),
                required double invoice_amount,
                required double amount,
              }) => ItineraryPaymentLinesCompanion.insert(
                id: id,
                payment_line_id: payment_line_id,
                itinerary_line_id: itinerary_line_id,
                date: date,
                invoice_id: invoice_id,
                invoice_name: invoice_name,
                invoice_date: invoice_date,
                payment_method: payment_method,
                cheque_number: cheque_number,
                cheque_date: cheque_date,
                invoice_amount: invoice_amount,
                amount: amount,
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

typedef $$ItineraryPaymentLinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ItineraryPaymentLinesTable,
      ItineraryPaymentLineData,
      $$ItineraryPaymentLinesTableFilterComposer,
      $$ItineraryPaymentLinesTableOrderingComposer,
      $$ItineraryPaymentLinesTableAnnotationComposer,
      $$ItineraryPaymentLinesTableCreateCompanionBuilder,
      $$ItineraryPaymentLinesTableUpdateCompanionBuilder,
      (
        ItineraryPaymentLineData,
        BaseReferences<
          _$AppDatabase,
          $ItineraryPaymentLinesTable,
          ItineraryPaymentLineData
        >,
      ),
      ItineraryPaymentLineData,
      PrefetchHooks Function()
    >;
typedef $$InvoicesDataLinesTableCreateCompanionBuilder =
    InvoicesDataLinesCompanion Function({
      Value<int> id,
      required int partner_id,
      required int invoice_id,
      required String invoice_name,
      required String invoice_due_date,
      required String invoice_date,
      required String payment_status,
      required double amount_residual,
      required String move_type,
      required String state,
      required double invoice_amount,
    });
typedef $$InvoicesDataLinesTableUpdateCompanionBuilder =
    InvoicesDataLinesCompanion Function({
      Value<int> id,
      Value<int> partner_id,
      Value<int> invoice_id,
      Value<String> invoice_name,
      Value<String> invoice_due_date,
      Value<String> invoice_date,
      Value<String> payment_status,
      Value<double> amount_residual,
      Value<String> move_type,
      Value<String> state,
      Value<double> invoice_amount,
    });

class $$InvoicesDataLinesTableFilterComposer
    extends Composer<_$AppDatabase, $InvoicesDataLinesTable> {
  $$InvoicesDataLinesTableFilterComposer({
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

  ColumnFilters<int> get partner_id => $composableBuilder(
    column: $table.partner_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get invoice_id => $composableBuilder(
    column: $table.invoice_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoice_name => $composableBuilder(
    column: $table.invoice_name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoice_due_date => $composableBuilder(
    column: $table.invoice_due_date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoice_date => $composableBuilder(
    column: $table.invoice_date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payment_status => $composableBuilder(
    column: $table.payment_status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount_residual => $composableBuilder(
    column: $table.amount_residual,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get move_type => $composableBuilder(
    column: $table.move_type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get invoice_amount => $composableBuilder(
    column: $table.invoice_amount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InvoicesDataLinesTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoicesDataLinesTable> {
  $$InvoicesDataLinesTableOrderingComposer({
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

  ColumnOrderings<int> get partner_id => $composableBuilder(
    column: $table.partner_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get invoice_id => $composableBuilder(
    column: $table.invoice_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoice_name => $composableBuilder(
    column: $table.invoice_name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoice_due_date => $composableBuilder(
    column: $table.invoice_due_date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoice_date => $composableBuilder(
    column: $table.invoice_date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payment_status => $composableBuilder(
    column: $table.payment_status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount_residual => $composableBuilder(
    column: $table.amount_residual,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get move_type => $composableBuilder(
    column: $table.move_type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get invoice_amount => $composableBuilder(
    column: $table.invoice_amount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InvoicesDataLinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicesDataLinesTable> {
  $$InvoicesDataLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get partner_id => $composableBuilder(
    column: $table.partner_id,
    builder: (column) => column,
  );

  GeneratedColumn<int> get invoice_id => $composableBuilder(
    column: $table.invoice_id,
    builder: (column) => column,
  );

  GeneratedColumn<String> get invoice_name => $composableBuilder(
    column: $table.invoice_name,
    builder: (column) => column,
  );

  GeneratedColumn<String> get invoice_due_date => $composableBuilder(
    column: $table.invoice_due_date,
    builder: (column) => column,
  );

  GeneratedColumn<String> get invoice_date => $composableBuilder(
    column: $table.invoice_date,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payment_status => $composableBuilder(
    column: $table.payment_status,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount_residual => $composableBuilder(
    column: $table.amount_residual,
    builder: (column) => column,
  );

  GeneratedColumn<String> get move_type =>
      $composableBuilder(column: $table.move_type, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<double> get invoice_amount => $composableBuilder(
    column: $table.invoice_amount,
    builder: (column) => column,
  );
}

class $$InvoicesDataLinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoicesDataLinesTable,
          InvoicesData,
          $$InvoicesDataLinesTableFilterComposer,
          $$InvoicesDataLinesTableOrderingComposer,
          $$InvoicesDataLinesTableAnnotationComposer,
          $$InvoicesDataLinesTableCreateCompanionBuilder,
          $$InvoicesDataLinesTableUpdateCompanionBuilder,
          (
            InvoicesData,
            BaseReferences<
              _$AppDatabase,
              $InvoicesDataLinesTable,
              InvoicesData
            >,
          ),
          InvoicesData,
          PrefetchHooks Function()
        > {
  $$InvoicesDataLinesTableTableManager(
    _$AppDatabase db,
    $InvoicesDataLinesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$InvoicesDataLinesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$InvoicesDataLinesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$InvoicesDataLinesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> partner_id = const Value.absent(),
                Value<int> invoice_id = const Value.absent(),
                Value<String> invoice_name = const Value.absent(),
                Value<String> invoice_due_date = const Value.absent(),
                Value<String> invoice_date = const Value.absent(),
                Value<String> payment_status = const Value.absent(),
                Value<double> amount_residual = const Value.absent(),
                Value<String> move_type = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<double> invoice_amount = const Value.absent(),
              }) => InvoicesDataLinesCompanion(
                id: id,
                partner_id: partner_id,
                invoice_id: invoice_id,
                invoice_name: invoice_name,
                invoice_due_date: invoice_due_date,
                invoice_date: invoice_date,
                payment_status: payment_status,
                amount_residual: amount_residual,
                move_type: move_type,
                state: state,
                invoice_amount: invoice_amount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int partner_id,
                required int invoice_id,
                required String invoice_name,
                required String invoice_due_date,
                required String invoice_date,
                required String payment_status,
                required double amount_residual,
                required String move_type,
                required String state,
                required double invoice_amount,
              }) => InvoicesDataLinesCompanion.insert(
                id: id,
                partner_id: partner_id,
                invoice_id: invoice_id,
                invoice_name: invoice_name,
                invoice_due_date: invoice_due_date,
                invoice_date: invoice_date,
                payment_status: payment_status,
                amount_residual: amount_residual,
                move_type: move_type,
                state: state,
                invoice_amount: invoice_amount,
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

typedef $$InvoicesDataLinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoicesDataLinesTable,
      InvoicesData,
      $$InvoicesDataLinesTableFilterComposer,
      $$InvoicesDataLinesTableOrderingComposer,
      $$InvoicesDataLinesTableAnnotationComposer,
      $$InvoicesDataLinesTableCreateCompanionBuilder,
      $$InvoicesDataLinesTableUpdateCompanionBuilder,
      (
        InvoicesData,
        BaseReferences<_$AppDatabase, $InvoicesDataLinesTable, InvoicesData>,
      ),
      InvoicesData,
      PrefetchHooks Function()
    >;
typedef $$PaymentUsageTableCreateCompanionBuilder =
    PaymentUsageCompanion Function({
      Value<int> id,
      Value<int> odooId,
      required int payment_line_id,
      required int itinerary_line_id,
      required String date,
      required int invoice_id,
      required String invoice_name,
      required String invoice_date,
      required String payment_method,
      Value<String?> cheque_number,
      Value<String?> cheque_date,
      required double invoice_amount,
      required double amount,
      Value<bool> isExciteOrNew,
      Value<bool> isSynced,
    });
typedef $$PaymentUsageTableUpdateCompanionBuilder =
    PaymentUsageCompanion Function({
      Value<int> id,
      Value<int> odooId,
      Value<int> payment_line_id,
      Value<int> itinerary_line_id,
      Value<String> date,
      Value<int> invoice_id,
      Value<String> invoice_name,
      Value<String> invoice_date,
      Value<String> payment_method,
      Value<String?> cheque_number,
      Value<String?> cheque_date,
      Value<double> invoice_amount,
      Value<double> amount,
      Value<bool> isExciteOrNew,
      Value<bool> isSynced,
    });

class $$PaymentUsageTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentUsageTable> {
  $$PaymentUsageTableFilterComposer({
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

  ColumnFilters<int> get odooId => $composableBuilder(
    column: $table.odooId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get payment_line_id => $composableBuilder(
    column: $table.payment_line_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get itinerary_line_id => $composableBuilder(
    column: $table.itinerary_line_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get invoice_id => $composableBuilder(
    column: $table.invoice_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoice_name => $composableBuilder(
    column: $table.invoice_name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoice_date => $composableBuilder(
    column: $table.invoice_date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payment_method => $composableBuilder(
    column: $table.payment_method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cheque_number => $composableBuilder(
    column: $table.cheque_number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cheque_date => $composableBuilder(
    column: $table.cheque_date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get invoice_amount => $composableBuilder(
    column: $table.invoice_amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isExciteOrNew => $composableBuilder(
    column: $table.isExciteOrNew,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PaymentUsageTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentUsageTable> {
  $$PaymentUsageTableOrderingComposer({
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

  ColumnOrderings<int> get odooId => $composableBuilder(
    column: $table.odooId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get payment_line_id => $composableBuilder(
    column: $table.payment_line_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get itinerary_line_id => $composableBuilder(
    column: $table.itinerary_line_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get invoice_id => $composableBuilder(
    column: $table.invoice_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoice_name => $composableBuilder(
    column: $table.invoice_name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoice_date => $composableBuilder(
    column: $table.invoice_date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payment_method => $composableBuilder(
    column: $table.payment_method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cheque_number => $composableBuilder(
    column: $table.cheque_number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cheque_date => $composableBuilder(
    column: $table.cheque_date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get invoice_amount => $composableBuilder(
    column: $table.invoice_amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isExciteOrNew => $composableBuilder(
    column: $table.isExciteOrNew,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PaymentUsageTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentUsageTable> {
  $$PaymentUsageTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get odooId =>
      $composableBuilder(column: $table.odooId, builder: (column) => column);

  GeneratedColumn<int> get payment_line_id => $composableBuilder(
    column: $table.payment_line_id,
    builder: (column) => column,
  );

  GeneratedColumn<int> get itinerary_line_id => $composableBuilder(
    column: $table.itinerary_line_id,
    builder: (column) => column,
  );

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get invoice_id => $composableBuilder(
    column: $table.invoice_id,
    builder: (column) => column,
  );

  GeneratedColumn<String> get invoice_name => $composableBuilder(
    column: $table.invoice_name,
    builder: (column) => column,
  );

  GeneratedColumn<String> get invoice_date => $composableBuilder(
    column: $table.invoice_date,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payment_method => $composableBuilder(
    column: $table.payment_method,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cheque_number => $composableBuilder(
    column: $table.cheque_number,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cheque_date => $composableBuilder(
    column: $table.cheque_date,
    builder: (column) => column,
  );

  GeneratedColumn<double> get invoice_amount => $composableBuilder(
    column: $table.invoice_amount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<bool> get isExciteOrNew => $composableBuilder(
    column: $table.isExciteOrNew,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$PaymentUsageTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentUsageTable,
          PaymentUsageData,
          $$PaymentUsageTableFilterComposer,
          $$PaymentUsageTableOrderingComposer,
          $$PaymentUsageTableAnnotationComposer,
          $$PaymentUsageTableCreateCompanionBuilder,
          $$PaymentUsageTableUpdateCompanionBuilder,
          (
            PaymentUsageData,
            BaseReferences<_$AppDatabase, $PaymentUsageTable, PaymentUsageData>,
          ),
          PaymentUsageData,
          PrefetchHooks Function()
        > {
  $$PaymentUsageTableTableManager(_$AppDatabase db, $PaymentUsageTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$PaymentUsageTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$PaymentUsageTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$PaymentUsageTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> odooId = const Value.absent(),
                Value<int> payment_line_id = const Value.absent(),
                Value<int> itinerary_line_id = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<int> invoice_id = const Value.absent(),
                Value<String> invoice_name = const Value.absent(),
                Value<String> invoice_date = const Value.absent(),
                Value<String> payment_method = const Value.absent(),
                Value<String?> cheque_number = const Value.absent(),
                Value<String?> cheque_date = const Value.absent(),
                Value<double> invoice_amount = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<bool> isExciteOrNew = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
              }) => PaymentUsageCompanion(
                id: id,
                odooId: odooId,
                payment_line_id: payment_line_id,
                itinerary_line_id: itinerary_line_id,
                date: date,
                invoice_id: invoice_id,
                invoice_name: invoice_name,
                invoice_date: invoice_date,
                payment_method: payment_method,
                cheque_number: cheque_number,
                cheque_date: cheque_date,
                invoice_amount: invoice_amount,
                amount: amount,
                isExciteOrNew: isExciteOrNew,
                isSynced: isSynced,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> odooId = const Value.absent(),
                required int payment_line_id,
                required int itinerary_line_id,
                required String date,
                required int invoice_id,
                required String invoice_name,
                required String invoice_date,
                required String payment_method,
                Value<String?> cheque_number = const Value.absent(),
                Value<String?> cheque_date = const Value.absent(),
                required double invoice_amount,
                required double amount,
                Value<bool> isExciteOrNew = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
              }) => PaymentUsageCompanion.insert(
                id: id,
                odooId: odooId,
                payment_line_id: payment_line_id,
                itinerary_line_id: itinerary_line_id,
                date: date,
                invoice_id: invoice_id,
                invoice_name: invoice_name,
                invoice_date: invoice_date,
                payment_method: payment_method,
                cheque_number: cheque_number,
                cheque_date: cheque_date,
                invoice_amount: invoice_amount,
                amount: amount,
                isExciteOrNew: isExciteOrNew,
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

typedef $$PaymentUsageTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentUsageTable,
      PaymentUsageData,
      $$PaymentUsageTableFilterComposer,
      $$PaymentUsageTableOrderingComposer,
      $$PaymentUsageTableAnnotationComposer,
      $$PaymentUsageTableCreateCompanionBuilder,
      $$PaymentUsageTableUpdateCompanionBuilder,
      (
        PaymentUsageData,
        BaseReferences<_$AppDatabase, $PaymentUsageTable, PaymentUsageData>,
      ),
      PaymentUsageData,
      PrefetchHooks Function()
    >;
typedef $$VisitStatusDataLinesTableCreateCompanionBuilder =
    VisitStatusDataLinesCompanion Function({
      Value<int> id,
      required int status_id,
      required String visitStatus,
    });
typedef $$VisitStatusDataLinesTableUpdateCompanionBuilder =
    VisitStatusDataLinesCompanion Function({
      Value<int> id,
      Value<int> status_id,
      Value<String> visitStatus,
    });

class $$VisitStatusDataLinesTableFilterComposer
    extends Composer<_$AppDatabase, $VisitStatusDataLinesTable> {
  $$VisitStatusDataLinesTableFilterComposer({
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

  ColumnFilters<int> get status_id => $composableBuilder(
    column: $table.status_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get visitStatus => $composableBuilder(
    column: $table.visitStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VisitStatusDataLinesTableOrderingComposer
    extends Composer<_$AppDatabase, $VisitStatusDataLinesTable> {
  $$VisitStatusDataLinesTableOrderingComposer({
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

  ColumnOrderings<int> get status_id => $composableBuilder(
    column: $table.status_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get visitStatus => $composableBuilder(
    column: $table.visitStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VisitStatusDataLinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VisitStatusDataLinesTable> {
  $$VisitStatusDataLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get status_id =>
      $composableBuilder(column: $table.status_id, builder: (column) => column);

  GeneratedColumn<String> get visitStatus => $composableBuilder(
    column: $table.visitStatus,
    builder: (column) => column,
  );
}

class $$VisitStatusDataLinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VisitStatusDataLinesTable,
          VisitStatus,
          $$VisitStatusDataLinesTableFilterComposer,
          $$VisitStatusDataLinesTableOrderingComposer,
          $$VisitStatusDataLinesTableAnnotationComposer,
          $$VisitStatusDataLinesTableCreateCompanionBuilder,
          $$VisitStatusDataLinesTableUpdateCompanionBuilder,
          (
            VisitStatus,
            BaseReferences<
              _$AppDatabase,
              $VisitStatusDataLinesTable,
              VisitStatus
            >,
          ),
          VisitStatus,
          PrefetchHooks Function()
        > {
  $$VisitStatusDataLinesTableTableManager(
    _$AppDatabase db,
    $VisitStatusDataLinesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$VisitStatusDataLinesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$VisitStatusDataLinesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$VisitStatusDataLinesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> status_id = const Value.absent(),
                Value<String> visitStatus = const Value.absent(),
              }) => VisitStatusDataLinesCompanion(
                id: id,
                status_id: status_id,
                visitStatus: visitStatus,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int status_id,
                required String visitStatus,
              }) => VisitStatusDataLinesCompanion.insert(
                id: id,
                status_id: status_id,
                visitStatus: visitStatus,
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

typedef $$VisitStatusDataLinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VisitStatusDataLinesTable,
      VisitStatus,
      $$VisitStatusDataLinesTableFilterComposer,
      $$VisitStatusDataLinesTableOrderingComposer,
      $$VisitStatusDataLinesTableAnnotationComposer,
      $$VisitStatusDataLinesTableCreateCompanionBuilder,
      $$VisitStatusDataLinesTableUpdateCompanionBuilder,
      (
        VisitStatus,
        BaseReferences<_$AppDatabase, $VisitStatusDataLinesTable, VisitStatus>,
      ),
      VisitStatus,
      PrefetchHooks Function()
    >;
typedef $$LoyaltyFreeIssueDataLinesTableCreateCompanionBuilder =
    LoyaltyFreeIssueDataLinesCompanion Function({
      Value<int> id,
      required int productId,
      required String displayName,
      required int minimumQty,
      required int stock_lot_id,
      required int reward_product_qty,
    });
typedef $$LoyaltyFreeIssueDataLinesTableUpdateCompanionBuilder =
    LoyaltyFreeIssueDataLinesCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<String> displayName,
      Value<int> minimumQty,
      Value<int> stock_lot_id,
      Value<int> reward_product_qty,
    });

class $$LoyaltyFreeIssueDataLinesTableFilterComposer
    extends Composer<_$AppDatabase, $LoyaltyFreeIssueDataLinesTable> {
  $$LoyaltyFreeIssueDataLinesTableFilterComposer({
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

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minimumQty => $composableBuilder(
    column: $table.minimumQty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stock_lot_id => $composableBuilder(
    column: $table.stock_lot_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reward_product_qty => $composableBuilder(
    column: $table.reward_product_qty,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LoyaltyFreeIssueDataLinesTableOrderingComposer
    extends Composer<_$AppDatabase, $LoyaltyFreeIssueDataLinesTable> {
  $$LoyaltyFreeIssueDataLinesTableOrderingComposer({
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

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minimumQty => $composableBuilder(
    column: $table.minimumQty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stock_lot_id => $composableBuilder(
    column: $table.stock_lot_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reward_product_qty => $composableBuilder(
    column: $table.reward_product_qty,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LoyaltyFreeIssueDataLinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LoyaltyFreeIssueDataLinesTable> {
  $$LoyaltyFreeIssueDataLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get minimumQty => $composableBuilder(
    column: $table.minimumQty,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stock_lot_id => $composableBuilder(
    column: $table.stock_lot_id,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reward_product_qty => $composableBuilder(
    column: $table.reward_product_qty,
    builder: (column) => column,
  );
}

class $$LoyaltyFreeIssueDataLinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LoyaltyFreeIssueDataLinesTable,
          LoyaltyFreeIssue,
          $$LoyaltyFreeIssueDataLinesTableFilterComposer,
          $$LoyaltyFreeIssueDataLinesTableOrderingComposer,
          $$LoyaltyFreeIssueDataLinesTableAnnotationComposer,
          $$LoyaltyFreeIssueDataLinesTableCreateCompanionBuilder,
          $$LoyaltyFreeIssueDataLinesTableUpdateCompanionBuilder,
          (
            LoyaltyFreeIssue,
            BaseReferences<
              _$AppDatabase,
              $LoyaltyFreeIssueDataLinesTable,
              LoyaltyFreeIssue
            >,
          ),
          LoyaltyFreeIssue,
          PrefetchHooks Function()
        > {
  $$LoyaltyFreeIssueDataLinesTableTableManager(
    _$AppDatabase db,
    $LoyaltyFreeIssueDataLinesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$LoyaltyFreeIssueDataLinesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$LoyaltyFreeIssueDataLinesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$LoyaltyFreeIssueDataLinesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<int> minimumQty = const Value.absent(),
                Value<int> stock_lot_id = const Value.absent(),
                Value<int> reward_product_qty = const Value.absent(),
              }) => LoyaltyFreeIssueDataLinesCompanion(
                id: id,
                productId: productId,
                displayName: displayName,
                minimumQty: minimumQty,
                stock_lot_id: stock_lot_id,
                reward_product_qty: reward_product_qty,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                required String displayName,
                required int minimumQty,
                required int stock_lot_id,
                required int reward_product_qty,
              }) => LoyaltyFreeIssueDataLinesCompanion.insert(
                id: id,
                productId: productId,
                displayName: displayName,
                minimumQty: minimumQty,
                stock_lot_id: stock_lot_id,
                reward_product_qty: reward_product_qty,
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

typedef $$LoyaltyFreeIssueDataLinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LoyaltyFreeIssueDataLinesTable,
      LoyaltyFreeIssue,
      $$LoyaltyFreeIssueDataLinesTableFilterComposer,
      $$LoyaltyFreeIssueDataLinesTableOrderingComposer,
      $$LoyaltyFreeIssueDataLinesTableAnnotationComposer,
      $$LoyaltyFreeIssueDataLinesTableCreateCompanionBuilder,
      $$LoyaltyFreeIssueDataLinesTableUpdateCompanionBuilder,
      (
        LoyaltyFreeIssue,
        BaseReferences<
          _$AppDatabase,
          $LoyaltyFreeIssueDataLinesTable,
          LoyaltyFreeIssue
        >,
      ),
      LoyaltyFreeIssue,
      PrefetchHooks Function()
    >;
typedef $$DiscountDataOperationsTableCreateCompanionBuilder =
    DiscountDataOperationsCompanion Function({
      Value<int> id,
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
    });
typedef $$DiscountDataOperationsTableUpdateCompanionBuilder =
    DiscountDataOperationsCompanion Function({
      Value<int> id,
      Value<int> discount_id,
      Value<String> name,
      Value<double> discount_percentage,
      Value<String> start_date,
      Value<String> end_date,
      Value<int> discount_product_id,
      Value<String> discount_product_name,
      Value<bool> is_active,
      Value<double> minimum_amount,
      Value<double> maximum_amount,
      Value<String> not_issue_discount_products_ids,
    });

class $$DiscountDataOperationsTableFilterComposer
    extends Composer<_$AppDatabase, $DiscountDataOperationsTable> {
  $$DiscountDataOperationsTableFilterComposer({
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

  ColumnFilters<int> get discount_id => $composableBuilder(
    column: $table.discount_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discount_percentage => $composableBuilder(
    column: $table.discount_percentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get start_date => $composableBuilder(
    column: $table.start_date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get end_date => $composableBuilder(
    column: $table.end_date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discount_product_id => $composableBuilder(
    column: $table.discount_product_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get discount_product_name => $composableBuilder(
    column: $table.discount_product_name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get is_active => $composableBuilder(
    column: $table.is_active,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get minimum_amount => $composableBuilder(
    column: $table.minimum_amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maximum_amount => $composableBuilder(
    column: $table.maximum_amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get not_issue_discount_products_ids =>
      $composableBuilder(
        column: $table.not_issue_discount_products_ids,
        builder: (column) => ColumnFilters(column),
      );
}

class $$DiscountDataOperationsTableOrderingComposer
    extends Composer<_$AppDatabase, $DiscountDataOperationsTable> {
  $$DiscountDataOperationsTableOrderingComposer({
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

  ColumnOrderings<int> get discount_id => $composableBuilder(
    column: $table.discount_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discount_percentage => $composableBuilder(
    column: $table.discount_percentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get start_date => $composableBuilder(
    column: $table.start_date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get end_date => $composableBuilder(
    column: $table.end_date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discount_product_id => $composableBuilder(
    column: $table.discount_product_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get discount_product_name => $composableBuilder(
    column: $table.discount_product_name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get is_active => $composableBuilder(
    column: $table.is_active,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get minimum_amount => $composableBuilder(
    column: $table.minimum_amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maximum_amount => $composableBuilder(
    column: $table.maximum_amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get not_issue_discount_products_ids =>
      $composableBuilder(
        column: $table.not_issue_discount_products_ids,
        builder: (column) => ColumnOrderings(column),
      );
}

class $$DiscountDataOperationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DiscountDataOperationsTable> {
  $$DiscountDataOperationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get discount_id => $composableBuilder(
    column: $table.discount_id,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get discount_percentage => $composableBuilder(
    column: $table.discount_percentage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get start_date => $composableBuilder(
    column: $table.start_date,
    builder: (column) => column,
  );

  GeneratedColumn<String> get end_date =>
      $composableBuilder(column: $table.end_date, builder: (column) => column);

  GeneratedColumn<int> get discount_product_id => $composableBuilder(
    column: $table.discount_product_id,
    builder: (column) => column,
  );

  GeneratedColumn<String> get discount_product_name => $composableBuilder(
    column: $table.discount_product_name,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get is_active =>
      $composableBuilder(column: $table.is_active, builder: (column) => column);

  GeneratedColumn<double> get minimum_amount => $composableBuilder(
    column: $table.minimum_amount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maximum_amount => $composableBuilder(
    column: $table.maximum_amount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get not_issue_discount_products_ids =>
      $composableBuilder(
        column: $table.not_issue_discount_products_ids,
        builder: (column) => column,
      );
}

class $$DiscountDataOperationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DiscountDataOperationsTable,
          DiscountData,
          $$DiscountDataOperationsTableFilterComposer,
          $$DiscountDataOperationsTableOrderingComposer,
          $$DiscountDataOperationsTableAnnotationComposer,
          $$DiscountDataOperationsTableCreateCompanionBuilder,
          $$DiscountDataOperationsTableUpdateCompanionBuilder,
          (
            DiscountData,
            BaseReferences<
              _$AppDatabase,
              $DiscountDataOperationsTable,
              DiscountData
            >,
          ),
          DiscountData,
          PrefetchHooks Function()
        > {
  $$DiscountDataOperationsTableTableManager(
    _$AppDatabase db,
    $DiscountDataOperationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$DiscountDataOperationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$DiscountDataOperationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$DiscountDataOperationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> discount_id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> discount_percentage = const Value.absent(),
                Value<String> start_date = const Value.absent(),
                Value<String> end_date = const Value.absent(),
                Value<int> discount_product_id = const Value.absent(),
                Value<String> discount_product_name = const Value.absent(),
                Value<bool> is_active = const Value.absent(),
                Value<double> minimum_amount = const Value.absent(),
                Value<double> maximum_amount = const Value.absent(),
                Value<String> not_issue_discount_products_ids =
                    const Value.absent(),
              }) => DiscountDataOperationsCompanion(
                id: id,
                discount_id: discount_id,
                name: name,
                discount_percentage: discount_percentage,
                start_date: start_date,
                end_date: end_date,
                discount_product_id: discount_product_id,
                discount_product_name: discount_product_name,
                is_active: is_active,
                minimum_amount: minimum_amount,
                maximum_amount: maximum_amount,
                not_issue_discount_products_ids:
                    not_issue_discount_products_ids,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
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
              }) => DiscountDataOperationsCompanion.insert(
                id: id,
                discount_id: discount_id,
                name: name,
                discount_percentage: discount_percentage,
                start_date: start_date,
                end_date: end_date,
                discount_product_id: discount_product_id,
                discount_product_name: discount_product_name,
                is_active: is_active,
                minimum_amount: minimum_amount,
                maximum_amount: maximum_amount,
                not_issue_discount_products_ids:
                    not_issue_discount_products_ids,
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

typedef $$DiscountDataOperationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DiscountDataOperationsTable,
      DiscountData,
      $$DiscountDataOperationsTableFilterComposer,
      $$DiscountDataOperationsTableOrderingComposer,
      $$DiscountDataOperationsTableAnnotationComposer,
      $$DiscountDataOperationsTableCreateCompanionBuilder,
      $$DiscountDataOperationsTableUpdateCompanionBuilder,
      (
        DiscountData,
        BaseReferences<
          _$AppDatabase,
          $DiscountDataOperationsTable,
          DiscountData
        >,
      ),
      DiscountData,
      PrefetchHooks Function()
    >;
typedef $$ResPartnerDataOperationsTableCreateCompanionBuilder =
    ResPartnerDataOperationsCompanion Function({
      Value<int> id,
      required int res_partner_id,
      required String name,
      required double credit,
      required double use_partner_credit_limit,
      required int credit_period,
    });
typedef $$ResPartnerDataOperationsTableUpdateCompanionBuilder =
    ResPartnerDataOperationsCompanion Function({
      Value<int> id,
      Value<int> res_partner_id,
      Value<String> name,
      Value<double> credit,
      Value<double> use_partner_credit_limit,
      Value<int> credit_period,
    });

class $$ResPartnerDataOperationsTableFilterComposer
    extends Composer<_$AppDatabase, $ResPartnerDataOperationsTable> {
  $$ResPartnerDataOperationsTableFilterComposer({
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

  ColumnFilters<int> get res_partner_id => $composableBuilder(
    column: $table.res_partner_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get credit => $composableBuilder(
    column: $table.credit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get use_partner_credit_limit => $composableBuilder(
    column: $table.use_partner_credit_limit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get credit_period => $composableBuilder(
    column: $table.credit_period,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ResPartnerDataOperationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ResPartnerDataOperationsTable> {
  $$ResPartnerDataOperationsTableOrderingComposer({
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

  ColumnOrderings<int> get res_partner_id => $composableBuilder(
    column: $table.res_partner_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get credit => $composableBuilder(
    column: $table.credit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get use_partner_credit_limit => $composableBuilder(
    column: $table.use_partner_credit_limit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get credit_period => $composableBuilder(
    column: $table.credit_period,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ResPartnerDataOperationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ResPartnerDataOperationsTable> {
  $$ResPartnerDataOperationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get res_partner_id => $composableBuilder(
    column: $table.res_partner_id,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get credit =>
      $composableBuilder(column: $table.credit, builder: (column) => column);

  GeneratedColumn<double> get use_partner_credit_limit => $composableBuilder(
    column: $table.use_partner_credit_limit,
    builder: (column) => column,
  );

  GeneratedColumn<int> get credit_period => $composableBuilder(
    column: $table.credit_period,
    builder: (column) => column,
  );
}

class $$ResPartnerDataOperationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ResPartnerDataOperationsTable,
          ResPartnerData,
          $$ResPartnerDataOperationsTableFilterComposer,
          $$ResPartnerDataOperationsTableOrderingComposer,
          $$ResPartnerDataOperationsTableAnnotationComposer,
          $$ResPartnerDataOperationsTableCreateCompanionBuilder,
          $$ResPartnerDataOperationsTableUpdateCompanionBuilder,
          (
            ResPartnerData,
            BaseReferences<
              _$AppDatabase,
              $ResPartnerDataOperationsTable,
              ResPartnerData
            >,
          ),
          ResPartnerData,
          PrefetchHooks Function()
        > {
  $$ResPartnerDataOperationsTableTableManager(
    _$AppDatabase db,
    $ResPartnerDataOperationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ResPartnerDataOperationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$ResPartnerDataOperationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$ResPartnerDataOperationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> res_partner_id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> credit = const Value.absent(),
                Value<double> use_partner_credit_limit = const Value.absent(),
                Value<int> credit_period = const Value.absent(),
              }) => ResPartnerDataOperationsCompanion(
                id: id,
                res_partner_id: res_partner_id,
                name: name,
                credit: credit,
                use_partner_credit_limit: use_partner_credit_limit,
                credit_period: credit_period,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int res_partner_id,
                required String name,
                required double credit,
                required double use_partner_credit_limit,
                required int credit_period,
              }) => ResPartnerDataOperationsCompanion.insert(
                id: id,
                res_partner_id: res_partner_id,
                name: name,
                credit: credit,
                use_partner_credit_limit: use_partner_credit_limit,
                credit_period: credit_period,
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

typedef $$ResPartnerDataOperationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ResPartnerDataOperationsTable,
      ResPartnerData,
      $$ResPartnerDataOperationsTableFilterComposer,
      $$ResPartnerDataOperationsTableOrderingComposer,
      $$ResPartnerDataOperationsTableAnnotationComposer,
      $$ResPartnerDataOperationsTableCreateCompanionBuilder,
      $$ResPartnerDataOperationsTableUpdateCompanionBuilder,
      (
        ResPartnerData,
        BaseReferences<
          _$AppDatabase,
          $ResPartnerDataOperationsTable,
          ResPartnerData
        >,
      ),
      ResPartnerData,
      PrefetchHooks Function()
    >;
typedef $$ReturnTypeDataOperationsTableCreateCompanionBuilder =
    ReturnTypeDataOperationsCompanion Function({
      Value<int> id,
      required int return_type_id,
      required String return_type_name,
    });
typedef $$ReturnTypeDataOperationsTableUpdateCompanionBuilder =
    ReturnTypeDataOperationsCompanion Function({
      Value<int> id,
      Value<int> return_type_id,
      Value<String> return_type_name,
    });

class $$ReturnTypeDataOperationsTableFilterComposer
    extends Composer<_$AppDatabase, $ReturnTypeDataOperationsTable> {
  $$ReturnTypeDataOperationsTableFilterComposer({
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

  ColumnFilters<int> get return_type_id => $composableBuilder(
    column: $table.return_type_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get return_type_name => $composableBuilder(
    column: $table.return_type_name,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReturnTypeDataOperationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReturnTypeDataOperationsTable> {
  $$ReturnTypeDataOperationsTableOrderingComposer({
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

  ColumnOrderings<int> get return_type_id => $composableBuilder(
    column: $table.return_type_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get return_type_name => $composableBuilder(
    column: $table.return_type_name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReturnTypeDataOperationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReturnTypeDataOperationsTable> {
  $$ReturnTypeDataOperationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get return_type_id => $composableBuilder(
    column: $table.return_type_id,
    builder: (column) => column,
  );

  GeneratedColumn<String> get return_type_name => $composableBuilder(
    column: $table.return_type_name,
    builder: (column) => column,
  );
}

class $$ReturnTypeDataOperationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReturnTypeDataOperationsTable,
          ReturnTypeData,
          $$ReturnTypeDataOperationsTableFilterComposer,
          $$ReturnTypeDataOperationsTableOrderingComposer,
          $$ReturnTypeDataOperationsTableAnnotationComposer,
          $$ReturnTypeDataOperationsTableCreateCompanionBuilder,
          $$ReturnTypeDataOperationsTableUpdateCompanionBuilder,
          (
            ReturnTypeData,
            BaseReferences<
              _$AppDatabase,
              $ReturnTypeDataOperationsTable,
              ReturnTypeData
            >,
          ),
          ReturnTypeData,
          PrefetchHooks Function()
        > {
  $$ReturnTypeDataOperationsTableTableManager(
    _$AppDatabase db,
    $ReturnTypeDataOperationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ReturnTypeDataOperationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$ReturnTypeDataOperationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$ReturnTypeDataOperationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> return_type_id = const Value.absent(),
                Value<String> return_type_name = const Value.absent(),
              }) => ReturnTypeDataOperationsCompanion(
                id: id,
                return_type_id: return_type_id,
                return_type_name: return_type_name,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int return_type_id,
                required String return_type_name,
              }) => ReturnTypeDataOperationsCompanion.insert(
                id: id,
                return_type_id: return_type_id,
                return_type_name: return_type_name,
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

typedef $$ReturnTypeDataOperationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReturnTypeDataOperationsTable,
      ReturnTypeData,
      $$ReturnTypeDataOperationsTableFilterComposer,
      $$ReturnTypeDataOperationsTableOrderingComposer,
      $$ReturnTypeDataOperationsTableAnnotationComposer,
      $$ReturnTypeDataOperationsTableCreateCompanionBuilder,
      $$ReturnTypeDataOperationsTableUpdateCompanionBuilder,
      (
        ReturnTypeData,
        BaseReferences<
          _$AppDatabase,
          $ReturnTypeDataOperationsTable,
          ReturnTypeData
        >,
      ),
      ReturnTypeData,
      PrefetchHooks Function()
    >;
typedef $$ReturnActionDataOperationsTableCreateCompanionBuilder =
    ReturnActionDataOperationsCompanion Function({
      Value<int> id,
      required int return_action_id,
      required String return_action_name,
    });
typedef $$ReturnActionDataOperationsTableUpdateCompanionBuilder =
    ReturnActionDataOperationsCompanion Function({
      Value<int> id,
      Value<int> return_action_id,
      Value<String> return_action_name,
    });

class $$ReturnActionDataOperationsTableFilterComposer
    extends Composer<_$AppDatabase, $ReturnActionDataOperationsTable> {
  $$ReturnActionDataOperationsTableFilterComposer({
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

  ColumnFilters<int> get return_action_id => $composableBuilder(
    column: $table.return_action_id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get return_action_name => $composableBuilder(
    column: $table.return_action_name,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReturnActionDataOperationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReturnActionDataOperationsTable> {
  $$ReturnActionDataOperationsTableOrderingComposer({
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

  ColumnOrderings<int> get return_action_id => $composableBuilder(
    column: $table.return_action_id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get return_action_name => $composableBuilder(
    column: $table.return_action_name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReturnActionDataOperationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReturnActionDataOperationsTable> {
  $$ReturnActionDataOperationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get return_action_id => $composableBuilder(
    column: $table.return_action_id,
    builder: (column) => column,
  );

  GeneratedColumn<String> get return_action_name => $composableBuilder(
    column: $table.return_action_name,
    builder: (column) => column,
  );
}

class $$ReturnActionDataOperationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReturnActionDataOperationsTable,
          ReturnActionData,
          $$ReturnActionDataOperationsTableFilterComposer,
          $$ReturnActionDataOperationsTableOrderingComposer,
          $$ReturnActionDataOperationsTableAnnotationComposer,
          $$ReturnActionDataOperationsTableCreateCompanionBuilder,
          $$ReturnActionDataOperationsTableUpdateCompanionBuilder,
          (
            ReturnActionData,
            BaseReferences<
              _$AppDatabase,
              $ReturnActionDataOperationsTable,
              ReturnActionData
            >,
          ),
          ReturnActionData,
          PrefetchHooks Function()
        > {
  $$ReturnActionDataOperationsTableTableManager(
    _$AppDatabase db,
    $ReturnActionDataOperationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ReturnActionDataOperationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$ReturnActionDataOperationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$ReturnActionDataOperationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> return_action_id = const Value.absent(),
                Value<String> return_action_name = const Value.absent(),
              }) => ReturnActionDataOperationsCompanion(
                id: id,
                return_action_id: return_action_id,
                return_action_name: return_action_name,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int return_action_id,
                required String return_action_name,
              }) => ReturnActionDataOperationsCompanion.insert(
                id: id,
                return_action_id: return_action_id,
                return_action_name: return_action_name,
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

typedef $$ReturnActionDataOperationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReturnActionDataOperationsTable,
      ReturnActionData,
      $$ReturnActionDataOperationsTableFilterComposer,
      $$ReturnActionDataOperationsTableOrderingComposer,
      $$ReturnActionDataOperationsTableAnnotationComposer,
      $$ReturnActionDataOperationsTableCreateCompanionBuilder,
      $$ReturnActionDataOperationsTableUpdateCompanionBuilder,
      (
        ReturnActionData,
        BaseReferences<
          _$AppDatabase,
          $ReturnActionDataOperationsTable,
          ReturnActionData
        >,
      ),
      ReturnActionData,
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
  $$OrderProductUsageTableTableManager get orderProductUsage =>
      $$OrderProductUsageTableTableManager(_db, _db.orderProductUsage);
  $$ReturnProductUsageTableTableManager get returnProductUsage =>
      $$ReturnProductUsageTableTableManager(_db, _db.returnProductUsage);
  $$ReturnInvoicesTableTableManager get returnInvoices =>
      $$ReturnInvoicesTableTableManager(_db, _db.returnInvoices);
  $$ProductCategoryTableTableManager get productCategory =>
      $$ProductCategoryTableTableManager(_db, _db.productCategory);
  $$ItineraryPaymentLinesTableTableManager get itineraryPaymentLines =>
      $$ItineraryPaymentLinesTableTableManager(_db, _db.itineraryPaymentLines);
  $$InvoicesDataLinesTableTableManager get invoicesDataLines =>
      $$InvoicesDataLinesTableTableManager(_db, _db.invoicesDataLines);
  $$PaymentUsageTableTableManager get paymentUsage =>
      $$PaymentUsageTableTableManager(_db, _db.paymentUsage);
  $$VisitStatusDataLinesTableTableManager get visitStatusDataLines =>
      $$VisitStatusDataLinesTableTableManager(_db, _db.visitStatusDataLines);
  $$LoyaltyFreeIssueDataLinesTableTableManager get loyaltyFreeIssueDataLines =>
      $$LoyaltyFreeIssueDataLinesTableTableManager(
        _db,
        _db.loyaltyFreeIssueDataLines,
      );
  $$DiscountDataOperationsTableTableManager get discountDataOperations =>
      $$DiscountDataOperationsTableTableManager(
        _db,
        _db.discountDataOperations,
      );
  $$ResPartnerDataOperationsTableTableManager get resPartnerDataOperations =>
      $$ResPartnerDataOperationsTableTableManager(
        _db,
        _db.resPartnerDataOperations,
      );
  $$ReturnTypeDataOperationsTableTableManager get returnTypeDataOperations =>
      $$ReturnTypeDataOperationsTableTableManager(
        _db,
        _db.returnTypeDataOperations,
      );
  $$ReturnActionDataOperationsTableTableManager
  get returnActionDataOperations =>
      $$ReturnActionDataOperationsTableTableManager(
        _db,
        _db.returnActionDataOperations,
      );
}
