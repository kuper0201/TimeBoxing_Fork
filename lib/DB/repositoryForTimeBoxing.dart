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

}