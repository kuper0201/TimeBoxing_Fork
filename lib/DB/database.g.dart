// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TimeBoxingInfoTable extends TimeBoxingInfo
    with TableInfo<$TimeBoxingInfoTable, TimeBoxingInfoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimeBoxingInfoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _taskMeta = const VerificationMeta('task');
  @override
  late final GeneratedColumn<String> task = GeneratedColumn<String>(
      'task', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
      'priority', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<int> startTime = GeneratedColumn<int>(
      'start_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<int> endTime = GeneratedColumn<int>(
      'end_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [date, task, priority, startTime, endTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'time_boxing_info';
  @override
  VerificationContext validateIntegrity(Insertable<TimeBoxingInfoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('task')) {
      context.handle(
          _taskMeta, task.isAcceptableOrUnknown(data['task']!, _taskMeta));
    } else if (isInserting) {
      context.missing(_taskMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  TimeBoxingInfoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimeBoxingInfoData(
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      task: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task'])!,
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_time'])!,
    );
  }

  @override
  $TimeBoxingInfoTable createAlias(String alias) {
    return $TimeBoxingInfoTable(attachedDatabase, alias);
  }
}

class TimeBoxingInfoData extends DataClass
    implements Insertable<TimeBoxingInfoData> {
  final DateTime date;
  final String task;
  final int priority;
  final int startTime;
  final int endTime;
  const TimeBoxingInfoData(
      {required this.date,
      required this.task,
      required this.priority,
      required this.startTime,
      required this.endTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<DateTime>(date);
    map['task'] = Variable<String>(task);
    map['priority'] = Variable<int>(priority);
    map['start_time'] = Variable<int>(startTime);
    map['end_time'] = Variable<int>(endTime);
    return map;
  }

  TimeBoxingInfoCompanion toCompanion(bool nullToAbsent) {
    return TimeBoxingInfoCompanion(
      date: Value(date),
      task: Value(task),
      priority: Value(priority),
      startTime: Value(startTime),
      endTime: Value(endTime),
    );
  }

  factory TimeBoxingInfoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimeBoxingInfoData(
      date: serializer.fromJson<DateTime>(json['date']),
      task: serializer.fromJson<String>(json['task']),
      priority: serializer.fromJson<int>(json['priority']),
      startTime: serializer.fromJson<int>(json['startTime']),
      endTime: serializer.fromJson<int>(json['endTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<DateTime>(date),
      'task': serializer.toJson<String>(task),
      'priority': serializer.toJson<int>(priority),
      'startTime': serializer.toJson<int>(startTime),
      'endTime': serializer.toJson<int>(endTime),
    };
  }

  TimeBoxingInfoData copyWith(
          {DateTime? date,
          String? task,
          int? priority,
          int? startTime,
          int? endTime}) =>
      TimeBoxingInfoData(
        date: date ?? this.date,
        task: task ?? this.task,
        priority: priority ?? this.priority,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
      );
  @override
  String toString() {
    return (StringBuffer('TimeBoxingInfoData(')
          ..write('date: $date, ')
          ..write('task: $task, ')
          ..write('priority: $priority, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(date, task, priority, startTime, endTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimeBoxingInfoData &&
          other.date == this.date &&
          other.task == this.task &&
          other.priority == this.priority &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime);
}

class TimeBoxingInfoCompanion extends UpdateCompanion<TimeBoxingInfoData> {
  final Value<DateTime> date;
  final Value<String> task;
  final Value<int> priority;
  final Value<int> startTime;
  final Value<int> endTime;
  final Value<int> rowid;
  const TimeBoxingInfoCompanion({
    this.date = const Value.absent(),
    this.task = const Value.absent(),
    this.priority = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TimeBoxingInfoCompanion.insert({
    required DateTime date,
    required String task,
    required int priority,
    required int startTime,
    required int endTime,
    this.rowid = const Value.absent(),
  })  : date = Value(date),
        task = Value(task),
        priority = Value(priority),
        startTime = Value(startTime),
        endTime = Value(endTime);
  static Insertable<TimeBoxingInfoData> custom({
    Expression<DateTime>? date,
    Expression<String>? task,
    Expression<int>? priority,
    Expression<int>? startTime,
    Expression<int>? endTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (task != null) 'task': task,
      if (priority != null) 'priority': priority,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TimeBoxingInfoCompanion copyWith(
      {Value<DateTime>? date,
      Value<String>? task,
      Value<int>? priority,
      Value<int>? startTime,
      Value<int>? endTime,
      Value<int>? rowid}) {
    return TimeBoxingInfoCompanion(
      date: date ?? this.date,
      task: task ?? this.task,
      priority: priority ?? this.priority,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (task.present) {
      map['task'] = Variable<String>(task.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<int>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<int>(endTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimeBoxingInfoCompanion(')
          ..write('date: $date, ')
          ..write('task: $task, ')
          ..write('priority: $priority, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ZandiInfoTable extends ZandiInfo
    with TableInfo<$ZandiInfoTable, ZandiInfoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ZandiInfoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _stackMeta = const VerificationMeta('stack');
  @override
  late final GeneratedColumn<int> stack = GeneratedColumn<int>(
      'stack', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [date, stack];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'zandi_info';
  @override
  VerificationContext validateIntegrity(Insertable<ZandiInfoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('stack')) {
      context.handle(
          _stackMeta, stack.isAcceptableOrUnknown(data['stack']!, _stackMeta));
    } else if (isInserting) {
      context.missing(_stackMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ZandiInfoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ZandiInfoData(
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      stack: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stack'])!,
    );
  }

  @override
  $ZandiInfoTable createAlias(String alias) {
    return $ZandiInfoTable(attachedDatabase, alias);
  }
}

class ZandiInfoData extends DataClass implements Insertable<ZandiInfoData> {
  final DateTime date;
  final int stack;
  const ZandiInfoData({required this.date, required this.stack});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<DateTime>(date);
    map['stack'] = Variable<int>(stack);
    return map;
  }

  ZandiInfoCompanion toCompanion(bool nullToAbsent) {
    return ZandiInfoCompanion(
      date: Value(date),
      stack: Value(stack),
    );
  }

  factory ZandiInfoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ZandiInfoData(
      date: serializer.fromJson<DateTime>(json['date']),
      stack: serializer.fromJson<int>(json['stack']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<DateTime>(date),
      'stack': serializer.toJson<int>(stack),
    };
  }

  ZandiInfoData copyWith({DateTime? date, int? stack}) => ZandiInfoData(
        date: date ?? this.date,
        stack: stack ?? this.stack,
      );
  @override
  String toString() {
    return (StringBuffer('ZandiInfoData(')
          ..write('date: $date, ')
          ..write('stack: $stack')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(date, stack);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ZandiInfoData &&
          other.date == this.date &&
          other.stack == this.stack);
}

class ZandiInfoCompanion extends UpdateCompanion<ZandiInfoData> {
  final Value<DateTime> date;
  final Value<int> stack;
  final Value<int> rowid;
  const ZandiInfoCompanion({
    this.date = const Value.absent(),
    this.stack = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ZandiInfoCompanion.insert({
    required DateTime date,
    required int stack,
    this.rowid = const Value.absent(),
  })  : date = Value(date),
        stack = Value(stack);
  static Insertable<ZandiInfoData> custom({
    Expression<DateTime>? date,
    Expression<int>? stack,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (stack != null) 'stack': stack,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ZandiInfoCompanion copyWith(
      {Value<DateTime>? date, Value<int>? stack, Value<int>? rowid}) {
    return ZandiInfoCompanion(
      date: date ?? this.date,
      stack: stack ?? this.stack,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (stack.present) {
      map['stack'] = Variable<int>(stack.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ZandiInfoCompanion(')
          ..write('date: $date, ')
          ..write('stack: $stack, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$Mydatabase extends GeneratedDatabase {
  _$Mydatabase(QueryExecutor e) : super(e);
  _$MydatabaseManager get managers => _$MydatabaseManager(this);
  late final $TimeBoxingInfoTable timeBoxingInfo = $TimeBoxingInfoTable(this);
  late final $ZandiInfoTable zandiInfo = $ZandiInfoTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [timeBoxingInfo, zandiInfo];
}

typedef $$TimeBoxingInfoTableInsertCompanionBuilder = TimeBoxingInfoCompanion
    Function({
  required DateTime date,
  required String task,
  required int priority,
  required int startTime,
  required int endTime,
  Value<int> rowid,
});
typedef $$TimeBoxingInfoTableUpdateCompanionBuilder = TimeBoxingInfoCompanion
    Function({
  Value<DateTime> date,
  Value<String> task,
  Value<int> priority,
  Value<int> startTime,
  Value<int> endTime,
  Value<int> rowid,
});

class $$TimeBoxingInfoTableTableManager extends RootTableManager<
    _$Mydatabase,
    $TimeBoxingInfoTable,
    TimeBoxingInfoData,
    $$TimeBoxingInfoTableFilterComposer,
    $$TimeBoxingInfoTableOrderingComposer,
    $$TimeBoxingInfoTableProcessedTableManager,
    $$TimeBoxingInfoTableInsertCompanionBuilder,
    $$TimeBoxingInfoTableUpdateCompanionBuilder> {
  $$TimeBoxingInfoTableTableManager(_$Mydatabase db, $TimeBoxingInfoTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TimeBoxingInfoTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TimeBoxingInfoTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$TimeBoxingInfoTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<DateTime> date = const Value.absent(),
            Value<String> task = const Value.absent(),
            Value<int> priority = const Value.absent(),
            Value<int> startTime = const Value.absent(),
            Value<int> endTime = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TimeBoxingInfoCompanion(
            date: date,
            task: task,
            priority: priority,
            startTime: startTime,
            endTime: endTime,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required DateTime date,
            required String task,
            required int priority,
            required int startTime,
            required int endTime,
            Value<int> rowid = const Value.absent(),
          }) =>
              TimeBoxingInfoCompanion.insert(
            date: date,
            task: task,
            priority: priority,
            startTime: startTime,
            endTime: endTime,
            rowid: rowid,
          ),
        ));
}

class $$TimeBoxingInfoTableProcessedTableManager extends ProcessedTableManager<
    _$Mydatabase,
    $TimeBoxingInfoTable,
    TimeBoxingInfoData,
    $$TimeBoxingInfoTableFilterComposer,
    $$TimeBoxingInfoTableOrderingComposer,
    $$TimeBoxingInfoTableProcessedTableManager,
    $$TimeBoxingInfoTableInsertCompanionBuilder,
    $$TimeBoxingInfoTableUpdateCompanionBuilder> {
  $$TimeBoxingInfoTableProcessedTableManager(super.$state);
}

class $$TimeBoxingInfoTableFilterComposer
    extends FilterComposer<_$Mydatabase, $TimeBoxingInfoTable> {
  $$TimeBoxingInfoTableFilterComposer(super.$state);
  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get task => $state.composableBuilder(
      column: $state.table.task,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get priority => $state.composableBuilder(
      column: $state.table.priority,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get startTime => $state.composableBuilder(
      column: $state.table.startTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get endTime => $state.composableBuilder(
      column: $state.table.endTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TimeBoxingInfoTableOrderingComposer
    extends OrderingComposer<_$Mydatabase, $TimeBoxingInfoTable> {
  $$TimeBoxingInfoTableOrderingComposer(super.$state);
  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get task => $state.composableBuilder(
      column: $state.table.task,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get priority => $state.composableBuilder(
      column: $state.table.priority,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get startTime => $state.composableBuilder(
      column: $state.table.startTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get endTime => $state.composableBuilder(
      column: $state.table.endTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ZandiInfoTableInsertCompanionBuilder = ZandiInfoCompanion Function({
  required DateTime date,
  required int stack,
  Value<int> rowid,
});
typedef $$ZandiInfoTableUpdateCompanionBuilder = ZandiInfoCompanion Function({
  Value<DateTime> date,
  Value<int> stack,
  Value<int> rowid,
});

class $$ZandiInfoTableTableManager extends RootTableManager<
    _$Mydatabase,
    $ZandiInfoTable,
    ZandiInfoData,
    $$ZandiInfoTableFilterComposer,
    $$ZandiInfoTableOrderingComposer,
    $$ZandiInfoTableProcessedTableManager,
    $$ZandiInfoTableInsertCompanionBuilder,
    $$ZandiInfoTableUpdateCompanionBuilder> {
  $$ZandiInfoTableTableManager(_$Mydatabase db, $ZandiInfoTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ZandiInfoTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ZandiInfoTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$ZandiInfoTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<DateTime> date = const Value.absent(),
            Value<int> stack = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ZandiInfoCompanion(
            date: date,
            stack: stack,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required DateTime date,
            required int stack,
            Value<int> rowid = const Value.absent(),
          }) =>
              ZandiInfoCompanion.insert(
            date: date,
            stack: stack,
            rowid: rowid,
          ),
        ));
}

class $$ZandiInfoTableProcessedTableManager extends ProcessedTableManager<
    _$Mydatabase,
    $ZandiInfoTable,
    ZandiInfoData,
    $$ZandiInfoTableFilterComposer,
    $$ZandiInfoTableOrderingComposer,
    $$ZandiInfoTableProcessedTableManager,
    $$ZandiInfoTableInsertCompanionBuilder,
    $$ZandiInfoTableUpdateCompanionBuilder> {
  $$ZandiInfoTableProcessedTableManager(super.$state);
}

class $$ZandiInfoTableFilterComposer
    extends FilterComposer<_$Mydatabase, $ZandiInfoTable> {
  $$ZandiInfoTableFilterComposer(super.$state);
  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get stack => $state.composableBuilder(
      column: $state.table.stack,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ZandiInfoTableOrderingComposer
    extends OrderingComposer<_$Mydatabase, $ZandiInfoTable> {
  $$ZandiInfoTableOrderingComposer(super.$state);
  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get stack => $state.composableBuilder(
      column: $state.table.stack,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$MydatabaseManager {
  final _$Mydatabase _db;
  _$MydatabaseManager(this._db);
  $$TimeBoxingInfoTableTableManager get timeBoxingInfo =>
      $$TimeBoxingInfoTableTableManager(_db, _db.timeBoxingInfo);
  $$ZandiInfoTableTableManager get zandiInfo =>
      $$ZandiInfoTableTableManager(_db, _db.zandiInfo);
}
