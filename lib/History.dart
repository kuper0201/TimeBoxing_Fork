import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:time_boxing/MoreHistoryView.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});
  
  @override
  State<HistoryView> createState() => _HistoryViewState();
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
    dummy = dummy.reversed.toList();

    int today = 40;
    int maxStreakSize = 35;
    List<Dummy> converted = dummy.map((d) => Dummy(date: today - d.date, stack: d.stack)).toList();
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
  int stack = 5;//dummy[dummy.length-1].stack;//추후 db에서 불러올것
  int maxStack = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      body: Column(
          children: [
            Container(width: double.infinity, child: Text("연속$stack일 진행중입니다")),
            Container(width: double.infinity, padding: EdgeInsets.only(left: 5+MediaQuery.of(context).size.width/20,top:10), child: Text(style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.3/15),"Today")),
            Container(padding: EdgeInsets.only(left:10,right: 10), child: CustomTable()),
            Container(padding: EdgeInsets.only(top: 10), width: double.infinity, child: Text("최대스택: $maxStack")),
            TextButton(onPressed:(){  Navigator.push(context, MaterialPageRoute(builder: (context) => const MoreHistoryView(),));}, child: Text("더보기")),
            Container(padding: EdgeInsets.only(top:50), child: Image.asset('assets/images/crown.png',height: 128,width: 128))
          ],
      )
    );
  }
}