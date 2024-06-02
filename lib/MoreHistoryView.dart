import 'package:flutter/material.dart';
import 'package:time_boxing/DB/database.dart';
import 'package:time_boxing/DB/repositoryForZandi.dart';

RepositoryForZandi repository = RepositoryForZandi();

//set today
DateTime today = DateTime(
  DateTime.now().year,
  DateTime.now().month,
  DateTime.now().day,
);

Future<List> getzaniAll() async {
  final result = await repository.selectZandiAll();
  return result;
}

Future<List> getzaniMostLate() async {
  final result = await repository.selectMostLateData();
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
    
    //Boolean 리스트 생성
    List<ZandiInfoData> ZandiData = getzaniAll() as List<ZandiInfoData>;
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