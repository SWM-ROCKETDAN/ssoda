import 'package:hashchecker/models/event_report_item.dart';
import 'package:hashchecker/models/event_report_per_period.dart';

class EventReport {
  final EventReportItem eventReportItem;
  final EventReportPerPeriod eventDayReport;
  final EventReportPerPeriod eventWeekReport;
  final EventReportPerPeriod eventMonthReport;

  EventReport(
      {required this.eventReportItem,
      required this.eventDayReport,
      required this.eventWeekReport,
      required this.eventMonthReport});

  factory EventReport.fromJson(Map<String, dynamic> json) {
    return EventReport(
      eventReportItem: json['event'],
      eventDayReport: json['report']['day'],
      eventWeekReport: json['report']['week'],
      eventMonthReport: json['report']['month'],
    );
  }
}
