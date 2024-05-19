import 'package:time_boxing/DB/database.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();

  await database.into(database.timeBoxingInfo).insert(TimeBoxingInfoCompanion.insert(
    date: DateTime.now(),
    task: '첫번째 할일',
    priority: 30201,
    startTime: 09,
    endTime: 22
  ));

  await database.into(database.zandiInfo).insert(ZandiInfoCompanion.insert(
    date: DateTime.now(),
    stack: 1
    ));
  
  List<TimeBoxingInfo> TimeBoxingItem = await database.select(database.timeBoxingInfo).get();
  List<ZandiInfo> ZandiInfoItem = await database.select(database.zandiInfo).get();

  print('items in database: $TimeBoxingItem');
  print('itme int ZandiInfo: $ZandiInfoItem');
}