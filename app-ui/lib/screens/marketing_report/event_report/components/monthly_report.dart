import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../models/event_report.dart';
import 'expenditure_report_monthly.dart';
import 'exposure_report_monthly.dart';
import 'participation_report_monthly.dart';

class MonthlyReport extends StatelessWidget {
  const MonthlyReport({
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
        ExposureReportMonthly(size: size, eventReport: eventReport),
        ParticipationReportMonthly(size: size, eventReport: eventReport),
        ExpenditureReportMonthly(size: size, eventReport: eventReport),
      ]),
    );
  }
}
