import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_report.dart';
import 'package:number_display/number_display.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:math';

class ExpenditureReport extends StatefulWidget {
  const ExpenditureReport({
    Key? key,
    required this.size,
    required this.eventReport,
  }) : super(key: key);

  final Size size;
  final EventReport eventReport;

  @override
  _ExpenditureReportState createState() => _ExpenditureReportState();
}

class _ExpenditureReportState extends State<ExpenditureReport> {
  final Duration animDuration = const Duration(milliseconds: 250);
  final numberDisplay = createDisplay();

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: widget.size.width,
      margin: const EdgeInsets.fromLTRB(5, 5, 5, 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(1.5, 1.5),
          blurRadius: 2,
          spreadRadius: 0,
        )
      ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText.rich(
            TextSpan(
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                children: [
                  TextSpan(text: '총 '),
                  TextSpan(
                      text: numberDisplay(widget.eventReport.costSum),
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 32)),
                  TextSpan(text: ' 원 사용하셨습니다'),
                ]),
            maxLines: 1,
          ),
          SizedBox(height: kDefaultPadding),
          Container(
            height: 200,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            width: widget.size.width,
            child: BarChart(mainBarData()),
          )
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    double width = 30,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y * 1.1 : y,
          colors:
              isTouched ? [Colors.deepPurpleAccent.shade700] : [kThemeColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: widget.eventReport.costPerReward.reduce(max).toDouble() * 1.1,
            colors: [Colors.transparent],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(
      5,
      (i) => makeGroupData(i, widget.eventReport.costPerReward[i].toDouble(),
          isTouched: i == touchedIndex));

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String rewardName;
              switch (group.x.toInt()) {
                case 0:
                  rewardName = '콜라';
                  break;
                case 1:
                  rewardName = '피자';

                  break;
                case 2:
                  rewardName = '치킨';

                  break;
                case 3:
                  rewardName = '배고파';

                  break;
                case 4:
                  rewardName = '햄버거';

                  break;

                default:
                  throw Error();
              }
              return BarTooltipItem(
                rewardName + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '${numberDisplay(rod.y.toInt())}원',
                    style: TextStyle(
                      color: Colors.amberAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return '1단계';
              case 1:
                return '2단계';
              case 2:
                return '3단계';
              case 3:
                return '4단계';
              case 4:
                return '5단계';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}
