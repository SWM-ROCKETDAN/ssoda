import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_report.dart';
import 'package:number_display/number_display.dart';
import 'package:hashchecker/widgets/number_slider/number_slide_animation_widget.dart';

import 'delta_data.dart';

class ExposureReportDaily extends StatefulWidget {
  ExposureReportDaily({Key? key, required this.size, required this.eventReport})
      : super(key: key);

  final Size size;
  final EventReport eventReport;
  final numberDisplay = createDisplay();

  @override
  _ExposureReportDailyState createState() => _ExposureReportDailyState();
}

class _ExposureReportDailyState extends State<ExposureReportDaily> {
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
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 5,
          blurRadius: 20,
          offset: Offset(0, 0), // changes position of shadow
        ),
      ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('오늘',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
            DeltaData(value: 57, icon: Icons.arrow_drop_down, color: Colors.red)
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
                  number: (widget.eventReport.exposeCount ~/ 85).toString(),
                  duration: kDefaultNumberSliderDuration,
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
              )
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
                        number: '7',
                        duration: kDefaultNumberSliderDuration,
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
                              return '월';
                            case 1:
                              return '화';
                            case 2:
                              return '수';
                            case 3:
                              return '목';
                            case 4:
                              return '금';
                            case 5:
                              return '토';
                            case 6:
                              return '일';
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
                          FlSpot(0, 4),
                          FlSpot(1, 6),
                          FlSpot(2, 2),
                          FlSpot(3, 3),
                          FlSpot(4, 1),
                          FlSpot(5, 5),
                          FlSpot(6, 2),
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
