import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:time_boxing/DB/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:time_boxing/DB/repositoryForTimeBoxing.dart';
import 'package:time_boxing/DB/repositoryForZandi.dart';

part 'database.g.dart';

@DriftDatabase(tables: [TimeBoxingInfo,ZandiInfo])
class Mydatabase extends _$Mydatabase {
   Mydatabase._internal() : super(_openDb());

  static final Mydatabase instance = Mydatabase._internal();
  @override
  int get schemaVersion => 1;

  TimeBoxingRepository get timeBoxingRepository => TimeBoxingRepository(this);
  RepositoryForZandi get zandiRepository => RepositoryForZandi(this);
}

LazyDatabase _openDb() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}