import 'reward.dart';
import 'period.dart';
import 'template.dart';

enum Status { WAITING, PROCEEDING, ENDED }

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
}
