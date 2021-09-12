import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/event_report_item.dart';
import 'package:hashchecker/models/store_report_overview.dart';
import 'package:hashchecker/screens/marketing_report/store_report/components/event_report_card.dart';
import 'package:number_display/number_display.dart';
import 'components/report_overview.dart';

class StoreReportScreen extends StatefulWidget {
  const StoreReportScreen({Key? key}) : super(key: key);

  @override
  _StoreReportScreenState createState() => _StoreReportScreenState();
}

class _StoreReportScreenState extends State<StoreReportScreen> {
  final eventSortDropdownItemList = [
    '최신 등록 순',
    '높은 객단가 순',
    '낮은 객단가 순',
    '높은 참가자 순',
    '낮은 참가자 순',
    '높은 좋아요 순',
    '낮은 좋아요 순'
  ];

  String dropdownValue = '최신 등록 순';

  final numberDisplay = createDisplay();

  late List<int> eventIdList; // 추후 이벤트 별 보고서를 이벤트 id 를 통해 요청해야함
  late List<EventReportItem> eventReportList;
  late StoreReportOverview storeReportOverview;

  @override
  void initState() {
    super.initState();
    eventReportList = [
      EventReportItem(
          eventName: '우리가게 SNS 해시태그 이벤트',
          guestPrice: 7,
          joinCount: 839,
          likeCount: 12341,
          rewardNameList: ['콜라', '샌드위치', '3000원 쿠폰'],
          thumbnail: 'assets/images/event1.jpg',
          status: EventStatus.PROCEEDING),
      EventReportItem(
          eventName: '우리가게 7월 한정 쿠폰 이벤트',
          guestPrice: 10,
          joinCount: 423,
          likeCount: 7318,
          rewardNameList: ['5000원 쿠폰', '10000원 쿠폰'],
          thumbnail: 'assets/images/event2.jpg',
          status: EventStatus.ENDED),
    ];

    storeReportOverview = StoreReportOverview(
        guestPrice: 7.13, joinCount: 62345, likeCount: 8201543);

    eventIdList = [-1, -1];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '리포트 요약',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: kDefaultFontColor),
              ),
              SizedBox(height: kDefaultPadding / 5 * 6),
              ReportOverview(
                  size: size, storeReportOverview: storeReportOverview),
              SizedBox(height: kDefaultPadding / 3 * 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '이벤트 별 리포트',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: kDefaultFontColor),
                  ),
                  DropdownButton(
                      dropdownColor: kScaffoldBackgroundColor.withOpacity(0.9),
                      value: dropdownValue,
                      icon: const Icon(
                        Icons.sort,
                        color: kDefaultFontColor,
                        size: 20,
                      ),
                      iconSize: 24,
                      elevation: 0,
                      style: TextStyle(
                        color: kDefaultFontColor,
                        fontSize: 13,
                      ),
                      underline: Container(
                        height: 0,
                        color: kDefaultFontColor,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: eventSortDropdownItemList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: SizedBox(
                              width: 85,
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontSize: 13, color: kDefaultFontColor),
                                textAlign: TextAlign.center,
                              )),
                        );
                      }).toList())
                ],
              ),
              SizedBox(height: kDefaultPadding / 3 * 1),
              AnimationLimiter(
                  child: Column(
                children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 500),
                    childAnimationBuilder: (widget) => SlideAnimation(
                          horizontalOffset: 100,
                          child: FadeInAnimation(
                            child: widget,
                          ),
                        ),
                    children: List.generate(
                      eventReportList.length,
                      (index) => EventReportCard(
                          eventId: eventIdList[index],
                          index: index,
                          size: size,
                          eventReportList: eventReportList,
                          numberDisplay: numberDisplay),
                    )),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
