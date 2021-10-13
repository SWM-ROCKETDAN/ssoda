class EventRank {
  final String storeName;
  final String storeLogo;
  final String eventTitle;
  final String eventImage;
  final double guestPrice;
  final int joinCount;
  final int likeCount;

  EventRank(
      {required this.storeName,
      required this.storeLogo,
      required this.eventTitle,
      required this.eventImage,
      required this.guestPrice,
      required this.joinCount,
      required this.likeCount});
}
