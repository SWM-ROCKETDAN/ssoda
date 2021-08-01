import 'package:flutter/material.dart';
import 'package:hashchecker_web/models/event.dart';
import 'package:hashchecker_web/models/period.dart';
import 'package:hashchecker_web/models/reward.dart';
import 'package:hashchecker_web/models/reward_category.dart';
import 'package:hashchecker_web/models/template.dart';
import 'package:hashchecker_web/screens/event_join/event_join_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Event myEvent = Event(
      title: "우리가게 SNS 해시태그 이벤트",
      rewardList: <Reward>[
        Reward(
            name: "콜라",
            imgPath: 'assets/images/sample/rewardImage1.jpg',
            price: 1234,
            count: 1234,
            category: RewardCategory.DRINK),
        Reward(
            name: "치킨",
            imgPath: 'assets/images/sample/rewardImage2.jpg',
            price: 1234,
            count: 1234,
            category: RewardCategory.DRINK),
        Reward(
            name: "피자",
            imgPath: 'assets/images/sample/rewardImage3.jpg',
            price: 1234,
            count: 1234,
            category: RewardCategory.DRINK),
      ],
      hashtagList: <String>["우리가게", '샌드위치', '강남맛집', '이벤트'],
      period: Period(DateTime.now(), DateTime.now(), 0),
      images: <String>[
        'assets/images/sample/eventImage1.jpg',
        'assets/images/sample/eventImage2.jpg',
        'assets/images/sample/eventImage3.jpg'
      ],
      requireList: <bool>[
        true,
        false,
        true,
        false,
        true,
        false,
        true,
        false,
        true,
        false,
      ],
      template: Template(0));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hashchecker WEB',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.white),
      home: EventJoinScreen(
        event: myEvent,
      ),
    );
  }
}
