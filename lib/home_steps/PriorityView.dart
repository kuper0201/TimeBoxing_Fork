import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriorityView extends StatefulWidget {
  final List<String> nameList;
  final List<String> priority;
  final PageController pc;
  const PriorityView({super.key, required this.nameList, required this.priority, required this.pc});
  
  @override
  State<PriorityView> createState() => _PriorityViewState();
}

class _PriorityViewState extends State<PriorityView> {
  int currentPriority = 0;

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }
  
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
                String name = widget.nameList[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if(widget.priority.contains(name)) {
                        widget.priority.remove(name);
                      } else if(widget.priority.length < 3) {
                        widget.priority.add(name);
                      }
                    });
                  },
                  child: Card(
                    child: ListTile(
                      title: Padding(padding: const EdgeInsets.only(left: 10), child: Text(name, style: const TextStyle(fontSize: 21))),
                      trailing: Text("${widget.priority.contains(name) ? widget.priority.indexOf(name) + 1 : ""}", style: const TextStyle(fontSize: 21),)
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
                  child: OutlinedButton(
                    onPressed: () {
                      widget.pc.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
                    },
                    child: const Text("다음")
                  )
                )
              )
            ],
          )
        ],
      )
    );
  }
}