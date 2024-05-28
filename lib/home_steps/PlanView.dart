import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:split_view/split_view.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
import 'package:time_boxing/home_steps/data/PlanTime.dart';

import 'data/PlanTimeDataSource.dart';

class PlanView extends StatefulWidget {
  final List<String> nameList;
  final List<String> priority;
  final Map<String, DateTime> startTime;
  final Map<String, DateTime> endTime;
  final List<PlanTime> planList;
  final PageController pc;
  const PlanView({super.key, required this.nameList, required this.priority, required this.startTime, required this.endTime, required this.planList, required this.pc});

  @override
  _PlanViewState createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView> {
  bool isDarkMode = false;
  List<Color> colors = [Colors.lightBlue, Colors.lightGreen, Colors.orange, Colors.purple, Colors.pink, Colors.yellow, Colors.cyan];
  final random = Random();

  final darkTheme = const picker.DatePickerTheme(
    headerColor: Colors.black87,
    backgroundColor: Colors.black87,
    itemStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 18
    ),
    cancelStyle: TextStyle(color: Colors.white, fontSize: 16),
    doneStyle: TextStyle(color: Colors.blue, fontSize: 16)
  );

  int checkPrioritySet() {
    int idx = 1;
    for(final p in widget.priority) {
      if(!widget.startTime.containsKey(p) || !widget.endTime.containsKey(p)) return idx;
      idx++;
    }

    return widget.nameList.length;
  }
  
  @override
  Widget build(BuildContext context) {
    for(final p in widget.priority) {
      widget.nameList.remove(p);
    }

    widget.nameList.insertAll(0, widget.priority);

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
            child: SplitView(
              viewMode: SplitViewMode.Vertical,
              indicator: const SplitIndicator(viewMode: SplitViewMode.Vertical),
              gripColor: (isDarkMode) ? Colors.black12 : Colors.grey,
              gripColorActive: (isDarkMode) ? Colors.black12 : Colors.grey,
              children: [
                SfCalendar(
                  view: CalendarView.day,
                  headerHeight: 0,
                  viewHeaderHeight: 0,
                  dataSource: PlanTimeDataSource(widget.planList),
                  viewNavigationMode: ViewNavigationMode.none,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: (isDarkMode) ? Colors.black12 : Colors.grey
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(3),
                    itemCount: checkPrioritySet(),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          title: Expanded(flex: 8, child: Padding(padding: const EdgeInsets.only(left: 10), child: Text(widget.nameList[index], style: const TextStyle(fontSize: 21)))),
                          trailing: SizedBox(
                            width: 200,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed:() async {
                                      String name = widget.nameList[index];

                                      DateTime now = (widget.startTime.containsKey(name)) ? widget.startTime[name]! : DateTime.now();
                                      DateTime? selectedTime = await picker.DatePicker.showTime12hPicker(context, currentTime: now, theme: (isDarkMode) ? darkTheme : null);
                                      if(selectedTime != null) {
                                        setState(() {
                                          widget.startTime[name] = selectedTime;

                                          if(!widget.endTime.containsKey(name) || widget.endTime[name]!.isBefore(selectedTime)) {
                                            widget.endTime[name] = selectedTime.add(const Duration(hours: 1));
                                          }

                                          PlanTime item = PlanTime(name, widget.startTime[name]!, widget.endTime[name]!, colors[random.nextInt(colors.length)], false);
                                          if(widget.planList.contains(item)) {
                                            widget.planList.remove(item);
                                          }
                                          widget.planList.add(item);
                                        });
                                      }
                                    },
                                    child: widget.startTime.containsKey(widget.nameList[index]) ? Text("${widget.startTime[widget.nameList[index]]!.hour.toString().padLeft(2, '0')} : ${widget.startTime[widget.nameList[index]]!.minute.toString().padLeft(2, '0')}") : const Text("시작 시간")
                                  )
                                ),
                                Expanded(
                                  child: TextButton(
                                    onPressed:() async {
                                      String name = widget.nameList[index];
                                      DateTime now = (widget.endTime.containsKey(name)) ? widget.endTime[name]! : DateTime.now();

                                      DateTime? selectedTime = await picker.DatePicker.showTime12hPicker(context, currentTime: now, theme: (isDarkMode) ? darkTheme : null);
                                      if(selectedTime != null) {
                                        setState(() {
                                          widget.endTime[name] = selectedTime;

                                          if(!widget.startTime.containsKey(name) || selectedTime.isBefore(widget.startTime[name]!)) {
                                            widget.startTime[name] = selectedTime.subtract(const Duration(hours: 1));
                                          }
                                          
                                          PlanTime item = PlanTime(name, widget.startTime[name]!, widget.endTime[name]!, colors[random.nextInt(colors.length)], false);
                                          if(widget.planList.contains(item)) {
                                            widget.planList.remove(item);
                                          }
                                          widget.planList.add(item);
                                        });
                                      }
                                    },
                                    child: widget.endTime.containsKey(widget.nameList[index]) ? Text("${widget.endTime[widget.nameList[index]]!.hour.toString().padLeft(2, '0')} : ${widget.endTime[widget.nameList[index]]!.minute.toString().padLeft(2, '0')}") : const Text("끝 시간")
                                  )
                                )
                              ],
                            )
                          )
                        )
                      );
                    }
                  ),
                )
              ]
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // DB 저장

                  // 초기화면으로 돌아감
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text("저장")
              )
            )
          )
        ]
      )
    );
  }

  @override
  void initState() {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    isDarkMode = brightness == Brightness.dark;
    super.initState();
  }
}