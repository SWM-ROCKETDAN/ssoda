import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../models/event_report_per_period.dart';
import './total_report/expenditure_report_total.dart';
import './total_report/exposure_report_total.dart';
import './total_report/participation_report_total.dart';

class TotalReport extends StatelessWidget {
  const TotalReport({
    Key? key,
    required this.eventReport,
  }) : super(key: key);

  final EventReportPerPeriod eventReport;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: kDefaultPadding),
          ExposureReportTotal(eventReport: eventReport),
          ParticipationReportTotal(eventReport: eventReport),
          ExpenditureReportTotal(eventReport: eventReport),
        ],
      ),
    );
  }
}
