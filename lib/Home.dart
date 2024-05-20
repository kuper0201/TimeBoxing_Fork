import 'package:flutter/material.dart';
import 'package:time_boxing/steps/StepViewPage.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const StepViewPage()));
          },
          child: Ink(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              borderRadius: BorderRadius.circular(15)
            ),
            child: const Center(
              child: Column(
                children: [
                  Expanded(child: Text("Add", style: TextStyle(fontSize: 28))),
                  Expanded(child: Icon(Icons.add, size: 50,))
                ]
              ),
            )
          )
        )
      ),
    );
  }
}