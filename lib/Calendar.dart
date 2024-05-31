import 'package:syncfusion_flutter_calendar/calendar.dart' as CV; // 캘린더
import 'package:flutter/material.dart';

import 'calendar_steps/FlushView.dart';
import 'calendar_steps/PlanningView.dart';
import 'calendar_steps/PriView.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  _CalendarViewState createState() => _CalendarViewState();
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
        ]
      )
    );
  }
}