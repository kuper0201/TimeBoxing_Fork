import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:time_boxing/DB/database.dart';
import 'package:time_boxing/MoreHistoryView.dart';
import 'package:time_boxing/DB/repositoryForZandi.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);
  @override
  _HistoryViewState createState() => _HistoryViewState();
}

RepositoryForZandi repository = RepositoryForZandi();
int CureentStack = 0;

//get today
DateTime today = DateTime(
  DateTime.now().year,
  DateTime.now().month,
  DateTime.now().day,
);

// get Zandi MaxStack
Future<int> getMaxStack() async {
  final result = await repository.selectZandi35MaxStack();
  final maxstack = result.first.stack;
  return maxstack;
}

//get ZandiList 35 ago
Future<List> getZandi35Ago() async {
  final result = await repository.selectZandi35DaysAgo(today.subtract(const Duration(days: 35)));
  return result;
}

//zandiInfo리스트 형식을 date : int 에서 int : int 로 바꾸기위한 List형식
class ZandiInfoConvert {
  final int date;
  final int stack;

  ZandiInfoConvert({required this.date, required this.stack});
}

//연속일자 저장빈값
int currentStack = 0;

class CustomTable extends StatelessWidget { //db쿼리문 통해 35일전 date값 이후의 값만 불러올것
  @override
  Widget build(BuildContext context) {
    double cellSize = MediaQuery.of(context).size.width/10; // 칸의 크기를 화면 너비의 1/10로 설정
    double screenHeight = MediaQuery.of(context).size.height*0.3/5; 
    
    //Boolean 리스트 생성
    List<ZandiInfoData> ZandiData = getZandi35Ago() as List<ZandiInfoData>;

    //연속일자 값 저장
    currentStack = ZandiData[ZandiData.length-1].stack;

    int maxStreakSize = 35;
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
    
    //테이블 그리기
    return Table(
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
    );
  }
}

class _HistoryViewState extends State<HistoryView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      body: Column(
          children: [
            Container(width: double.infinity, child: Text("연속$currentStack일 진행중입니다")),
            Container(width: double.infinity, padding: EdgeInsets.only(left: 5+MediaQuery.of(context).size.width/20,top:10), child: Text(style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.3/15),"Today")),
            Container(padding: EdgeInsets.only(left:10,right: 10), child: CustomTable()),
            Container(padding: EdgeInsets.only(top: 10), width: double.infinity, child: Text("최대스택: $getMaxStack()")),
            TextButton(onPressed:(){  Navigator.push(context, MaterialPageRoute(builder: (context) => const MoreHistoryView(),));}, child: Text("더보기")),
            Container(padding: EdgeInsets.only(top:50), child: Image.asset('assets/images/crown.png',height: 128,width: 128))
          ],
      )
    );
  }
}