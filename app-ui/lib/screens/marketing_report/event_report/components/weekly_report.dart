import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../models/event_report.dart';
import 'expenditure_report_weekly.dart';
import 'exposure_report_weekly.dart';
import 'participation_report_weekly.dart';

class WeeklyReport extends StatelessWidget {
  const WeeklyReport({
    Key? key,
    required this.size,
    required this.eventReport,
  }) : super(key: key);

  final Size size;
  final EventReport eventReport;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(height: kDefaultPadding),
        ExposureReportWeekly(size: size, eventReport: eventReport),
        ParticipationReportWeekly(size: size, eventReport: eventReport),
        ExpenditureReportWeekly(size: size, eventReport: eventReport),
      ]),
    );
  }
}
