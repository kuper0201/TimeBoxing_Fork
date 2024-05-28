import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:time_boxing/home_steps/StepViewPage.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
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
            child: Padding(padding: EdgeInsets.only(left: 15), child: Text("현재 일정", style: TextStyle(fontSize: 25), textAlign: TextAlign.left)),
          ),
          Card(
            child: ListTile(
              onTap: () {
                
              },
              title: const Text("1234"),
              subtitle: const Row(
                children: [
                  Text("12:00"),
                  Text("     "),
                  Text("14:00")
                ],
              )
            )
          ),
          const SizedBox(
            width: double.infinity,
            child: Padding(padding: EdgeInsets.only(left: 15, top: 20), child: Text("다음 일정", style: TextStyle(fontSize: 25), textAlign: TextAlign.left)),
          ),
          Card(
            child: ListTile(
              onTap: () {
                
              },
              title: const Text("5678"),
              subtitle: const Row(
                children: [
                  Text("15:00"),
                  Text("     "),
                  Text("18:00")
                ],
              )
            )
          ),
          Card(
            child: ListTile(
              onTap: () {
                
              },
              title: const Text("5678"),
              subtitle: const Row(
                children: [
                  Text("15:00"),
                  Text("     "),
                  Text("18:00")
                ],
              )
            )
          ),
          Card(
            child: ListTile(
              onTap: () {
                
              },
              title: const Text("5678"),
              subtitle: const Row(
                children: [
                  Text("15:00"),
                  Text("     "),
                  Text("18:00")
                ],
              )
            )
          )
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
      appBar: (!isValid) ? null : AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              
            },
          ),
        ]
      ),
      body: Center(
        child: getMainWidget(context)
      ),
    );
  }
}