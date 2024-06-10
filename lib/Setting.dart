import 'package:flutter/material.dart';
import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:time_boxing/DB/database.dart';

Mydatabase db = Mydatabase.instance;



class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DriftDbViewer(db)));
    return Scaffold(  
      body: Center(
        child: Container(child: Text("Setting"),),
      )
    );
  }
}