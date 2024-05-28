import 'package:flutter/material.dart';
import 'package:time_boxing/DB/database.dart';
import 'package:time_boxing/DB/repository.dart';

class testpage extends StatefulWidget {
  const testpage({Key? key}) : super(key: key);

  @override
  _testpage createState() => _testpage();
}

class _testpage extends State<testpage> {
  TimeBoxingRepository repository = TimeBoxingRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Drift Sample Page',
        ),
      ),
      body: FutureBuilder<List<TimeBoxingInfoData>>(
        future: repository.selectTimeBoxing(DateTime.now()),
        builder: (context, snapshot) {
          // loading
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // empty
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Todo is empty',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            );
          }

          return ListView(
            children: snapshot.data!
                .map(
                  (e) => ListTile(
                title: Text('${e.date} ${e.task}'),
              ),
            )
                .toList(),
          );
        },
      ),
      floatingActionButton: addBtn(),
    );
  }

  //삭제 기능 보류
  /*
  Widget deleteBtn(int id) => IconButton(
    onPressed: () {
      setState(() {
        repository.deleteTodo(id);
      });
    },
    icon: const Icon(Icons.delete_forever),
  );
  */

  // 업데이트 기능 보류
  /*
  Widget updateBtn(Todo todo) => IconButton(
    onPressed: () {
      setState(() {
        var title =
        todo.title.contains('update') ? 'title' : 'update title';

        repository.updateTodo(
          Todo(
            id : todo.id,
            title: title,
            done: false,
          ),
        );
      });
    },
    icon: const Icon(Icons.update_sharp),
  );
  */

  FloatingActionButton addBtn() => FloatingActionButton(
    child: Icon(Icons.add),
    onPressed: () {
      setState(() {
        repository.insertTimeBoxing(DateTime.now(), 'string', 1, 09, 08);
      });
    },
  );
}