import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/event_list_item.dart';
import 'package:hashchecker/models/period.dart';
import 'package:hashchecker/models/reward.dart';
import 'package:hashchecker/models/reward_category.dart';
import 'package:hashchecker/models/template.dart';
import 'package:hashchecker/screens/event_list/components/event_options_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'components/body.dart';

class EventDetailScreen extends StatefulWidget {
  final EventListItem eventListItem;
  const EventDetailScreen({Key? key, required this.eventListItem})
      : super(key: key);

  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  late Event event;
  @override
  void initState() {
    super.initState();
    // FutureBuilder 필요
    // eventListItem 의 eventId 를 통해 event 요청
    // reward 의 경우 eventId 를 통해 따로 요청
    event = Event(
        title: '우리가게 SNS 해시태그 이벤트',
        rewardList: [
          Reward(
              name: '콜라',
              imgPath: 'assets/images/reward1.jpg',
              price: 123,
              count: 123,
              level: 1,
              category: RewardCategory.DRINK),
          Reward(
              name: '샌드위치',
              imgPath: 'assets/images/reward2.jpg',
              price: 123,
              count: 123,
              level: 2,
              category: RewardCategory.FOOD),
          Reward(
              name: '런치 쿠폰',
              imgPath: 'assets/images/reward3.jpg',
              price: 123,
              count: 123,
              level: 3,
              category: RewardCategory.COUPON)
        ],
        hashtagList: ['우리가게', '강남', '맛집', '샌드위치', '이벤트'],
        period: Period(DateTime.now(), null, null),
        images: ['assets/images/event1.jpg', 'assets/images/event2.jpg'],
        requireList: [true, false, true, true, false, false],
        template: Template(0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kScaffoldBackgroundColor,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              color: kDefaultFontColor),
          actions: [
            IconButton(
                onPressed: () => showMaterialModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    expand: false,
                    context: context,
                    builder: (context) => EventOptionsModal(
                        eventId: widget.eventListItem.id,
                        eventStatus: widget.eventListItem.status,
                        isAlreadyInPreview: true)),
                icon: Icon(Icons.more_vert_rounded, color: kDefaultFontColor))
          ],
        ),
        body: Body(event: event));
  }
}
