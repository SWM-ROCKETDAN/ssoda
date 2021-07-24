import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_report.dart';

class ReportTitle extends StatelessWidget {
  const ReportTitle({
    Key? key,
    required this.eventReport,
  }) : super(key: key);

  final EventReport eventReport;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(eventReport.eventName,
          style: TextStyle(color: Colors.white, fontSize: 20)),
      SizedBox(height: kDefaultPadding / 3),
      Text('마케팅 성과 보고서',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28))
    ]);
  }
}
