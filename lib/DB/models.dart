import 'package:drift/drift.dart';

class TimeBoxingInfo extends Table {
  DateTimeColumn get date => dateTime()();
  TextColumn get task => text()();
  IntColumn get priority => integer()();
  IntColumn get startTime => integer()();
  IntColumn get endTime => integer()();
}

class ZandiInfo extends Table {
  DateTimeColumn get date => dateTime()();
  IntColumn get stack => integer()();
}