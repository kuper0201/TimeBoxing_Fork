import 'package:flutter/material.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:time_boxing/calendar_steps/FlushView.dart';
import 'package:time_boxing/calendar_steps/PlanningView.dart';
import 'package:time_boxing/calendar_steps/PriView.dart';
import 'package:time_boxing/home_steps/data/PlanTime.dart';

class StepViewPage extends StatefulWidget {
  List<String> nameList = [];
  List<String> priority = [];
  Map<String, DateTime> startTime = {};
  Map<String, DateTime> endTime = {};
  List<PlanTime> planList = [];
  DateTime selectedDay;

  StepViewPage(this.nameList, this.priority, this.startTime, this.endTime, this.planList, this.selectedDay, {super.key});

  @override
  State<StepViewPage> createState() => _StepViewPageState();
}

class _StepViewPageState extends State<StepViewPage> {
  List<String> nameList = [];
  List<String> priority = [];
  Map<String, DateTime> startTime = {};
  Map<String, DateTime> endTime = {};
  List<PlanTime> planList = [];
  late DateTime selectedDay;
  
  PageController pc = PageController(initialPage: 0);

 @override
  void initState() {
    nameList = widget.nameList;
    priority = widget.priority;
    startTime = widget.startTime;
    endTime = widget.endTime;
    planList = widget.planList;
    selectedDay = widget.selectedDay;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pc,
      onPageChanged: (value) async {
        if(value == 1 && nameList.length < 3) {
          await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Alert'),
                content: const Text('3개 이상의 Flush를 추가하세요.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('확인'),
                  ),
                ],
              );
            }
          );

          pc.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
        } else if(value == 2 && priority.length < 3) {
          await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Alert'),
                content: const Text('3개의 우선 순위를 설정하세요.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('확인'),
                  ),
                ],
              );
            }
          );

          pc.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
        }
      },
      children: [
        FlushView(nameList: nameList, priority: priority, planList: planList, pc: pc),
        PriorityView(nameList: nameList, priority: priority, pc: pc),
        PlanView(nameList: nameList, priority: priority, startTime: startTime, endTime: endTime, planList: planList, pc: pc , selectedDay:selectedDay)
      ],
    );
  }
}