import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlushView extends StatefulWidget {
  final List<String> nameList;
  final List<String> priority;
  final PageController pc;
  const FlushView({super.key, required this.nameList, required this.priority, required this.pc});

  @override
  _FlushViewState createState() => _FlushViewState();
}

class _FlushViewState extends State<FlushView> {
  GlobalKey gk = GlobalKey();
  GlobalKey gk2 = GlobalKey();
  GlobalKey gk3 = GlobalKey();
  bool isOver = false;

  TextEditingController tc = TextEditingController();
  FocusNode fn = FocusNode();

  bool checkSize() {
    final rb1 = gk.currentContext!.findRenderObject() as RenderBox;
    final rb2 = gk2.currentContext!.findRenderObject() as RenderBox;
    final rb3 = gk3.currentContext!.findRenderObject() as RenderBox;
    
    return rb1.size.height <= rb2.size.height * (widget.nameList.length + 1) + rb3.size.height;
  }

  Widget getButton() {
    return OutlinedButton.icon(
      onPressed: () {
        setState(() {
          if(!widget.nameList.contains(tc.text)) {
            if(tc.text.isNotEmpty) {
              widget.nameList.add(tc.text);
              tc.clear();
            }
          }
        
          if(gk2.currentContext != null) {
            isOver = checkSize();
          }
        });

        FocusScope.of(context).requestFocus(fn);
      },
      icon: const Icon(Icons.add),
      label: const Text("추가")
    );
  }

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
              key: gk,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(3),
              itemCount: widget.nameList.length + 1 + ((!isOver) ? 1 : 0),
              itemBuilder: (BuildContext context, int index) {
                if(widget.nameList.length + 1 == index) {
                  return Card(
                    child: ListTile(
                      title: Expanded(child: Padding(padding: const EdgeInsets.only(left: 10), child: getButton())),
                    )
                  );
                } else if(widget.nameList.length == index) {
                  return Card(
                    key: gk3,
                    child: ListTile(
                      title: Expanded(child: Padding(padding: const EdgeInsets.only(left: 10), child: TextField(autofocus: true, controller: tc, decoration: const InputDecoration(hintText: "일정을 입력하세요"), focusNode: fn))),
                    )
                  );
                } else {
                  return Card(
                    key: (index == 0) ? gk2 : null,
                    child: ListTile(
                      title: Expanded(child: Padding(padding: const EdgeInsets.only(left: 10), child: Text(widget.nameList[index], style: const TextStyle(fontSize: 21)))),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            if(widget.priority.contains(widget.nameList[index])) {
                              widget.priority.remove(widget.nameList[index]);
                            }

                            widget.nameList.removeAt(index);

                            isOver = checkSize();
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

          if(isOver) Card(
            child: ListTile(
              title: Expanded(child: Padding(padding: const EdgeInsets.only(left: 10), child: getButton())),
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