import 'event.dart';

class EventListItem {
  final int id;
  final String title;
  final String startDate;
  final String finishDate;
  final String thumbnail;
  final EventStatus status;

  EventListItem(
      {required this.id,
      required this.title,
      required this.startDate,
      required this.finishDate,
      required this.thumbnail,
      required this.status});
}
