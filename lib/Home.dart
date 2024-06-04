import 'package:flutter/material.dart';
import 'package:time_boxing/DB/database.dart';
import 'package:time_boxing/DB/models.dart';
import 'package:time_boxing/DB/repositoryForTimeBoxing.dart';
import 'package:time_boxing/home_steps/StepViewPage.dart';
import 'package:time_boxing/home_steps/data/PlanTime.dart';

import 'home_steps/PlanView.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TimeBoxingInfoData? current;

  Future<List<TimeBoxingInfoData>> selectNextTimeBox() async {
    TimeBoxingRepository tr = TimeBoxingRepository();

    return tr.selectNextTime(DateTime.now());
  }

  Future<List<TimeBoxingInfoData>> selectCurrentTimeBox() async {
    TimeBoxingRepository tr = TimeBoxingRepository();

    return tr.selectCurrentTime(DateTime.now());
  }

  Future<List<TimeBoxingInfoData>> selectAllTimeBox() async {
    TimeBoxingRepository tr = TimeBoxingRepository();
    
    DateTime now = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    return tr.selectTimeBoxing(now);
  }

  @override
  void initState() {
    selectCurrentTimeBox();
    selectNextTimeBox();
    super.initState();
  }

  Widget buildPlanTile(TimeBoxingInfoData? data) {
    if(data == null) {
      return const Card(
        child: ListTile(
          title: Text("일정이 없습니다.")
        )
      );
    }

    return Card(
      child: ListTile(
        title: Text(data.task, style: const TextStyle(fontSize: 20)),
        subtitle: Row(
          children: [
            Text("${data.startTime ~/ 60}:${data.startTime % 60}", style: const TextStyle(fontSize: 18)),
            const Text("     "),
            Text("${data.endTime ~/ 60}:${data.endTime % 60}", style: const TextStyle(fontSize: 18))
          ],
        )
      )
    );
  }

  Widget buildSizedBox(String display) {
    return SizedBox(
      width: double.infinity,
      child: Padding(padding: const EdgeInsets.only(left: 15, top: 20), child: Text(display, style: const TextStyle(fontSize: 25), textAlign: TextAlign.left)),
    );
  }

  Widget getMainWidget(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        selectCurrentTimeBox(),
        selectNextTimeBox()
      ]),
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return const CircularProgressIndicator();
        } else if(snapshot.hasError) {
          return const Text("Error");
        } else {
          if(snapshot.data![0].isNotEmpty || snapshot.data![1].isNotEmpty) {
            current = (snapshot.data!.first.isEmpty) ? null : snapshot.data!.first[0];

            return Column(
              children: [
                buildSizedBox("현재 일정"),
                buildPlanTile(current),

                buildSizedBox("다음 일정"),
                if(snapshot.data![1].isNotEmpty)
                  for(final it in snapshot.data![1])
                    buildPlanTile(it),
                    
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

                          final selAll = await selectAllTimeBox();
                          for(final it in selAll) {
                            nameList.add(it.task);
                            priority.add(it.task);

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
            );
          } else {
            return InkWell(
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
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SingleChildScrollView(child: getMainWidget(context))),
    );
  }
}