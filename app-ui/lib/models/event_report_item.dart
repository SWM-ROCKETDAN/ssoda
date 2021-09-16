import 'package:hashchecker/screens/create_event/create_event_step/components/event_template.dart';

import 'event.dart';

class EventReportItem {
  final String title;
  final String thumbnail;
  final int? guestPrice;
  final int? joinCount;
  final int? likeCount;
  final List<String>? rewardNameList;
  final EventStatus status;

  EventReportItem(
      {required this.thumbnail,
      required this.status,
      required this.title,
      this.guestPrice,
      this.joinCount,
      this.likeCount,
      this.rewardNameList});

  factory EventReportItem.fromJson(Map<String, dynamic> json) {
    return EventReportItem(
        thumbnail: json['imagePath'],
        status: EventStatus.values[json['status']],
        title: json['title']);
  }
}
