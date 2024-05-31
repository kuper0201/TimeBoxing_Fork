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

  // select ZandiInfo
  Future<List<ZandiInfoData>> selectZandi(DateTime date) {
    final result = (_myDatabase.select(_myDatabase.zandiInfo)..where((t) => t.date.equals(date))).get();
    return result;
  }

}