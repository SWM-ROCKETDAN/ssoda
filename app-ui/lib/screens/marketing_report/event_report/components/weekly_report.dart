import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_report_per_period.dart';
import 'package:hashchecker/screens/marketing_report/event_report/components/participate_report.dart';

import 'expenditure_report.dart';
import 'exposure_report.dart';

class WeeklyReport extends StatelessWidget {
  const WeeklyReport({
    Key? key,
    required this.eventReport,
  }) : super(key: key);

  final EventReportPerPeriod eventReport;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(height: kDefaultPadding),
        ExposureReport(eventReport: eventReport),
        ParticipationReport(eventReport: eventReport),
        ExpenditureReport(eventReport: eventReport),
      ]),
    );
  }
}
