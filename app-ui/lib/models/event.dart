import 'package:hashchecker/models/requires.dart';

import 'reward.dart';
import 'period.dart';
import 'template.dart';
import 'package:intl/intl.dart';

enum EventStatus { WAITING, PROCEEDING, ENDED }

class Event {
  String title;
  List<Reward?> rewardList;
  Period period;
  List<String?> images;
  List<String> hashtagList;
  List<bool> requireList;
  Template template;

  Event(
      {required this.title,
      required this.rewardList,
      required this.hashtagList,
      required this.period,
      required this.images,
      required this.requireList,
      required this.template});

  Map<String, dynamic> toJson() => {
        'title': title,
        'startDate': DateFormat('yyyy-MM-ddTHH:mm:ss').format(period.startDate),
        'finishDate': period.finishDate == null
            ? null
            : DateFormat('yyyy-MM-ddTHH:mm:ss').format(period.finishDate!),
        'images': images,
        'rewards': rewardList,
        'hashtags': hashtagList,
        'requirements': requireList,
        'template': template.id
      };

  factory Event.fromJson(Map<String, dynamic> json) {
    var hashtagsFromJson = json['hashtags'];
    var imagesFromJson = json['images'];
    var requiresFromJson = json['requirements'];
    var rewardsFromJson = json['rewards'] as List;

    List<String> hashtagList = hashtagsFromJson.cast<String>();
    List<String?> images = imagesFromJson.cast<String?>();
    List<bool> requireList = requiresFromJson.cast<bool>();
    List<Reward?> rewardList =
        rewardsFromJson.map((i) => Reward.fromJson(i)).toList();

    return Event(
        title: json['title'],
        rewardList: rewardList,
        hashtagList: hashtagList,
        period: Period(
            DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json['startDate']),
            json['finishDate'] == null
                ? null
                : DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json['finishDate']),
            null),
        images: images,
        requireList: requireList,
        template: Template(json['template']));
  }
}
