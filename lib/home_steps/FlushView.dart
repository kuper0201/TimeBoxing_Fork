import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_boxing/home_steps/data/PlanTime.dart';

class FlushView extends StatefulWidget {
  final List<String> nameList;
  final List<String> priority;
  final List<PlanTime> planList;
  final PageController pc;
  const FlushView({super.key, required this.nameList, required this.priority, required this.planList, required this.pc});

  @override
  State<FlushView> createState() => _FlushViewState();
}

class _FlushViewState extends State<FlushView> {
  late TextEditingController textEditController;

  @override
  void initState() {
    textEditController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditController.dispose();
    super.dispose();
  }

  Widget getTextInputItem() {
    return Card(
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Expanded(flex: 8, child: TextField(autofocus: true, controller: textEditController, decoration: const InputDecoration(hintText: "일정을 입력하세요"))),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.lightGreen,
                  ),
                  child: IconButton(
                    onPressed: () {
                      if(!widget.nameList.contains(textEditController.text)) {
                        if(textEditController.text.isNotEmpty) {
                          setState(() {
                            widget.nameList.add(textEditController.text);
                            textEditController.clear();
                          });
                        }
                      }
                    },
                    icon: const Icon(Icons.add),
                  ),
                )
              )
            ]
          )
        )
      )
    );
  }

  Widget getItem(int index) {
    return Card(
      child: ListTile(
        title: Padding(padding: const EdgeInsets.only(left: 10), child: Text(widget.nameList[index], style: const TextStyle(fontSize: 21))),
        trailing: IconButton(
          onPressed: () {
            PlanTime item = PlanTime(title: widget.nameList[index], description: "", start: DateTime.now(), end: DateTime.now());
            setState(() {
              widget.priority.remove(widget.nameList[index]);
              widget.planList.remove(item);
              widget.nameList.removeAt(index);
            });
          },
          icon: const Icon(Icons.delete_forever, color: Colors.red,)
        )
      )
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
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(3),
              itemCount: widget.nameList.length + 1, // 존재하는 리스트 크기 + 1 (입력부 출력)
              itemBuilder: (BuildContext context, int index) {
                // 마지막 인덱스일 경우, 입력 아이템 출력
                if(widget.nameList.length == index) {
                  return getTextInputItem();
                }

                // 추가된 아이템 출력
                return getItem(index);
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