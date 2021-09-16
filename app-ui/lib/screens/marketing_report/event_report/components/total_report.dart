import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../models/event_report_per_period.dart';
import './total_report/expenditure_report_total.dart';
import './total_report/exposure_report_total.dart';
import './total_report/participation_report_total.dart';

class TotalReport extends StatelessWidget {
  const TotalReport({
    Key? key,
    required this.size,
    required this.eventReport,
  }) : super(key: key);

  final Size size;
  final EventReport eventReport;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: kDefaultPadding),
          ExposureReportTotal(size: size, eventReport: eventReport),
          ParticipationReportTotal(size: size, eventReport: eventReport),
          ExpenditureReportTotal(size: size, eventReport: eventReport),
        ],
      ),
    );
  }
}
