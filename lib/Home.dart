import 'package:flutter/material.dart';
import 'package:time_boxing/DB/database.dart';
import 'package:time_boxing/DB/models.dart';
import 'package:time_boxing/DB/repositoryForTimeBoxing.dart';
import 'package:time_boxing/home_steps/StepViewPage.dart';

import 'home_steps/PlanView.dart';

class HomeView extends StatefulWidget {
  List<TimeBoxingInfoData> dat = [];

  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TimeBoxingInfoData? current;

  Future<List<TimeBoxingInfoData>> getFromDB() async {
    TimeBoxingRepository tr = TimeBoxingRepository();

    DateTime now = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    int nowInt = DateTime.now().hour * 60 + DateTime.now().minute;
    return tr.selectTimeBoxing(now);
  }

  @override
  void initState() {
    getFromDB();
    super.initState();
  }

  Widget buildPlanTile(String task, int startTime, int endTime) {
    return ListTile(
      title: Text(task, style: const TextStyle(fontSize: 20)),
      subtitle: Row(
        children: [
          Text("${startTime ~/ 60}:${startTime % 60}", style: const TextStyle(fontSize: 18)),
          const Text("     "),
          Text("${endTime ~/ 60}:${endTime % 60}", style: const TextStyle(fontSize: 18))
        ],
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
    // Todo - DB 쿼리 이용해 현재 시간 일정 존재 확인

    return FutureBuilder(
      future: getFromDB(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return const CircularProgressIndicator();
        } else {
          return Column(
            children: [
              Card(child: buildPlanTile(current!.task, current!.startTime, current!.endTime)),
              const SizedBox(
                width: double.infinity,
                child: Padding(padding: EdgeInsets.only(left: 15, top: 20), child: Text("다음 일정", style: TextStyle(fontSize: 25), textAlign: TextAlign.left)),
              ),
              Card(child: buildPlanTile("일정 이름", 100, 200)),
              Card(child: buildPlanTile("일정 이름", 100, 200)),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Card(
                  child: SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: InkWell(
                      onTap: () {
                        // DB Query 후 PlanView에 넘겨 줄 것
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const PlanView()));
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
        }
      },
    );

    // 일정 없음
    // return InkWell(
    //   onTap: () {
    //     Navigator.push(context, MaterialPageRoute(builder: (context) => const StepViewPage()));
    //   },
    //   child: Ink(
    //     width: 300,
    //     height: 200,
    //     decoration: BoxDecoration(
    //       color: Colors.lightGreen,
    //       borderRadius: BorderRadius.circular(15)
    //     ),
    //     child: const Padding(
    //       padding: EdgeInsets.all(40),
    //       child: Center(
    //         child: Column(
    //           children: [
    //             Expanded(child: Text("일정 추가", style: TextStyle(fontSize: 32))),
    //             Expanded(child: Icon(Icons.add, size: 60,))
    //           ]
    //         ),
    //       ),
    //     )
    //   )
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: getMainWidget(context)),
    );
  }
}