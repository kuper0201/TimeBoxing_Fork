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
  State<PlanView> createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView> {
  bool isDarkMode = false;
  
  GlobalKey gk = GlobalKey();
  GlobalKey listGK = GlobalKey();
  
  List<Color> colors = [Colors.lightBlue, Colors.lightGreen, Colors.orange, Colors.purple, Colors.pink, Colors.yellow, Colors.cyan];
  final random = Random();
  List<ExpansionTileController> expansionControllers = [];
  ScrollController scrollController = ScrollController();

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
      // if(!widget.startTime.containsKey(p) || !widget.endTime.containsKey(p)) {
      PlanTime item = PlanTime(p, DateTime.now(), DateTime.now(), Colors.black, false);
      if(!widget.planList.contains(item)) return idx;
      idx++;
    }

    return widget.nameList.length;
  }

  void appendPlan(String name) {
    PlanTime item = PlanTime(name, widget.startTime[name]!, widget.endTime[name]!, colors[random.nextInt(colors.length)], false);
    setState(() {
      if(widget.planList.contains(item)) {
        widget.planList.remove(item);
      }
      widget.planList.add(item);
    });
  }

  @override
  void initState() {
    expansionControllers = List<ExpansionTileController>.generate(widget.nameList.length, (index) => ExpansionTileController());
    super.initState();
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
                  key: listGK,
                  decoration: BoxDecoration(
                    color: (isDarkMode) ? Colors.black12 : Colors.grey
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    controller: scrollController,
                    padding: const EdgeInsets.all(3),
                    itemCount: checkPrioritySet(),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        key: (index == 0) ? gk : null,
                        child: ExpansionTile(
                          initiallyExpanded: (widget.planList.contains(PlanTime(widget.nameList[index], DateTime.now(), DateTime.now(), Colors.black, false))) ? false : true,
                          shape: const Border(),
                          controller: expansionControllers[index],
                          title: Expanded(flex: 8, child: Padding(padding: const EdgeInsets.only(left: 10), child: Text(widget.nameList[index], style: const TextStyle(fontSize: 21)))),
                          children: [
                            Padding(padding: const EdgeInsets.all(5),
                              child: SizedBox(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                        // style: TextButton.styleFrom(backgroundColor: Colors.lightGreen),
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
                                            });
                                          }
                                        },
                                        child: widget.startTime.containsKey(widget.nameList[index]) ? Text("${widget.startTime[widget.nameList[index]]!.hour.toString().padLeft(2, '0')} : ${widget.startTime[widget.nameList[index]]!.minute.toString().padLeft(2, '0')}", style: const TextStyle(fontSize: 20),) : const Text("시작 시간", style: TextStyle(fontSize: 20))
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
                                            });
                                          }
                                        },
                                        child: widget.endTime.containsKey(widget.nameList[index]) ? Text("${widget.endTime[widget.nameList[index]]!.hour.toString().padLeft(2, '0')} : ${widget.endTime[widget.nameList[index]]!.minute.toString().padLeft(2, '0')}", style: const TextStyle(fontSize: 20)) : const Text("끝 시간", style: TextStyle(fontSize: 20))
                                      )
                                    ),
                                    Expanded(
                                      child: TextButton(
                                        onPressed:() {
                                          String name = widget.nameList[index];
                                          if(widget.startTime.containsKey(name) && widget.endTime.containsKey(name)) {
                                            appendPlan(name);
                                            expansionControllers[index].collapse();
                                            if(widget.startTime.length == 3 && widget.endTime.length == 3) {
                                              RenderBox list_rb = listGK.currentContext!.findRenderObject() as RenderBox;
                                              RenderBox rb = gk.currentContext!.findRenderObject() as RenderBox;

                                              if(list_rb.size.height <= rb.size.height * 2 * (widget.nameList.length - 3)) {
                                                scrollController.animateTo(rb.size.height * 3, duration: const Duration(microseconds: 500), curve: Curves.ease);
                                              } else {
                                                double move = scrollController.offset + (rb.size.height * 3 + rb.size.height * 2 * (widget.nameList.length - 3) - list_rb.size.height);
                                                scrollController.animateTo(move, duration: const Duration(microseconds: 500), curve: Curves.ease);
                                              }
                                            }
                                          }
                                        },
                                        child: const Text("완료", style: TextStyle(fontSize: 20))
                                      )
                                    )
                                  ],
                                )
                              )
                            )
                          ]
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