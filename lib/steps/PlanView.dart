import 'package:flutter/material.dart';

class PlanView extends StatefulWidget {
  final List<String> nameList;
  final PageController pc;
  const PlanView({Key? key, required this.nameList, required this.pc}) : super(key: key);

  @override
  _PlanViewState createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Step 3: Planning"),
        centerTitle: true,
        backgroundColor: Colors.pink,
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
                return Card(
                  child: ListTile(
                    title: Expanded(child: Padding(padding: const EdgeInsets.only(left: 10), child: Text("${widget.nameList[index]}", style: const TextStyle(fontSize: 21)))),
                    trailing: TextButton(onPressed:() {
                      
                    }, child: const Text("time set")),
                  )
                );
              }
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: OutlinedButton(onPressed: () {
                    // DB 저장

                    // 초기화면으로 돌아감
                    Navigator.popUntil(context, (route) => route.isFirst);
                  }, child: const Text("저장"))
                )
              )
            ],
          )
        ],
      )
    );
  }
}