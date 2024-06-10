import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:time_boxing/DB/database.dart';
import 'package:time_boxing/MoreHistoryView.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});
  
  @override
  State<HistoryView> createState() => _HistoryViewState();
}

//zandiInfo리스트 형식을 date : int 에서 int : int 로 바꾸기위한 List형식
class ZandiInfoConvert {
  final int date;
  final int stack;

  ZandiInfoConvert({required this.date, required this.stack});
}

class _HistoryViewState extends State<HistoryView> {
  //연속일자 저장빈값
  int currentStack = 0;

  //최대 stack 저장빈값
  int maxstack = 0;

  Mydatabase db = Mydatabase.instance;

//get today
DateTime today = DateTime(
  DateTime.now().year,
  DateTime.now().month,
  DateTime.now().day,
);

//Zandi MaxStack
Future<int> getMaxStack() async {
  final result = await db.zandiRepository.selectZandi35MaxStack();
  final maxstack = result.first.stack;
  return maxstack;
}

//get ZandiList 35 ago
Future<List<ZandiInfoData>> getZandi35Ago() async {
  final result = await db.zandiRepository.selectZandi35DaysAgo(today.subtract(const Duration(days: 34)));
  return result;
}

  Widget getCustomTable() {
    double cellSize = MediaQuery.of(context).size.width/10; // 칸의 크기를 화면 너비의 1/10로 설정
    double screenHeight = MediaQuery.of(context).size.height*0.3/5;

    return FutureBuilder (
      future: Future.wait([getZandi35Ago(), getMaxStack()]),
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
          List<ZandiInfoData> ZandiData = snapshot.data![0] as List<ZandiInfoData>;
          maxstack = snapshot.data![1] as int;


          //연속일자 값 저장 최근값이 오늘날짜인지 확인 list.first.date에 현재스택값-1 값 더한값이 오늘이랑 같을경우 연속일자 가져옴
          if((ZandiData[ZandiData.length-1].date.add(Duration(days: ZandiData[ZandiData.length-1].stack - 1)))==today) {
              currentStack = ZandiData[ZandiData.length-1].stack;
          }

          int maxStreakSize = 35;
          List<ZandiInfoConvert> converted = ZandiData.map((d) => ZandiInfoConvert(date: (today.difference(d.date).inDays), stack: d.stack)).toList();
          List<bool> items = List.generate(maxStreakSize, (idx) => false);
            
          int idx = 0;
          label : for(final d in converted) {
            idx = d.date - d.stack + 1;
            for(int i = 0; i < d.stack; i++) {
              if(idx >= maxStreakSize) break label;
                items[idx] = true;
                idx++;
            }
          }

          //테이블 그리기
          return Column(

           children:[
            Container(width: double.infinity, child: Text("연속$currentStack일 진행중입니다")),
            Container(width: double.infinity, padding: EdgeInsets.only(left: 5+MediaQuery.of(context).size.width/20,top:10), child: Text(style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.3/15),"Today")),
            Table(
            border: TableBorder.all(),
            children: List<TableRow>.generate(5, (rowIndex) {
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
          ),
           Container(padding: EdgeInsets.only(top: 10), width: double.infinity, child: Text("최대스택: $maxstack")),
          ]);
        }
      }
    );
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      body: Column(
          children: [
            Container(padding: EdgeInsets.only(left:10,right: 10), child: getCustomTable()),
            TextButton(onPressed:(){  Navigator.push(context, MaterialPageRoute(builder: (context) => const MoreHistoryView(),));}, child: Text("더보기")),
            Container(padding: EdgeInsets.only(top:50), child: Image.asset('assets/images/crown.png',height: 128,width: 128))
          ],
      )
    );
  }
}