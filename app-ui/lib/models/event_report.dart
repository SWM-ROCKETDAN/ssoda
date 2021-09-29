import 'package:hashchecker/models/event_report_item.dart';
import 'package:hashchecker/models/event_report_per_period.dart';

import 'event_report_total_sum.dart';

class EventReport {
  final EventReportItem eventReportItem;
  final EventReportPerPeriod eventDayReport;
  final EventReportPerPeriod eventWeekReport;
  final EventReportPerPeriod eventMonthReport;
  final EventReportTotalSum eventTotalReport;

  EventReport(
      {required this.eventReportItem,
      required this.eventDayReport,
      required this.eventWeekReport,
      required this.eventMonthReport,
      required this.eventTotalReport});
}
