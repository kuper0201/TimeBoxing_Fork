import 'dart:async';

import 'package:flutter/material.dart';
import 'package:time_boxing/DB/database.dart';
import 'package:time_boxing/home_steps/StepViewPage.dart';
import 'package:time_boxing/home_steps/data/PlanTime.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Mydatabase db = Mydatabase.instance;
  TimeBoxingInfoData? current;

  Future<List<TimeBoxingInfoData>> selectNextTimeBox() async {
    return db.timeBoxingRepository.selectNextTime(DateTime.now());
  }

  Future<List<TimeBoxingInfoData>> selectCurrentTimeBox() async {
    return db.timeBoxingRepository.selectCurrentTime(DateTime.now());
  }

  Future<List<TimeBoxingInfoData>> selectAllTimeBox() async {
    DateTime now = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    return db.timeBoxingRepository.selectTimeBoxing(now);
  }

  // 실시간 처리
  // Timer? tp;
  // @override
  // void initState() {
  //   tp = Timer.periodic(const Duration(seconds: 10), (timer) {
  //     setState(() {});
  //   });
  //   super.initState();
  // }

  // 실시간 처리
  // @override
  // void dispose() {
  //   tp!.cancel();
  //   super.dispose();
  // }

  String leadingZero(int num) {
    return num.toString().padLeft(2, '0');
  }

  List<Widget> buildPlanTile(List<TimeBoxingInfoData> data) {
    List<Widget> lst = [];
    if(data.isEmpty) {
      lst.add(
        const Card(
          child: ListTile(
            title: Text("일정이 없습니다.")
          )
        )
      );

      return lst;
    }
    
    for(final it in data) {
      lst.add(
        Card(
          child: ListTile(
            title: Text(it.task, style: const TextStyle(fontSize: 20)),
            subtitle: Row(
              children: [
                Text("${leadingZero(it.startTime ~/ 60)}:${leadingZero(it.startTime % 60)}", style: const TextStyle(fontSize: 18)),
                const Text("     "),
                Text("${leadingZero(it.endTime ~/ 60)}:${leadingZero(it.endTime % 60)}", style: const TextStyle(fontSize: 18))
              ],
            )
          )
        )
      );
    }

    return lst;
  }

  Widget buildSizedBox(String display) {
    return SizedBox(
      width: double.infinity,
      child: Padding(padding: const EdgeInsets.only(left: 15, top: 20), child: Text(display, style: const TextStyle(fontSize: 25), textAlign: TextAlign.left)),
    );
  }

  // 일정 존재 할 때
  Widget planExist(AsyncSnapshot<List<List<TimeBoxingInfoData>>> snapshot) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildSizedBox("현재 일정"),
          for(final widget in buildPlanTile(snapshot.data![0]))
            widget,

          buildSizedBox("다음 일정"),
          for(final widget in buildPlanTile(snapshot.data![1]))
            widget,

          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Card(
              child: SizedBox(
                height: 60,
                width: double.infinity,
                child: InkWell(
                  onTap: () async {
                    List<String> nameList = [];
                    List<String> priority = [];
                    Map<String, DateTime> startTime = {};
                    Map<String, DateTime> endTime = {};
                    List<PlanTime> planList = [];

                    final selAll = snapshot.data![2];
                    for(final it in selAll) {
                      nameList.add(it.task);
                      
                      if(it.priority != -1) {
                        priority.add(it.task);
                      }

                      DateTime dt = DateTime.now();
                      startTime[it.task] = DateTime(dt.year, dt.month, dt.day, it.startTime ~/ 60, it.startTime % 60);
                      endTime[it.task] = DateTime(dt.year, dt.month, dt.day, it.endTime ~/ 60, it.endTime % 60);

                      planList.add(PlanTime(title: it.task, description: "", start: startTime[it.task]!, end: endTime[it.task]!));
                    }

                    if(context.mounted) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StepViewPage.edit(nameList, priority, startTime, endTime, planList))).then((v) {
                        setState(() {});
                      });
                    }
                  },
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.edit),
                        Text(
                          "수정",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }

  // 일정 존재하지 않을 때
  Widget planNotExist(AsyncSnapshot<List<List<TimeBoxingInfoData>>> snapshot) {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => StepViewPage())).then((v) {
            setState(() {});
          });
        },
        child: Ink(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.lightGreen,
            borderRadius: BorderRadius.circular(15)
          ),
          child: const Padding(
            padding: EdgeInsets.all(40),
            child: Center(
              child: Column(
                children: [
                  Expanded(child: Text("일정 추가", style: TextStyle(fontSize: 32))),
                  Expanded(child: Icon(Icons.add, size: 60,))
                ]
              ),
            ),
          )
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([selectCurrentTimeBox(), selectNextTimeBox(), selectAllTimeBox()]),
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else if(snapshot.hasError) {
          return const Center(child: Text("Error"));
        } else {
          if(snapshot.data![2].isNotEmpty) return planExist(snapshot);
          return planNotExist(snapshot);
        }
      },
    );
  }
}