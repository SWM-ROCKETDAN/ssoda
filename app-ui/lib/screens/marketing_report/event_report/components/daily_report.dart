import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_report_per_period.dart';

import 'expenditure_report.dart';
import 'exposure_report.dart';
import 'participate_report.dart';

class DailyReport extends StatelessWidget {
  const DailyReport({
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
