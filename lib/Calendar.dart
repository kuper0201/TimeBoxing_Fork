import 'package:syncfusion_flutter_calendar/calendar.dart' as CV; // 캘린더
import 'package:flutter/material.dart';
import 'package:time_boxing/History.dart';

import 'calendar_steps/FlushView.dart';
import 'calendar_steps/PlanningView.dart';
import 'calendar_steps/PriView.dart';

//테스트용 코드 테스트 종료후 삭제해도됨
import 'package:time_boxing/DB/repositoryForZandi.dart';

RepositoryForZandi repistory = RepositoryForZandi();
//테스트용 코드 테스트 종료후 삭제해도됨

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CV.SfCalendar(
            view: CV.CalendarView.month,
            showNavigationArrow: true,
            todayHighlightColor: Colors.red,
          ),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(), 
              onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FlushView(),));
              },
              child: const Text("flush")
            )
          ),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PriorityView()));
                },
              child: const Text("pri")
            )
          ),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed:(){Navigator.push(context, MaterialPageRoute(builder: (context) => const PlanView()));
              },
              child: const Text("planning")
            )
          )
          //테스트용 코드 테스트 종료후 삭제해도됨
          ,
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed:(){
                
              },
              child: const Text("zandi data insert")
            )
          )
          //테스트용 코드 테스트 종료후 삭제해도됨
        ]
      )
    );
  }
}