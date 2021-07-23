import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_report.dart';

import 'components/custom_appbar_deprecated.dart';
import 'components/expenditure_report.dart';
import 'components/exposure_report.dart';
import 'components/header_background_deprecated.dart';
import 'components/participation_report.dart';
import 'components/report_title_deprecated.dart';

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
        joinCount: 384,
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

    return Scaffold(
      body: Stack(
        children: [
          HeaderBackground(size: size),
          Container(
              padding: const EdgeInsets.only(top: 30),
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(),
                  SizedBox(
                    height: kDefaultPadding * 2,
                  ),
                  ReportTitle(eventReport: eventReport),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ParticipationReport(
                              size: size, eventReport: eventReport),
                          ExposureReport(size: size, eventReport: eventReport),
                          ExpenditureReport(
                              size: size, eventReport: eventReport),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
