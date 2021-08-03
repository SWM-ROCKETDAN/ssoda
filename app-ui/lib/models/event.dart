import 'reward.dart';
import 'period.dart';
import 'template.dart';
import 'package:intl/intl.dart';

enum EventStatus { WAITING, PROCEEDING, ENDED }

class Event {
  final String title;
  final List<Reward?> rewardList;
  final Period period;
  final List<String?> images;
  final List<String> hashtagList;
  final List<bool> requireList;
  final Template template;

  String get getTitle => title;
  List<Reward?> get getRewardList => rewardList;
  List<String> get getHashtagList => hashtagList;
  Period get getPeriod => period;
  List<String?> get getImages => images;
  List<bool> get getRequireList => requireList;
  Template get getTemplate => template;

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

  Event.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        rewardList = json['rewards'],
        period = Period(
            DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json['startDate']),
            json['finishDate'] == null
                ? null
                : DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json['finishDate'])),
        images = json['images'],
        hashtagList = json['hashtags'],
        requireList = json['requirements'],
        template = Template(json['template']);
}
