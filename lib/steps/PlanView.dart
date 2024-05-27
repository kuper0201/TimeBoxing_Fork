import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;

class PlanView extends StatefulWidget {
  final List<String> nameList;
  final PageController pc;
  const PlanView({Key? key, required this.nameList, required this.pc}) : super(key: key);

  @override
  _PlanViewState createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView> {
  Map<String, DateTime> startTime = {};
  Map<String, DateTime> endTime = {};
  List<Meeting> lst = <Meeting>[];
  List<Color> colors = [Colors.lightBlue, Colors.lightGreen, Colors.orange, Colors.purple, Colors.pink, Colors.yellow, Colors.cyan];
  final random = Random();
  
  @override
  Widget build(BuildContext context) {
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
              children: [
                SfCalendar(
                  view: CalendarView.day,
                  headerHeight: 0,
                  viewHeaderHeight: 0,
                  dataSource: MeetingDataSource(lst),
                  viewNavigationMode: ViewNavigationMode.none,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.grey
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(3),
                    itemCount: widget.nameList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          title: Expanded(flex:8, child: Padding(padding: const EdgeInsets.only(left: 10), child: Text("${widget.nameList[index]}", style: const TextStyle(fontSize: 21)))),
                          trailing: SizedBox(
                            width: 200,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed:() async {
                                      String name = widget.nameList[index];

                                      DateTime now = (startTime.containsKey(name)) ? startTime[name]! : DateTime.now();
                                      DateTime? selectedTime = await picker.DatePicker.showTime12hPicker(context, currentTime: now);
                                      if(selectedTime != null) {
                                        setState(() {
                                          startTime[name] = selectedTime;

                                          if(!endTime.containsKey(name) || endTime[name]!.isBefore(selectedTime)) {
                                            endTime[name] = selectedTime.add(const Duration(hours: 1));
                                          }

                                          Meeting item = Meeting(name, startTime[name]!, endTime[name]!, colors[random.nextInt(colors.length)], false);
                                          if(lst.contains(item)) {
                                            lst.remove(item);
                                          }
                                          lst.add(item);
                                        });
                                      }
                                    },
                                    child: startTime.containsKey(widget.nameList[index]) ? Text("${startTime[widget.nameList[index]]!.hour.toString().padLeft(2, '0')} : ${startTime[widget.nameList[index]]!.minute.toString().padLeft(2, '0')}") : const Text("시작 시간")
                                  )
                                ),
                                Expanded(
                                  child: TextButton(
                                    onPressed:() async {
                                      String name = widget.nameList[index];
                                      DateTime now = (endTime.containsKey(name)) ? endTime[name]! : DateTime.now();

                                      DateTime? selectedTime = await picker.DatePicker.showTime12hPicker(context, currentTime: now);
                                      if(selectedTime != null) {
                                        setState(() {
                                          endTime[name] = selectedTime;

                                          if(!startTime.containsKey(name) || selectedTime.isBefore(startTime[name]!)) {
                                            startTime[name] = selectedTime.subtract(const Duration(hours: 1));
                                          }
                                          
                                          Meeting item = Meeting(name, startTime[name]!, endTime[name]!, colors[random.nextInt(colors.length)], false);
                                          if(lst.contains(item)) {
                                            lst.remove(item);
                                          }
                                          lst.add(item);
                                        });
                                      }
                                    },
                                    child: endTime.containsKey(widget.nameList[index]) ? Text("${endTime[widget.nameList[index]]!.hour.toString().padLeft(2, '0')} : ${endTime[widget.nameList[index]]!.minute.toString().padLeft(2, '0')}") : const Text("끝 시간")
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
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting extends Equatable {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  
  @override
  List<Object?> get props => [eventName];
}