// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TimeBoxingInfoTable extends TimeBoxingInfo
    with TableInfo<$TimeBoxingInfoTable, TimeBoxingInfoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimeBoxingInfoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
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
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, task, priority, startTime, endTime, date];
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
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimeBoxingInfoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimeBoxingInfoData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      task: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task'])!,
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_time'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
    );
  }

  @override
  $TimeBoxingInfoTable createAlias(String alias) {
    return $TimeBoxingInfoTable(attachedDatabase, alias);
  }
}

class TimeBoxingInfoData extends DataClass
    implements Insertable<TimeBoxingInfoData> {
  final int id;
  final String task;
  final int priority;
  final int startTime;
  final int endTime;
  final DateTime date;
  const TimeBoxingInfoData(
      {required this.id,
      required this.task,
      required this.priority,
      required this.startTime,
      required this.endTime,
      required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['task'] = Variable<String>(task);
    map['priority'] = Variable<int>(priority);
    map['start_time'] = Variable<int>(startTime);
    map['end_time'] = Variable<int>(endTime);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  TimeBoxingInfoCompanion toCompanion(bool nullToAbsent) {
    return TimeBoxingInfoCompanion(
      id: Value(id),
      task: Value(task),
      priority: Value(priority),
      startTime: Value(startTime),
      endTime: Value(endTime),
      date: Value(date),
    );
  }

  factory TimeBoxingInfoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimeBoxingInfoData(
      id: serializer.fromJson<int>(json['id']),
      task: serializer.fromJson<String>(json['task']),
      priority: serializer.fromJson<int>(json['priority']),
      startTime: serializer.fromJson<int>(json['startTime']),
      endTime: serializer.fromJson<int>(json['endTime']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'task': serializer.toJson<String>(task),
      'priority': serializer.toJson<int>(priority),
      'startTime': serializer.toJson<int>(startTime),
      'endTime': serializer.toJson<int>(endTime),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  TimeBoxingInfoData copyWith(
          {int? id,
          String? task,
          int? priority,
          int? startTime,
          int? endTime,
          DateTime? date}) =>
      TimeBoxingInfoData(
        id: id ?? this.id,
        task: task ?? this.task,
        priority: priority ?? this.priority,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('TimeBoxingInfoData(')
          ..write('id: $id, ')
          ..write('task: $task, ')
          ..write('priority: $priority, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, task, priority, startTime, endTime, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimeBoxingInfoData &&
          other.id == this.id &&
          other.task == this.task &&
          other.priority == this.priority &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.date == this.date);
}

class TimeBoxingInfoCompanion extends UpdateCompanion<TimeBoxingInfoData> {
  final Value<int> id;
  final Value<String> task;
  final Value<int> priority;
  final Value<int> startTime;
  final Value<int> endTime;
  final Value<DateTime> date;
  const TimeBoxingInfoCompanion({
    this.id = const Value.absent(),
    this.task = const Value.absent(),
    this.priority = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.date = const Value.absent(),
  });
  TimeBoxingInfoCompanion.insert({
    this.id = const Value.absent(),
    required String task,
    required int priority,
    required int startTime,
    required int endTime,
    required DateTime date,
  })  : task = Value(task),
        priority = Value(priority),
        startTime = Value(startTime),
        endTime = Value(endTime),
        date = Value(date);
  static Insertable<TimeBoxingInfoData> custom({
    Expression<int>? id,
    Expression<String>? task,
    Expression<int>? priority,
    Expression<int>? startTime,
    Expression<int>? endTime,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (task != null) 'task': task,
      if (priority != null) 'priority': priority,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (date != null) 'date': date,
    });
  }

  TimeBoxingInfoCompanion copyWith(
      {Value<int>? id,
      Value<String>? task,
      Value<int>? priority,
      Value<int>? startTime,
      Value<int>? endTime,
      Value<DateTime>? date}) {
    return TimeBoxingInfoCompanion(
      id: id ?? this.id,
      task: task ?? this.task,
      priority: priority ?? this.priority,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
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
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimeBoxingInfoCompanion(')
          ..write('id: $id, ')
          ..write('task: $task, ')
          ..write('priority: $priority, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('date: $date')
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
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
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
  List<GeneratedColumn> get $columns => [id, date, stack];
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
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ZandiInfoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ZandiInfoData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
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
  final int id;
  final DateTime date;
  final int stack;
  const ZandiInfoData(
      {required this.id, required this.date, required this.stack});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['stack'] = Variable<int>(stack);
    return map;
  }

  ZandiInfoCompanion toCompanion(bool nullToAbsent) {
    return ZandiInfoCompanion(
      id: Value(id),
      date: Value(date),
      stack: Value(stack),
    );
  }

  factory ZandiInfoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ZandiInfoData(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      stack: serializer.fromJson<int>(json['stack']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'stack': serializer.toJson<int>(stack),
    };
  }

  ZandiInfoData copyWith({int? id, DateTime? date, int? stack}) =>
      ZandiInfoData(
        id: id ?? this.id,
        date: date ?? this.date,
        stack: stack ?? this.stack,
      );
  @override
  String toString() {
    return (StringBuffer('ZandiInfoData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('stack: $stack')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, stack);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ZandiInfoData &&
          other.id == this.id &&
          other.date == this.date &&
          other.stack == this.stack);
}

class ZandiInfoCompanion extends UpdateCompanion<ZandiInfoData> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> stack;
  const ZandiInfoCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.stack = const Value.absent(),
  });
  ZandiInfoCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required int stack,
  })  : date = Value(date),
        stack = Value(stack);
  static Insertable<ZandiInfoData> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? stack,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (stack != null) 'stack': stack,
    });
  }

  ZandiInfoCompanion copyWith(
      {Value<int>? id, Value<DateTime>? date, Value<int>? stack}) {
    return ZandiInfoCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      stack: stack ?? this.stack,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (stack.present) {
      map['stack'] = Variable<int>(stack.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ZandiInfoCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('stack: $stack')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
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
  Value<int> id,
  required String task,
  required int priority,
  required int startTime,
  required int endTime,
  required DateTime date,
});
typedef $$TimeBoxingInfoTableUpdateCompanionBuilder = TimeBoxingInfoCompanion
    Function({
  Value<int> id,
  Value<String> task,
  Value<int> priority,
  Value<int> startTime,
  Value<int> endTime,
  Value<DateTime> date,
});

class $$TimeBoxingInfoTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TimeBoxingInfoTable,
    TimeBoxingInfoData,
    $$TimeBoxingInfoTableFilterComposer,
    $$TimeBoxingInfoTableOrderingComposer,
    $$TimeBoxingInfoTableProcessedTableManager,
    $$TimeBoxingInfoTableInsertCompanionBuilder,
    $$TimeBoxingInfoTableUpdateCompanionBuilder> {
  $$TimeBoxingInfoTableTableManager(
      _$AppDatabase db, $TimeBoxingInfoTable table)
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
            Value<int> id = const Value.absent(),
            Value<String> task = const Value.absent(),
            Value<int> priority = const Value.absent(),
            Value<int> startTime = const Value.absent(),
            Value<int> endTime = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
          }) =>
              TimeBoxingInfoCompanion(
            id: id,
            task: task,
            priority: priority,
            startTime: startTime,
            endTime: endTime,
            date: date,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String task,
            required int priority,
            required int startTime,
            required int endTime,
            required DateTime date,
          }) =>
              TimeBoxingInfoCompanion.insert(
            id: id,
            task: task,
            priority: priority,
            startTime: startTime,
            endTime: endTime,
            date: date,
          ),
        ));
}

class $$TimeBoxingInfoTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
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
    extends FilterComposer<_$AppDatabase, $TimeBoxingInfoTable> {
  $$TimeBoxingInfoTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
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

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TimeBoxingInfoTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TimeBoxingInfoTable> {
  $$TimeBoxingInfoTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
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

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ZandiInfoTableInsertCompanionBuilder = ZandiInfoCompanion Function({
  Value<int> id,
  required DateTime date,
  required int stack,
});
typedef $$ZandiInfoTableUpdateCompanionBuilder = ZandiInfoCompanion Function({
  Value<int> id,
  Value<DateTime> date,
  Value<int> stack,
});

class $$ZandiInfoTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ZandiInfoTable,
    ZandiInfoData,
    $$ZandiInfoTableFilterComposer,
    $$ZandiInfoTableOrderingComposer,
    $$ZandiInfoTableProcessedTableManager,
    $$ZandiInfoTableInsertCompanionBuilder,
    $$ZandiInfoTableUpdateCompanionBuilder> {
  $$ZandiInfoTableTableManager(_$AppDatabase db, $ZandiInfoTable table)
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
            Value<int> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> stack = const Value.absent(),
          }) =>
              ZandiInfoCompanion(
            id: id,
            date: date,
            stack: stack,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required DateTime date,
            required int stack,
          }) =>
              ZandiInfoCompanion.insert(
            id: id,
            date: date,
            stack: stack,
          ),
        ));
}

class $$ZandiInfoTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
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
    extends FilterComposer<_$AppDatabase, $ZandiInfoTable> {
  $$ZandiInfoTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

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
    extends OrderingComposer<_$AppDatabase, $ZandiInfoTable> {
  $$ZandiInfoTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get stack => $state.composableBuilder(
      column: $state.table.stack,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$TimeBoxingInfoTableTableManager get timeBoxingInfo =>
      $$TimeBoxingInfoTableTableManager(_db, _db.timeBoxingInfo);
  $$ZandiInfoTableTableManager get zandiInfo =>
      $$ZandiInfoTableTableManager(_db, _db.zandiInfo);
}
