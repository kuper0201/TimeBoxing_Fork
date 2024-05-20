import 'package:flutter/material.dart';

class PriorityView extends StatefulWidget {
  const PriorityView({Key? key}) : super(key: key);

  @override
  _PriorityViewState createState() => _PriorityViewState();
}

class _PriorityViewState extends State<PriorityView> {
  Map<String, int> priority = Map();
  int currentPriority = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Step 2"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(3),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {},
                  child: Card(
                    child: ListTile(
                      trailing: Text("${index}")
                    )
                  )
                );
                
                
                // InkWell(
                //   onTap: () {
                //     
                //   },
                //   child: Center(
                //     child: Text("${widget.nameList[index]}", style: const TextStyle(fontSize: 21)),
                //   ),
                // );
              }
            )
          ),
        ],
      )
    );
  }
}