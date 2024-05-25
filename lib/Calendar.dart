import 'package:syncfusion_flutter_calendar/calendar.dart' as CV; // sfcalendar lib
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
          CV.SfCalendar(
            view: CV.CalendarView.month ,
            showNavigationArrow: true,
            todayHighlightColor: Colors.red
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