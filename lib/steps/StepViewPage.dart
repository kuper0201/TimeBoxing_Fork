import 'package:flutter/material.dart';
import 'package:time_boxing/steps/FlushView.dart';
import 'package:time_boxing/steps/PlanView.dart';
import 'package:time_boxing/steps/PriorityView.dart';

class StepViewPage extends StatefulWidget {
  const StepViewPage({super.key});

  @override
  _StepViewPageState createState() => _StepViewPageState();
}

class _StepViewPageState extends State<StepViewPage> {
  List<String> nameList = [];
  List<String> priority = [];
  Map<String, DateTime> startTime = {};
  Map<String, DateTime> endTime = {};
  TextEditingController tc = TextEditingController();
  PageController pc = PageController(initialPage: 0);

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
        FlushView(nameList: nameList, priority: priority, pc: pc),
        PriorityView(nameList: nameList, priority: priority, pc: pc),
        PlanView(nameList: nameList, priority: priority, startTime: startTime, endTime: endTime, pc: pc)
      ],
    );
  }
}