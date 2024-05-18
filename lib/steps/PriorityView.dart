import 'package:flutter/material.dart';
import 'package:time_boxing/steps/PlanView.dart';

class PriorityView extends StatefulWidget {
  const PriorityView({Key? key}) : super(key: key);

  @override
  _PriorityViewState createState() => _PriorityViewState();
}

class _PriorityViewState extends State<PriorityView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(child: Text("Page 2")),
          OutlinedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const PlanView()));
          }, child: Text("btn"))
        ],
      )
    );
  }
}