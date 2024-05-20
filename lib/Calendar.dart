import 'package:table_calendar/table_calendar.dart'; // 캘린더
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';

import 'steps/FlushView.dart';
import 'steps/PlanningView.dart';
import 'steps/PriView.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  _CalendarViewState createState() => _CalendarViewState();
}


class _CalendarViewState extends State<CalendarView> {
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();
  
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
          TableCalendar(
            firstDay: DateTime.utc(2021),
            lastDay: DateTime.utc(2030),
            focusedDay: focusedDay,
            onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
              setState(() {
                this.selectedDay = selectedDay;
                this.focusedDay = focusedDay;
              });
            },
            selectedDayPredicate: (DateTime day) {
              return isSameDay(selectedDay, day);
            },
          ),
          Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(), 
                                        onPressed:(){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const FlushView(),));
                                        },
                                        child: Text("flush"))),
          Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(),
                                        onPressed:(){Navigator.push(context, MaterialPageRoute(builder: (context) => PriorityView()));},
                                        child: Text("pri"))),
          Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(), 
                                        onPressed:(){Navigator.push(context, MaterialPageRoute(builder: (context) => PlanView()));},
                                        child: Text("planning")))
        ]
      )
    );
  }
}