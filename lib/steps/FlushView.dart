import 'package:flutter/material.dart';
import 'package:time_boxing/steps/PriorityView.dart';

class FlushView extends StatefulWidget {
  const FlushView({Key? key}) : super(key: key);

  @override
  _FlushViewState createState() => _FlushViewState();
}

class _FlushViewState extends State<FlushView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(child: Text("Page 1")),
          Row(
            children: [
              OutlinedButton(onPressed: () {
                Navigator.pop(context);
              }, child: Text("Cancel")),
              OutlinedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PriorityView()));
              }, child: Text("Next"))
            ],
          )
        ],
      )
    );
  }
}