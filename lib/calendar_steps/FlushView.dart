import 'package:flutter/material.dart';

class FlushView extends StatefulWidget {
  const FlushView({super.key});

  @override
  State<FlushView> createState() => _FlushViewState();
}

class _FlushViewState extends State<FlushView> {
  List<String> nameList = [];
  TextEditingController tc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Step 1: Flush"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(3),
              itemCount: nameList.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if(nameList.length == index) {
                  return Card(
                    child: ListTile(
                      title: Expanded(child: Padding(padding: const EdgeInsets.only(left: 10), child: TextField(autofocus: true, controller: tc,))),
                    )
                  );
                } else {
                  return Card(
                    child: ListTile(
                      title: Expanded(child: Padding(padding: const EdgeInsets.only(left: 10), child: Text(nameList[index], style: const TextStyle(fontSize: 21)))),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            nameList.removeAt(index);
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
        ],
      )
    );
  }
}