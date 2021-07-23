import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_report.dart';

import 'components/expenditure_report.dart';
import 'components/exposure_report.dart';
import 'components/participation_report.dart';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String _dropdownValue = "전체 누적";

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
                            value: _dropdownValue,
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
                                _dropdownValue = newValue!;
                              });
                            },
                            items: <String>['어제 대비', '전 주 대비', '요일 별', '전체 누적']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              );
                            }).toList(),
                          ),
                          ParticipationReport(
                              size: size, eventReport: eventReport),
                          ExposureReport(size: size, eventReport: eventReport),
                          ExpenditureReport(
                              size: size, eventReport: eventReport),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}
