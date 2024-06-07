import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart' as CV; // 캘린더
import 'package:flutter/material.dart';
import 'package:time_boxing/DB/database.dart';
import 'calendar_steps/FlushView.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}


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
    Mydatabase mydb = Mydatabase.instance;
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
          FutureBuilder(
            future: fetchFromDB(),
            builder: (context, snapshot) {
              if(!snapshot.hasData) {
                return const CircularProgressIndicator();
              } 
              else if(snapshot.data!.isNotEmpty) {
                return Column(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                        children: [
                          Expanded(child:Text(snapshot.data![0].task)),
                          Expanded(child:Text(snapshot.data![1].task)),
                          Expanded(child:Text(snapshot.data![2].task)),
                        ]
                      )
                    ),
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(), 
                        onPressed:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const FlushView(),));
                        },
                        child: const Text("flush")
                      )
                    ),
                  ],
                );
              } else {
                return Expanded(child: Container());
              }
            }
          )
        ]
      )
    );
  } 
}
      