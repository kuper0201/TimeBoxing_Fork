import 'package:flutter/material.dart';

class FlushView extends StatefulWidget {
  final List<String> nameList;
  final List<String> priority;
  final PageController pc;
  const FlushView({Key? key, required this.nameList, required this.priority, required this.pc}) : super(key: key);

  @override
  _FlushViewState createState() => _FlushViewState();
}

class _FlushViewState extends State<FlushView> {
  TextEditingController tc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Step 1: Flush"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(3),
              itemCount: widget.nameList.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if(widget.nameList.length == index) {
                  return Card(
                    child: ListTile(
                      title: Expanded(child: Padding(padding: const EdgeInsets.only(left: 10), child: TextField(autofocus: true, controller: tc,))),
                    )
                  );
                } else {
                  return Card(
                    child: ListTile(
                      title: Expanded(child: Padding(padding: const EdgeInsets.only(left: 10), child: Text("${widget.nameList[index]}", style: const TextStyle(fontSize: 21)))),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            if(widget.priority.contains(widget.nameList[index])) {
                              widget.priority.remove(widget.nameList[index]);
                            }

                            widget.nameList.removeAt(index);
                          });
                        },
                        icon: const Icon(Icons.delete_forever, color: Colors.red,)
                      )
                    )
                  );
                }
              }
            )
          ),
          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                if(!widget.nameList.contains(tc.text)) {
                  if(!tc.text.isEmpty) {
                    widget.nameList.add(tc.text);
                    tc.clear();
                  }
                }
              });
            },
            icon: const Icon(Icons.add),
            label: const Text("Add")
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
                    child: const Text("다음"))
                )
              )
            ],
          )
        ],
      )
    );
  }
}