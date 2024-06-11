import 'package:flutter/material.dart';
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
    return Scaffold(  
      body: Center(
        child: Container(child: Text("Setting"),),
      )
    );
  }
}