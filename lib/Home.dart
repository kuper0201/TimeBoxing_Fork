import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Center(
        child: InkWell(
          onTap: () {

          },
          child: Ink(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 100, 230, 113),
              borderRadius: BorderRadius.circular(15)
            ),
            child: const Center(
              child: Column(
                children: [
                  Text("Add", style: TextStyle(fontSize: 18)),
                  Icon(Icons.add)
                ]
              ),
            )
          )
        )
      ),
    );
  }
}