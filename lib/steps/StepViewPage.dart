import 'package:flutter/material.dart';
import 'package:time_boxing/steps/FlushView.dart';
import 'package:time_boxing/steps/PlanView.dart';
import 'package:time_boxing/steps/PriorityView.dart';

class StepViewPage extends StatefulWidget {
  const StepViewPage({Key? key}) : super(key: key);

  @override
  _StepViewPageState createState() => _StepViewPageState();
}

class _StepViewPageState extends State<StepViewPage> {
  List<String> nameList = [];
  TextEditingController tc = TextEditingController();
  PageController pc = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pc,
      children: [
        FlushView(nameList: nameList, pc: pc),
        PriorityView(nameList: nameList, pc: pc),
        PlanView(nameList: nameList, pc: pc)
      ],
    );
  }
}