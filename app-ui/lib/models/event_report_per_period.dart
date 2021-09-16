import 'package:hashchecker/models/event.dart';

class EventReportPerPeriod {
  final List<int> exposureCount;
  final List<int> participateCount;
  final List<int> publicPostCount;
  final List<int> privatePostCount;
  final List<int> deletedPostCount;
  final List<int> likeCount;
  final List<int> commentCount;
  final List<int> expenditureCount;
  final List<int> levelExpenditure;

  EventReportPerPeriod(
      {required this.exposureCount,
      required this.participateCount,
      required this.publicPostCount,
      required this.privatePostCount,
      required this.deletedPostCount,
      required this.likeCount,
      required this.commentCount,
      required this.expenditureCount,
      required this.levelExpenditure});

  factory EventReportPerPeriod.fromJson(Map<String, dynamic> json) {
    return EventReportPerPeriod(
        exposureCount: json['exposure_count'],
        participateCount: json['participate_count'],
        publicPostCount: json['public_post_count'],
        privatePostCount: json['private_post_count'],
        deletedPostCount: json['deleted_post_count'],
        likeCount: json['like_count'],
        commentCount: json['comment_count'],
        expenditureCount: json['expenditure_count'],
        levelExpenditure: json['level_expenditure']);
  }
}
