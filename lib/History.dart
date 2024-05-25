import 'package:flutter/material.dart';
import 'package:time_boxing/MoreHistoryView.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class SquareTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double cellSize = MediaQuery.of(context).size.width/10; // 칸의 크기를 화면 너비의 1/10로 설정
    double screenHeight = MediaQuery.of(context).size.height*0.3/5;

    return Table(
      columnWidths: {
        for (int i = 0; i < 7; i++) i: FixedColumnWidth(cellSize), // 각 열의 폭을 cellSize로 설정
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: List.generate(
        5, // 행의 수
        (rowIndex) {
          return TableRow(
            children: List.generate(
              7, // 열의 수
              (colIndex) {
                return Container(
                  width: cellSize,
                  height: screenHeight,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      '${rowIndex * 7 + colIndex}',
                      style: TextStyle(fontSize: 12), // 텍스트 크기를 작게 조정
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _HistoryViewState extends State<HistoryView> {
  int stack = 0;//추후 db에서 불러올것
  int maxStack = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      body: Column(
          children: [
            Container(width: double.infinity, child: Text("연속$stack일 진행중입니다")),
            Container(padding: EdgeInsets.all(10), child: SquareTable()),
            Container(width: double.infinity, child: Text("최대스택: $maxStack")),
            TextButton(onPressed:(){  Navigator.push(context, MaterialPageRoute(builder: (context) => const MoreHistoryView(),));}, child: Text("더보기")),
            Container(padding: EdgeInsets.only(top:50), child: Image.asset('assets/images/crown.png',height: 128,width: 128))
          ],
      )
    );
  }
}