import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_report.dart';

import 'components/expenditure_report_total.dart';
import 'components/expenditure_report_daily.dart';
import 'components/expenditure_report_monthly.dart';
import 'components/expenditure_report_weekly.dart';
import 'components/exposure_report_total.dart';
import 'components/exposure_report_daily.dart';
import 'components/exposure_report_monthly.dart';
import 'components/exposure_report_weekly.dart';
import 'components/participation_report_total.dart';
import 'components/participation_report_daily.dart';
import 'components/participation_report_monthly.dart';
import 'components/participation_report_weekly.dart';

class EventReportScreen extends StatefulWidget {
  const EventReportScreen({Key? key}) : super(key: key);

  @override
  _EventReportScreenState createState() => _EventReportScreenState();
}

class _EventReportScreenState extends State<EventReportScreen> {
  late EventReport eventReport;

  @override
  void initState() {
    super.initState();
    eventReport = EventReport(
        eventName: '우리가게 SNS 해시태그 이벤트',
        joinCount: 4379,
        likeCount: 7423,
        livePostCount: 257,
        deadPostCount: 127,
        commentCount: 2184,
        exposeCount: 51824,
        followerSum: 51623,
        followerAvg: 186,
        costSum: 372100,
        costPerReward: [50000, 65000, 50000, 75000, 90000]);
  }

  String dropdownValue = "총 합";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, ext) => [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    actions: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 20, 15),
                        child: Icon(Icons.close),
                      )
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: const EdgeInsets.fromLTRB(20, 10, 0, 15),
                      title: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              eventReport.eventName,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                              maxLines: 1,
                            ),
                            AutoSizeText(
                              '마케팅 성과 보고서',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              maxLines: 1,
                            )
                          ]),
                      background: Image.asset(
                        'assets/images/event_report/graph.png',
                        fit: BoxFit.cover,
                        color: Colors.indigoAccent.shade200,
                      ),
                    ),
                    backgroundColor: kThemeColor,
                    foregroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0))),
                    expandedHeight: size.height * 0.3,
                    pinned: true,
                  ),
                ],
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(
                              Icons.timeline_outlined,
                              color: kThemeColor,
                            ),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: kThemeColor),
                            underline: Container(
                              height: 2,
                              color: kThemeColor,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>['일 별', '주 별', '월 별', '총 합']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: SizedBox(
                                  width: 50,
                                  child: Text(
                                    value,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          if (dropdownValue == '일 별') ...[
                            ExposureReportDaily(
                                size: size,
                                eventReport: eventReport,
                                period: dropdownValue),
                            ParticipationReportDaily(
                                size: size,
                                eventReport: eventReport,
                                period: dropdownValue),
                            ExpenditureReportDaily(
                                size: size,
                                eventReport: eventReport,
                                period: dropdownValue),
                          ],
                          if (dropdownValue == '주 별') ...[
                            ExposureReportWeekly(
                                size: size,
                                eventReport: eventReport,
                                period: dropdownValue),
                            ParticipationReportWeekly(
                                size: size,
                                eventReport: eventReport,
                                period: dropdownValue),
                            ExpenditureReportWeekly(
                                size: size,
                                eventReport: eventReport,
                                period: dropdownValue),
                          ],
                          if (dropdownValue == '월 별') ...[
                            ExposureReportMonthly(
                                size: size,
                                eventReport: eventReport,
                                period: dropdownValue),
                            ParticipationReportMonthly(
                                size: size,
                                eventReport: eventReport,
                                period: dropdownValue),
                            ExpenditureReportMonthly(
                                size: size,
                                eventReport: eventReport,
                                period: dropdownValue),
                          ],
                          if (dropdownValue == '총 합') ...[
                            ExposureReportTotal(
                                size: size,
                                eventReport: eventReport,
                                period: dropdownValue),
                            ParticipationReportTotal(
                                size: size,
                                eventReport: eventReport,
                                period: dropdownValue),
                            ExpenditureReportTotal(
                                size: size,
                                eventReport: eventReport,
                                period: dropdownValue),
                          ]
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}
