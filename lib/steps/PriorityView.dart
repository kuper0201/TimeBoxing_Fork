import 'package:flutter/material.dart';

class PriorityView extends StatefulWidget {
  final List<String> nameList;
  final PageController pc;
  const PriorityView({super.key, required this.nameList, required this.pc});
  
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
        title: const Text("Step 2: Priority"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            widget.pc.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
          },
        ),
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
                    setState(() {
                      if(priority.containsKey(widget.nameList[index])) {
                        priority.remove(widget.nameList[index]);
                        // priIdx--;
                      } else {
                        // priority[nameList[index]] = priIdx;
                        // priIdx++;
                      }
                    });
                  },
                  child: Card(
                    child: ListTile(
                      title: Expanded(child: Padding(padding: const EdgeInsets.only(left: 10), child: Text("${widget.nameList[index]}", style: const TextStyle(fontSize: 21)))),
                      trailing: Text("${priority.containsKey(widget.nameList[index]) ? priority[widget.nameList[index]] : "-1"}")
                    )
                  )
                );
              }
            )
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: OutlinedButton(onPressed: () {
                    widget.pc.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
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