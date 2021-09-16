import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../models/event_report_per_period.dart';
import './monthly_report/expenditure_report_monthly.dart';
import './monthly_report/exposure_report_monthly.dart';
import './monthly_report/participation_report_monthly.dart';

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
