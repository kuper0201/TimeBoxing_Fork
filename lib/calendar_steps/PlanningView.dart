import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_week_view/flutter_week_view.dart';

import 'package:time_boxing/home_steps/data/PlanTime.dart';

class PlanView extends StatefulWidget {
  final List<String> nameList;
  final List<String> priority;
  final Map<String, DateTime> startTime;
  final Map<String, DateTime> endTime;
  final List<PlanTime> planList;
  final PageController pc;
  final DateTime selectedDay;

  const PlanView({super.key, required this.nameList, required this.priority, required this.startTime, required this.endTime, required this.planList, required this.pc, required this.selectedDay});

  @override
  State<PlanView> createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView> {
  List<Color> colors = [const Color.fromARGB(255, 171, 222, 230), const Color.fromARGB(255, 203, 170, 203), const Color.fromARGB(255, 255, 255, 181), Color.fromARGB(255, 255, 204, 182), Color.fromARGB(255, 243, 176, 195)];
  final random = Random();

  @override
  Widget build(BuildContext context) {
    print(widget.planList);
    return Scaffold(
      appBar: AppBar(
         title: const Text("Step 3: Planning"),
        centerTitle: true,
        backgroundColor: Colors.pink,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            widget.pc.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
          },
        ),
      ),
      body: Column(
        children: [
           Expanded(
            flex: 10,
            child: Container(
              child: DayView(
                userZoomable: false,
                events: widget.planList,
                date: widget.selectedDay,
                style: const DayViewStyle(headerSize: 0),
              ),
            ),
           ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst); 
                },
                child: const Text("확인")
              )
            )
          )
        ],
      )
    );
  }
}