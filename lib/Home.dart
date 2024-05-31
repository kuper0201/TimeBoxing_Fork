import 'package:flutter/material.dart';
import 'package:time_boxing/home_steps/StepViewPage.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isValid = false;

  Widget getMainWidget(BuildContext context) {
    // Todo - DB 쿼리 이용해 현재 시간 일정 존재 확인
    
    if(isValid) { // 일정 존재
      return Column(
        children: [
          const SizedBox(
            width: double.infinity,
            child: Padding(padding: EdgeInsets.only(left: 15, top: 20), child: Text("현재 일정", style: TextStyle(fontSize: 25), textAlign: TextAlign.left)),
          ),
          const Card(
            child: ListTile(
              title: Text("일정 이름(현재)", style: TextStyle(fontSize: 20)),
              subtitle: Row(
                children: [
                  Text("12:00", style: TextStyle(fontSize: 18)),
                  Text("     "),
                  Text("15:00", style: TextStyle(fontSize: 18))
                ],
              )
            )
          ),
          const SizedBox(
            width: double.infinity,
            child: Padding(padding: EdgeInsets.only(left: 15, top: 20), child: Text("다음 일정", style: TextStyle(fontSize: 25), textAlign: TextAlign.left)),
          ),
          const Card(
            child: ListTile(
              title: Text("일정 이름(다음)", style: TextStyle(fontSize: 20)),
              subtitle: Row(
                children: [
                  Text("15:00", style: TextStyle(fontSize: 18)),
                  Text("     "),
                  Text("18:00", style: TextStyle(fontSize: 18))
                ],
              )
            )
          ),
          const Card(
            child: ListTile(
              title: Text("일정 이름(그 다음)", style: TextStyle(fontSize: 20)),
              subtitle: Row(
                children: [
                  Text("18:00", style: TextStyle(fontSize: 18)),
                  Text("     "),
                  Text("21:00", style: TextStyle(fontSize: 18))
                ],
              )
            )
          ),
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

    // 일정 없음
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const StepViewPage()));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: (!isValid) ? null : AppBar(
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.edit),
      //       onPressed: () {
              
      //       },
      //     ),
      //   ]
      // ),
      body: Center(
        child: getMainWidget(context)
      ),
    );
  }
}