import 'package:flutter/material.dart';
import 'package:time_boxing/DB/repository.dart';

class Testpage extends StatelessWidget {
  final DateTime date = DateTime.now();
  final task = TextEditingController();

  Future<void> insertTimeBoxing() async {
    var repository = TimeBoxingRepository();
    repository.insertTimeBoxing(date, task.text, 1, 09, 12);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('insert'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: task,
                decoration: InputDecoration(
                  labelText: 'wirte task'
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
         onPressed: (){
          insertTimeBoxing();
          Navigator.pop(context);
        },
         child: Icon(Icons.add)
      ),
    );
  }
}