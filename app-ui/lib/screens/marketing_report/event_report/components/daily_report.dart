import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../models/event_report_per_period.dart';
import './daily_report/expenditure_report_daily.dart';
import './daily_report/exposure_report_daily.dart';
import './daily_report/participation_report_daily.dart';

class DailyReport extends StatelessWidget {
  const DailyReport({
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
        ExposureReportDaily(size: size, eventReport: eventReport),
        ParticipationReportDaily(size: size, eventReport: eventReport),
        ExpenditureReportDaily(size: size, eventReport: eventReport),
      ]),
    );
  }
}
