import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:split_view/split_view.dart';

import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
import 'package:time_boxing/DB/database.dart';
import 'package:time_boxing/home_steps/data/PlanTime.dart';

class PlanView extends StatefulWidget {
  final List<String> nameList;
  final List<String> priority;
  final Map<String, DateTime> startTime;
  final Map<String, DateTime> endTime;
  final List<PlanTime> planList;
  final PageController pc;
  final bool isEdit;

  const PlanView({super.key, required this.nameList, required this.priority, required this.startTime, required this.endTime, required this.planList, required this.pc, required this.isEdit});

  @override
  State<PlanView> createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView> {
  Mydatabase db = Mydatabase.instance;

  bool isDarkMode = false;
  
  GlobalKey gk = GlobalKey();
  GlobalKey listGK = GlobalKey();

  List<Color> colors = [const Color.fromARGB(255, 171, 222, 230), const Color.fromARGB(255, 203, 170, 203), const Color.fromARGB(255, 255, 255, 181), Color.fromARGB(255, 255, 204, 182), Color.fromARGB(255, 243, 176, 195)];
  final random = Random();
  List<ExpansionTileController> expansionControllers = [];
  ScrollController scrollController = ScrollController();
  
  List<double> splitWeights = [0.6, 0.4];
  SplitViewController splitController = SplitViewController(weights: [0.6, 0.4]);
  
  bool isMoving = false;

  DragStartingGesture dg = DragStartingGesture.longPress;

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
      PlanTime item = PlanTime(title: p, description: "", start: DateTime.now(), end: DateTime.now());
      if(!widget.planList.contains(item)) return idx;
      idx++;
    }

    return widget.nameList.length;
  }

  void appendPlan(String name) {
    PlanTime item = PlanTime(title: name, description: "", start: widget.startTime[name]!, end: widget.endTime[name]!, backgroundColor: colors[random.nextInt(colors.length)]);
    setState(() {
      if(widget.planList.contains(item)) {
        widget.planList.remove(item);
      }
      widget.planList.add(item);
    });
  }

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    
    expansionControllers = List<ExpansionTileController>.generate(widget.nameList.length, (index) => ExpansionTileController());
    if(Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      dg = DragStartingGesture.tap;
    }

    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    isDarkMode = brightness == Brightness.dark;
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
              controller: splitController,
              viewMode: SplitViewMode.Vertical,
              indicator: const SplitIndicator(viewMode: SplitViewMode.Vertical),
              onWeightChanged: (value) {
                if(!isMoving) {
                  splitWeights = List.of(value).map((d) => d!).toList();
                }
              },
              gripColor: (isDarkMode) ? Colors.black12 : Colors.grey,
              gripColorActive: (isDarkMode) ? Colors.black12 : Colors.grey,
              children: [
                Container(
                  child: DayView(
                    currentTimeIndicatorBuilder:(dayViewStyle, topOffsetCalculator, hoursColumnWidth, isRtl) {},
                    userZoomable: false,
                    events: widget.planList,
                    date: DateTime.now(),
                    style: const DayViewStyle(headerSize: 0),
                    dragAndDropOptions: DragAndDropOptions(
                      startingGesture: dg,
                      onEventMove: (event, newStartTime) {
                        setState(() {
                          isMoving = true;
                          splitController.weights = [1.0, 0.0];
                        });
                      },
                      onEventDragged:(event, newStartTime) {
                        final dur = event.end.subtract(Duration(hours: event.start.hour, minutes: event.start.minute));
                        event.start = newStartTime;
                        event.end = event.start.add(Duration(hours: dur.hour, minutes: dur.minute));
                        widget.startTime[event.title] = event.start;
                        widget.endTime[event.title] = event.end;
                        
                        setState(() {
                          isMoving = false;
                          splitController.weights = splitWeights;
                        });
                      },
                    ),
                    resizeEventOptions: ResizeEventOptions(
                      snapToGridGranularity: const Duration(minutes: 15),
                      onEventResizeMove: (event, newEndTime) {
                        setState(() {
                          isMoving = true;
                          splitController.weights = [1.0, 0.0];
                        });
                      },
                      onEventResized: (event, newEndTime) {
                        event.end = newEndTime;
                        widget.endTime[event.title] = event.end;
                        
                        setState(() {
                          isMoving = false;
                          splitController.weights = splitWeights;
                        });
                      },
                    ),
                  ),
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
                          initiallyExpanded: (widget.planList.contains(PlanTime(title: widget.nameList[index], description: "", start: DateTime.now(), end: DateTime.now()))) ? false : true,
                          shape: const Border(),
                          controller: expansionControllers[index],
                          title: Padding(padding: const EdgeInsets.only(left: 10), child: Text(widget.nameList[index], style: const TextStyle(fontSize: 21))),
                          children: [
                            Padding(padding: const EdgeInsets.all(5),
                              child: SizedBox(
                                width: double.infinity,
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
                                              RenderBox listRB = listGK.currentContext!.findRenderObject() as RenderBox;
                                              RenderBox rb = gk.currentContext!.findRenderObject() as RenderBox;

                                              if(listRB.size.height <= rb.size.height * 2 * (widget.nameList.length - 3)) {
                                                scrollController.animateTo(rb.size.height * 3, duration: const Duration(microseconds: 500), curve: Curves.ease);
                                              } else {
                                                double move = scrollController.offset + (rb.size.height * 3 + rb.size.height * 2 * (widget.nameList.length - 3) - listRB.size.height);
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
                onPressed: () async {
                  // DB 저장
                  DateTime now = DateTime.now();
                  DateTime onlyDate = DateTime(now.year, now.month, now.day);
                  
                  if(widget.isEdit) {
                    await db.timeBoxingRepository.updateTimeBoxing(onlyDate);
                  } else {
                    final recentZandi = await db.zandiRepository.selectRecentData();
                    if(recentZandi.isEmpty) {
                      await db.zandiRepository.insertZandiInfo_FirstTime(onlyDate);
                    } else {
                      await db.zandiRepository.updateZandiInfo(onlyDate, recentZandi[0].stack + 1);
                    }
                  }

                  for(final item in widget.planList) {
                    int st = item.start.hour * 60 + item.start.minute;
                    int end = item.end.hour * 60 + item.end.minute;
                    await db.timeBoxingRepository.insertTimeBoxing(onlyDate, item.title, widget.priority.indexOf(item.title), st, end);
                  }

                  // 초기화면으로 돌아감
                  if(context.mounted) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  }
                },
                child: const Text("저장")
              )
            )
          )
        ]
      )
    );
  }
}