import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:time_boxing/MoreHistoryView.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);
  @override
  _HistoryViewState createState() => _HistoryViewState();
}

//더미데이터 형식(db연결후 지울것)
class Dummy{
  final int date;
  final int stack;
  
  Dummy({required this.date, required this.stack});
}

class CustomTable extends StatelessWidget { //db쿼리문 통해 35일전 date값 이후의 값만 불러올것
  @override
  Widget build(BuildContext context) {
    double cellSize = MediaQuery.of(context).size.width/10; // 칸의 크기를 화면 너비의 1/10로 설정
    double screenHeight = MediaQuery.of(context).size.height*0.3/5; 

    //Boolean 리스트 생성
    List<Dummy> dummy = [Dummy(date: 2,stack: 2),Dummy(date: 6, stack: 2),Dummy(date: 12, stack: 5),Dummy(date: 40, stack: 20)];
    List<bool> items = [];
    for(int i=dummy.length-1; i>0; i--){
      for(int j=0; j<dummy[i].stack; j++){
        items.add(true);
      }
      for(int j=0; j<(dummy[i].date-dummy[i].stack)-(dummy[i-1].date); j++){
        items.add(false);
      }
    }
    for(int i=0; i<dummy[0].stack; i++){
      items.add(true);
    }
    //리스트크기 35개로 자르기
    if (items.length > 35) {
      items = items.sublist(0, 35);
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
  int stack = 5;//dummy[dummy.length-1].stack;//추후 db에서 불러올것
  int maxStack = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      body: Column(
          children: [
            Container(width: double.infinity, child: Text("연속$stack일 진행중입니다")),
            Container(padding: EdgeInsets.all(10), child: CustomTable()),
            Container(width: double.infinity, child: Text("최대스택: $maxStack")),
            TextButton(onPressed:(){  Navigator.push(context, MaterialPageRoute(builder: (context) => const MoreHistoryView(),));}, child: Text("더보기")),
            Container(padding: EdgeInsets.only(top:50), child: Image.asset('assets/images/crown.png',height: 128,width: 128))
          ],
      )
    );
  }
}