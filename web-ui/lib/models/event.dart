import 'package:hashchecker_web/models/reward_category.dart';

import 'reward.dart';
import 'period.dart';
import 'template.dart';
import 'package:intl/intl.dart';

enum EventStatus { WAITING, PROCEEDING, ENDED }

class Event {
  final String title;
  final Period period;
  final List<String?> images;
  final List<String> hashtagList;
  final List<bool> requireList;
  final Template template;
  final EventStatus status;
  final int storeId;

  Event(
      {required this.title,
      required this.hashtagList,
      required this.period,
      required this.images,
      required this.requireList,
      required this.template,
      required this.status,
      required this.storeId});

  factory Event.fromJson(Map<String, dynamic> json) {
    var hashtagsFromJson = json['hashtags'];
    var imagesFromJson = json['images'];
    var requiresFromJson = json['requirements'];

    List<String> hashtagList = hashtagsFromJson.cast<String>();
    List<String?> images = imagesFromJson.cast<String?>();
    List<bool> requireList = requiresFromJson.cast<bool>();

    return Event(
        title: json['title'],
        hashtagList: hashtagList,
        period: Period(
            DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json['startDate']),
            json['finishDate'] == null
                ? null
                : DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json['finishDate'])),
        images: images,
        requireList: requireList,
        status: EventStatus.values[json['status']],
        storeId: json['store_id'],
        template: Template(json['template']));
  }
}
