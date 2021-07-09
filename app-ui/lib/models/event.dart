import 'reward.dart';
import 'period.dart';
import 'template.dart';

class Event {
  final String title;
  final List<Reward?> rewardList;
  final List<String> hashtagList;
  final Period period;
  final List<String> images;
  final List<bool> requireList;
  final Template template;

  String get getTitle => title;
  List<Reward?> get getRewardList => rewardList;
  List<String> get getHashtagList => hashtagList;
  Period get getPeriod => period;
  List<String> get getImages => images;
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
