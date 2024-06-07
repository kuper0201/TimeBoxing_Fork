import 'package:flutter/material.dart';
import 'package:time_boxing/DB/database.dart';

Mydatabase repository = Mydatabase.instance;

//set today
DateTime today = DateTime(
  DateTime.now().year,
  DateTime.now().month,
  DateTime.now().day,
);

Future<List<ZandiInfoData>> getzaniAll() async {
  final result = await repository.zandiRepository.selectZandiAll();
  return result;
}

Future<List<ZandiInfoData>> getzaniMostLate() async {
  final result = await repository.zandiRepository.selectMostLateData();
  return result;
}

class ZandiInfoConvert {
  final int date;
  final int stack;

  ZandiInfoConvert({required this.date, required this.stack});
}

class MoreHistoryView extends StatefulWidget {
  const MoreHistoryView({Key? key}) : super(key: key);

  @override
  _MoreHistoryViewState createState() => _MoreHistoryViewState();
}

class CustomTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double cellSize = MediaQuery.of(context).size.width/10; // 칸의 크기를 화면 너비의 1/10로 설정
    double screenHeight = MediaQuery.of(context).size.height*0.3/5;

    return FutureBuilder<List<ZandiInfoData>> (
      future: getzaniAll(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          //로딩 애니메이션
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Padding(padding: const EdgeInsets.all(8.0),
          child: Text(
            //에러일경우 에러메세지 출력
            'Error ${snapshot.error}',
            style: TextStyle(fontSize: 15)
            ),
          );
        } else {
          //데이터를 정상적으로 받아올경우
          List<ZandiInfoData> ZandiData = snapshot.data!.map((d) => ZandiInfoData(date: d.date, stack: d.stack)).toList();

          List<ZandiInfoData> ZandiMostLateData = getzaniMostLate() as List<ZandiInfoData>;

          int maxStreakSize = today.difference(ZandiMostLateData.first.date).inDays; //getZandiMostLate - datetime.now()
          List<ZandiInfoConvert> converted = ZandiData.map((d) => ZandiInfoConvert(date: (today.difference(d.date).inDays), stack: d.stack)).toList();
          List<bool> items = List.generate(maxStreakSize, (idx) => false);

          int idx = 0;
          label : for(final d in converted) {
            idx = d.date;
            for(int i = 0; i < d.stack; i++) {
              if(idx >= maxStreakSize) break label;
              items[idx] = true;
              idx++;
            }
          }

          //table row check
          int tableRowCount = 0;

          //true - 7의 배수 flase - 7의배수가 아님
          if((maxStreakSize/7)%1 == 0) {
            tableRowCount = maxStreakSize.floor();
          } else {
            tableRowCount = (tableRowCount/7).ceil();
          }
          
          //테이블 그리기
          return Table(
            border: TableBorder.all(),
            children: List<TableRow>.generate(tableRowCount, (rowIndex) {
              return TableRow(
                children: List<Widget>.generate(7, (colIndex) {
                  int itemIndex = rowIndex * 7 + colIndex;
                  // 리스트의 빈값에 false초기화
                  bool item = itemIndex < items.length ? items[itemIndex] : false;
                  bool isFirstItem = itemIndex == 0;
                  return Container(
                    width: cellSize,
                    height: screenHeight,
                    alignment: Alignment.center,
                    color: isFirstItem ? Colors.yellow : Colors.white,
                    child: Icon(
                      item ? Icons.check : Icons.close,
                      color: item ? Colors.green : Colors.red,
                    ),
                  );
                }),
              );
            }),
          );
        }
      } 
    ,);
  }
}

class _MoreHistoryViewState extends State<MoreHistoryView> {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
          Expanded(
            child: ElevatedButton(
              onPressed:(){
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text("back")
            )
          ) 
      )
    );
  }
}