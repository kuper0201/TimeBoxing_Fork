import 'package:flutter/material.dart';

class PlanView extends StatefulWidget {
  const PlanView({Key? key}) : super(key: key);

  @override
  _PlanViewState createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(child: Text("Page 3")),
          OutlinedButton(onPressed: () {
            // DB 저장

            // 초기화면으로 돌아감
            Navigator.popUntil(context, (route) => route.isFirst);

          }, child: Text("Save"))
        ],
      )
    );
  }
}