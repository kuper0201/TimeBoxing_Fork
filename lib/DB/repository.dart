import 'package:drift/drift.dart';
import 'package:time_boxing/DB/database.dart';
import 'package:flutter/material.dart';

class TimeBoxingRepository extends ChangeNotifier {
  //field

  final Mydatabase _myDatabase;

  //Singleton
  static final TimeBoxingRepository _timeBoxingRepository = TimeBoxingRepository._inner();

  TimeBoxingRepository._inner() : _myDatabase = Mydatabase();

  factory TimeBoxingRepository() {
    return _timeBoxingRepository;
  }


  // TimeBoxingInfo insert
  Future<int> insertTimeBoxing(DateTime date, String task, int priority, int startTime, int endTime) {
    return _myDatabase.into(_myDatabase.timeBoxingInfo).insert(
        TimeBoxingInfoCompanion.insert(date: date, task: task, priority: priority, startTime: startTime, endTime: endTime));
  }
  
  // select TimeBoxingInfo
  Future<List<TimeBoxingInfoData>> selectTimeBoxing(DateTime date) {
    final result = (_myDatabase.select(_myDatabase.timeBoxingInfo)..where((t) => t.date.equals(date))).get();
    return result;
  }

  // insert ZandiInfo FirstTime
  Future<int> insertZandiInfo_FirstTime(DateTime date) {
    return _myDatabase.into(_myDatabase.zandiInfo).insert(ZandiInfoCompanion.insert(date: date, stack: 0));
  }

  // insert ZandiInfo increaseStack
  Future<int> insertZandiInfo_increaseStack(DateTime date, int stack) {
    return _myDatabase.into(_myDatabase.zandiInfo).insert(ZandiInfoCompanion.insert(date: date, stack: stack));
  }

  // update ZandiInfo
  Future<int> updateZandiInfo(DateTime date, int stack) {
    return (
      _myDatabase.update(_myDatabase.zandiInfo)..where((t) => t.date.equals(date))).write(ZandiInfoCompanion(stack: Value(stack))
      );
  }

  // select ZandiInfo get all
  Future<List<ZandiInfoData>> selectZandiAll() {
    final result = (_myDatabase.select(_myDatabase.zandiInfo)).get();
    return result;
  }

  //select ZandiInfo 35days ago
  //date값 넘겨줄때 flutter:math 사용하여 35일전 날짜로 변경하여 줄것
  Future<List<ZandiInfoData>> selectZandi35DaysAgo(DateTime date) {
    final result = (_myDatabase.select(_myDatabase.zandiInfo)..where((t) => t.date.isBiggerOrEqualValue(date))).get();
    return result;
  }

  //select ZandiInfo max stack
  Future<List<ZandiInfoData>> selectZandi35MaxStack() {
    final result = (_myDatabase.select(_myDatabase.zandiInfo)..orderBy([(t) => OrderingTerm.desc(t.stack)])..limit(1)).get();
    return result;
  }

}