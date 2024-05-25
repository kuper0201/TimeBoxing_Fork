import 'package:drift/drift.dart';
import 'package:time_boxing/DB/database.dart';
import 'package:flutter/material.dart';
import 'package:time_boxing/DB/models.dart';

class TimeBoxingRepository extends ChangeNotifier {
  //field

  final Mydatabase _myDatabase;

  //Singleton
  static final TimeBoxingRepository _timeBoxingRepository = TimeBoxingRepository._inner();

  TimeBoxingRepository._inner() : _myDatabase = Mydatabase();

  factory TimeBoxingRepository() {
    return _timeBoxingRepository;
  }

  // insert
  Future<int> insertTimeBoxing(DateTime date, String task, int priority, int startTime, int endTime) {
    return _myDatabase.into(_myDatabase.timeBoxingInfo).insert(
        TimeBoxingInfoCompanion.insert(date: date, task: task, priority: priority, startTime: startTime, endTime: endTime));
  }

  Future<int> insertZandiInfo(DateTime date, int stack) {
    return _myDatabase.into(_myDatabase.zandiInfo).insert(ZandiInfoCompanion.insert(date: date, stack: stack));
  }
  
  //읽기
  Future<List<TimeBoxingInfoData>> selectTimeBoxing(DateTime date) {
    final result = (_myDatabase.select(_myDatabase.timeBoxingInfo)..where((t) =>
    t.date.year.equals(date.year) &
    t.date.month.equals(date.month) &
    t.date.day.equals(date.day)
    )).get();
    return result;
  }

  Future<List<ZandiInfoData>> selectZandi(DateTime date) {
    final result = (_myDatabase.select(_myDatabase.zandiInfo)..where((t) =>
    t.date.year.equals(date.year) &
    t.date.month.equals(date.month) &
    t.date.day.equals(date.day)
    )).get();
    return result;
  }

}