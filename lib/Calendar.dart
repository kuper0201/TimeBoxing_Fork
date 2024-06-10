import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart' as CV; // 캘린더
import 'package:flutter/material.dart';
import 'package:time_boxing/DB/database.dart';
import 'package:time_boxing/home_steps/data/PlanTime.dart';
import 'calendar_steps/StepViewPage.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

 Mydatabase mydb = Mydatabase.instance;

class _CalendarViewState extends State<CalendarView> {
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  // DateTime focusedDay = DateTime.now();
  
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   initializeDateFormatting(Localizations.localeOf(context).languageCode);
  // }

  Future<List<TimeBoxingInfoData>> fetchFromDB() async {
    return mydb.timeBoxingRepository.selectPriority(selectedDay);
  }

   Future<List<TimeBoxingInfoData>> getAllPlan() async {
    return mydb.timeBoxingRepository.selectTimeBoxing(selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CV.SfCalendar(
            view: CV.CalendarView.month,
            showNavigationArrow: true,
            todayHighlightColor: Colors.red,
            onSelectionChanged: (calendarSelectionDetails) {
              setState(() {
                selectedDay = calendarSelectionDetails.date!;
              });
            },
          ),
          Expanded(child:FutureBuilder(
            future: fetchFromDB(),
            builder: (context, snapshot) {
              if(!snapshot.hasData) {
                return const CircularProgressIndicator();
              } 
              else if(snapshot.data!.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child:Card(
                              child:ListTile(
                                title: Text("Priority 1", textAlign: TextAlign.center,),
                                subtitle: Text(snapshot.data![0].task, style: TextStyle(fontSize:20),textAlign: TextAlign.center,)
                              )
                            )
                          ),
                          Expanded(
                            child:Card(
                              child:ListTile(
                                title: Text("Priority 2", textAlign: TextAlign.center,),
                                subtitle: Text(snapshot.data![1].task, style: TextStyle(fontSize:20),textAlign: TextAlign.center,)
                              )
                            )
                          ),
                          Expanded(
                            child:Card(
                              child:ListTile(
                                title: Text("Priority 3", textAlign: TextAlign.center,),
                                subtitle: Text(snapshot.data![2].task, style: TextStyle(fontSize:20),textAlign: TextAlign.center,)
                              )
                            )
                          ),
                        ]
                      )
                    ),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(), 
                        onPressed:() async{
                          List<String> nameList = [];
                            List<String> priority = [];
                            Map<String, DateTime> startTime = {};
                            Map<String, DateTime> endTime = {};
                            List<PlanTime> planList = [];

                            final selAll = await getAllPlan();
                            for(final it in selAll) {
                              nameList.add(it.task);
                              
                              if(it.priority != -1) {
                                priority.add(it.task);
                              }

                              startTime[it.task] = DateTime(selectedDay.year, selectedDay.month, selectedDay.day, it.startTime ~/ 60, it.startTime % 60);
                              endTime[it.task] = DateTime(selectedDay.year, selectedDay.month, selectedDay.day, it.endTime ~/ 60, it.endTime % 60);

                              planList.add(PlanTime(title: it.task, description: "", start: startTime[it.task]!, end: endTime[it.task]!));
                            }

                            if(context.mounted) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => StepViewPage(nameList, priority, startTime, endTime, planList, selectedDay))).then((v) {
                                setState(() {});
                              });
                            }
                        },
                        child: const Text("전체일정 보기")
                      )
                    ),
                  ],
                );
              } else {
                return Expanded(child: Container());
              }
            }
          ))
        ]
      )
    );
  } 
}
      