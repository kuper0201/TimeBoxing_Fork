import 'package:flutter/material.dart';
import 'package:time_boxing/steps/PlanView.dart';

class PriorityView extends StatefulWidget {
  const PriorityView({super.key, required this.nameList});
  final List<String> nameList;

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
              itemCount: widget.nameList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    if(priority.containsKey(widget.nameList[index])) {
                      priority.remove(widget.nameList[index]);
                    } else {
                      priority[widget.nameList[index]] = 0;
                    }
                  },
                  child: Card(
                    child: ListTile(
                      title: Expanded(child: Padding(padding: EdgeInsets.only(left: 10), child: Text("${widget.nameList[index]}", style: const TextStyle(fontSize: 21)))),
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
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: OutlinedButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PlanView()));
                  }, child: const Text("다음"))
                )
              )
            ],
          )
        ],
      )
    );
  }
}