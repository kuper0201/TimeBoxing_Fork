import 'package:flutter/material.dart';

class PlanView extends StatefulWidget {
  const PlanView({super.key});

  @override
  State<PlanView> createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Step 3"),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: const Column(
        children: [
          
        ],
      )
    );
  }
}