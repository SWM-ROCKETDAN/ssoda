import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_report.dart';
import 'package:number_display/number_display.dart';

class ParticipationReport extends StatelessWidget {
  ParticipationReport({
    Key? key,
    required this.size,
    required this.eventReport,
  }) : super(key: key);

  final Size size;
  final EventReport eventReport;
  final numberDisplay = createDisplay();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: size.width,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          text: numberDisplay(eventReport.joinCount),
                          style: TextStyle(color: kThemeColor, fontSize: 32)),
                      TextSpan(text: ' 명이 참여했습니다')
                    ]),
                maxLines: 1),
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
                                  centerSpaceRadius: 30,
                                  sectionsSpace: 0,
                                  sections: [
                                    PieChartSectionData(
                                        radius: 30,
                                        title: eventReport.livePostCount
                                            .toString(),
                                        value: eventReport.livePostCount
                                            .toDouble(),
                                        color: kThemeColor,
                                        titleStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                    PieChartSectionData(
                                        radius: 30,
                                        title: eventReport.deadPostCount
                                            .toString(),
                                        value: eventReport.deadPostCount
                                            .toDouble(),
                                        color: Colors.grey.shade300,
                                        titleStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black45))
                                  ])),
                            ),
                            Center(
                                child: Text(
                                    '${(eventReport.livePostCount / (eventReport.livePostCount + eventReport.deadPostCount) * 100).toStringAsFixed(1)}%',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: kThemeColor,
                                        fontWeight: FontWeight.bold))),
                          ]),
                        ),
                        Text('게시글 유지 비율'),
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
                                  color: Colors.pinkAccent,
                                  size: 28,
                                ),
                                Text(
                                    '  ${numberDisplay(eventReport.likeCount)}개',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.pinkAccent,
                                        fontWeight: FontWeight.bold)),
                              ]),
                              SizedBox(height: kDefaultPadding * 2 / 3),
                              Row(children: [
                                Icon(
                                  Icons.chat_bubble,
                                  color: Color(0xFF22d095),
                                  size: 28,
                                ),
                                Text(
                                    '  ${numberDisplay(eventReport.commentCount)}개',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF22d095),
                                        fontWeight: FontWeight.bold))
                              ])
                            ],
                          ),
                        ),
                        SizedBox(height: kDefaultPadding),
                        Text('누적 좋아요&덧글'),
                      ],
                    ),
                  ]),
            ),
          ]),
    );
  }
}
