import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_report.dart';
import 'package:number_display/number_display.dart';
import 'package:hashchecker/widgets/number_slider/number_slide_animation_widget.dart';

import 'delta_data.dart';

class ExposureReportMonthly extends StatefulWidget {
  ExposureReportMonthly(
      {Key? key,
      required this.size,
      required this.eventReport,
      required this.period})
      : super(key: key);

  final Size size;
  final EventReport eventReport;
  final String period;
  final numberDisplay = createDisplay();

  @override
  _ExposureReportMonthlyState createState() => _ExposureReportMonthlyState();
}

class _ExposureReportMonthlyState extends State<ExposureReportMonthly> {
  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [
      const Color(0xff23b6e6),
      const Color(0xff02d39a),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      width: widget.size.width,
      margin: const EdgeInsets.fromLTRB(5, 5, 5, 15),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.green,
          offset: Offset(0, 0),
          blurRadius: 0.1,
          spreadRadius: 1,
        )
      ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('이번 달에',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
            DeltaData(
                value: 1287, icon: Icons.arrow_drop_up, color: Colors.green)
          ]),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 5.0,
            children: [
              Text('총 ',
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              NumberSlideAnimation(
                  number: (widget.eventReport.exposeCount ~/ 6).toString(),
                  duration: const Duration(seconds: 3),
                  curve: Curves.easeOut,
                  textStyle: TextStyle(
                      color: kThemeColor,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                  format: NumberFormatMode.comma),
              Text(
                ' 명에게 ',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                '노출되었습니다',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: kDefaultPadding),
          SizedBox(
            width: widget.size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_outline,
                  size: 48,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('1',
                        style: TextStyle(
                          color: kThemeColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        )),
                    Text('인 노출 당 ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    NumberSlideAnimation(
                        number: '12',
                        duration: const Duration(seconds: 3),
                        curve: Curves.easeOut,
                        textStyle: TextStyle(
                            color: kThemeColor,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                        format: NumberFormatMode.comma),
                    Text('원 사용',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14))
                  ],
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                Container(
                  width: widget.size.width * 0.7,
                  height: 150,
                  child: LineChart(LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.black12,
                          strokeWidth: 1,
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: Colors.black12,
                          strokeWidth: 1,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 14,
                        getTextStyles: (value) => const TextStyle(
                            color: Color(0xff68737d),
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                        getTitles: (value) {
                          switch (value.toInt()) {
                            case 0:
                              return '12월';
                            case 1:
                              return '1월';
                            case 2:
                              return '2월';
                            case 3:
                              return '3월';
                            case 4:
                              return '4월';
                            case 5:
                              return '5월';
                            case 5:
                              return '6월';
                            case 6:
                              return '7월';
                          }
                          return '';
                        },
                        margin: 8,
                      ),
                      leftTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (value) => const TextStyle(
                          color: Color(0xff67727d),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        getTitles: (value) {
                          switch (value.toInt()) {
                            case 1:
                              return '10k';
                            case 3:
                              return '30k';
                            case 5:
                              return '50k';
                          }
                          return '';
                        },
                        reservedSize: 14,
                        margin: 12,
                      ),
                    ),
                    borderData: FlBorderData(
                        show: true,
                        border: Border.all(
                            color: const Color(0xff37434d), width: 0)),
                    minX: 0,
                    maxX: 6,
                    minY: 0,
                    maxY: 6,
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(0, 3),
                          FlSpot(1, 5),
                          FlSpot(2, 1),
                          FlSpot(3, 2),
                          FlSpot(4, 6),
                          FlSpot(5, 3),
                          FlSpot(6, 5),
                        ],
                        isCurved: false,
                        colors: gradientColors,
                        barWidth: 5,
                        isStrokeCapRound: true,
                        dotData: FlDotData(
                          show: true,
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          colors: gradientColors
                              .map((color) => color.withOpacity(0.3))
                              .toList(),
                        ),
                      ),
                    ],
                  )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

TValue case2<TOptionType, TValue>(
  TOptionType selectedOption,
  Map<TOptionType, TValue> branches, [
  TValue? defaultValue,
]) {
  if (!branches.containsKey(selectedOption)) {
    return defaultValue!;
  }

  return branches[selectedOption]!;
}
