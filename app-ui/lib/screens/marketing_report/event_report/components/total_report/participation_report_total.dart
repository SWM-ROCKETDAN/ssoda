import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_report_per_period.dart';
import 'package:number_display/number_display.dart';
import 'package:hashchecker/widgets/number_slider/number_slide_animation_widget.dart';

import '../delta_data.dart';
import '../report_design.dart';

class ParticipationReportTotal extends StatefulWidget {
  ParticipationReportTotal({Key? key, required this.eventReport})
      : super(key: key);

  final EventReportPerPeriod eventReport;

  @override
  _ParticipationReportTotalState createState() =>
      _ParticipationReportTotalState();
}

class _ParticipationReportTotalState extends State<ParticipationReportTotal> {
  final numberDisplay = createDisplay();
  late int publicPostSum;
  late int deletedPostSum;
  late int participateSum;
  late int commentSum;
  late int likeSum;
  int? touchedIndex;

  @override
  void initState() {
    super.initState();
    publicPostSum = widget.eventReport.publicPostCount.reduce((a, b) => a + b);

    deletedPostSum =
        widget.eventReport.deletedPostCount.reduce((a, b) => a + b);
    participateSum =
        widget.eventReport.participateCount.reduce((a, b) => a + b);
    commentSum = widget.eventReport.commentCount.reduce((a, b) => a + b);
    likeSum = widget.eventReport.likeCount.reduce((a, b) => a + b);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(20),
      width: size.width,
      margin: const EdgeInsets.fromLTRB(5, 5, 5, 15),
      decoration: reportBoxDecoration,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('오늘',
                style: TextStyle(
                    color: kDefaultFontColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 5.0,
              children: [
                Text('총 ',
                    style: TextStyle(
                        color: kDefaultFontColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                NumberSlideAnimation(
                    number: participateSum.toString(),
                    duration: kDefaultNumberSliderDuration,
                    curve: Curves.easeOut,
                    textStyle: TextStyle(
                        color: kThemeColor,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                    format: NumberFormatMode.comma),
                Text(
                  ' 명이 ',
                  style: TextStyle(
                      color: kDefaultFontColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Text(
                  '참여했습니다',
                  style: TextStyle(
                      color: kDefaultFontColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: kDefaultPadding * 2),
            SizedBox(
              height: 140,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Stack(children: [
                            Center(
                              child: PieChart(PieChartData(
                                  pieTouchData: PieTouchData(
                                      touchCallback: (pieTouchResponse) {
                                    setState(() {
                                      final desiredTouch =
                                          pieTouchResponse.touchInput
                                                  is! PointerExitEvent &&
                                              pieTouchResponse.touchInput
                                                  is! PointerUpEvent;
                                      if (desiredTouch &&
                                          pieTouchResponse.touchedSection !=
                                              null) {
                                        touchedIndex = pieTouchResponse
                                            .touchedSection!
                                            .touchedSectionIndex;
                                      } else {
                                        touchedIndex = -1;
                                      }
                                    });
                                  }),
                                  centerSpaceRadius: 30,
                                  sectionsSpace: 0,
                                  sections: [
                                    PieChartSectionData(
                                        radius: touchedIndex == 0 ? 40 : 30,
                                        title: publicPostSum.toString(),
                                        value: publicPostSum.toDouble(),
                                        color: kThemeColor,
                                        titleStyle: TextStyle(
                                            fontSize:
                                                touchedIndex == 0 ? 16 : 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    PieChartSectionData(
                                        radius: touchedIndex == 1 ? 40 : 30,
                                        title: deletedPostSum.toString(),
                                        value: deletedPostSum.toDouble(),
                                        color: Colors.grey.shade300,
                                        titleStyle: TextStyle(
                                            fontSize:
                                                touchedIndex == 1 ? 16 : 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black45))
                                  ])),
                            ),
                            Center(
                                child: Text(
                                    publicPostSum + deletedPostSum == 0
                                        ? '0%'
                                        : '${(publicPostSum / (publicPostSum + deletedPostSum) * 100).toStringAsFixed(1)}%',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: kThemeColor,
                                        fontWeight: FontWeight.bold))),
                          ]),
                        ),
                        Text('게시글 유지 비율',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kDefaultFontColor)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(height: kDefaultPadding),
                              Row(children: [
                                Icon(
                                  Icons.favorite,
                                  color: Colors.pink,
                                  size: 28,
                                ),
                                SizedBox(width: kDefaultPadding / 3),
                                NumberSlideAnimation(
                                  number: likeSum.toString(),
                                  duration: kDefaultNumberSliderDuration,
                                  curve: Curves.easeOut,
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.pink,
                                      fontWeight: FontWeight.bold),
                                  format: NumberFormatMode.comma,
                                ),
                                Text(' 개',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.pink,
                                        fontWeight: FontWeight.bold)),
                              ]),
                              SizedBox(height: kDefaultPadding * 2 / 3),
                              Row(children: [
                                Icon(
                                  Icons.chat_bubble,
                                  color: Color(0xFF1fbf89),
                                  size: 28,
                                ),
                                SizedBox(width: kDefaultPadding / 3),
                                NumberSlideAnimation(
                                  number: commentSum.toString(),
                                  duration: kDefaultNumberSliderDuration,
                                  curve: Curves.easeOut,
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF1fbf89),
                                      fontWeight: FontWeight.bold),
                                  format: NumberFormatMode.comma,
                                ),
                                Text(' 개',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF1fbf89),
                                        fontWeight: FontWeight.bold))
                              ])
                            ],
                          ),
                        ),
                        SizedBox(height: kDefaultPadding),
                        Text('누적 좋아요&덧글',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kDefaultFontColor)),
                      ],
                    ),
                  ]),
            ),
          ]),
    );
  }
}
