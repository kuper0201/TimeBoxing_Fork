import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
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
  
  int check = 0;
  int uncheck = 0;

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
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              //에러일경우 에러메세지 출력
              'Error ${snapshot.error}',
              style: const TextStyle(fontSize: 15)
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
            
          check = 0;
          uncheck = 0;

          int idx = 0;
          label : for(final d in converted) {
            idx = d.date - d.stack + 1;
            for(int i = 0; i < d.stack; i++) {
              if(idx >= maxStreakSize) break label;
              check += 1;
              items[idx] = true;
              idx++;
            }
          }

          uncheck = maxStreakSize - check;
          double fontSize = MediaQuery.of(context).size.width * 0.3 / 15;

          //테이블 그리기
          return Column(
            children:[
              Expanded(flex: 1, child: Container(width: double.infinity, child: Text("연속$currentStack일 진행중입니다", textAlign: TextAlign.start))),
              Table(
                  children: [
                    TableRow(
                      children: List.generate(7, (colIndex) {
                        if(colIndex == 0) {
                          return Center(
                            child: Text(
                              "Today",
                              style: TextStyle(fontSize: fontSize),
                              textAlign: TextAlign.center
                            )
                          );
                        }

                        return TableCell(child: Container(color: Colors.green));
                      }),
                    )
                  ],
              ),
              Expanded(
                flex: 9,
                child: Table(
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
              ),
              Container(padding: const EdgeInsets.only(top: 10), width: double.infinity, child: Text("최대스택: $maxstack")),
              Expanded(flex: 2, child: TextButton(onPressed:(){ Navigator.push(context, MaterialPageRoute(builder: (context) => const MoreHistoryView(),));}, child: const Text("더보기"))),
              Expanded(
                flex: 11,
                child: PieChart(
                  initialAngleInDegree: -90,
                  colorList: const [Colors.green, Colors.red],
                  dataMap: {'일정을 세운 날': check.toDouble(), '일정을 세우지 않은 날': uncheck.toDouble()},
                  legendOptions: const LegendOptions(
                    legendPosition: LegendPosition.bottom,
                    showLegendsInRow: true
                  ),
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValueBackground: false,
                    decimalPlaces: 0
                  ),
                )
              ),
            ]
          );
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(padding: const EdgeInsets.only(left:10,right: 10), child: getCustomTable()),
    );
  }
}