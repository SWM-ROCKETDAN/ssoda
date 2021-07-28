import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/event_report_item.dart';
import 'package:hashchecker/models/store_report_overview.dart';
import 'package:hashchecker/widgets/number_slider/number_slide_animation_widget.dart';
import 'package:number_display/number_display.dart';

class StoreReportScreen extends StatefulWidget {
  const StoreReportScreen({Key? key}) : super(key: key);

  @override
  _StoreReportScreenState createState() => _StoreReportScreenState();
}

class _StoreReportScreenState extends State<StoreReportScreen> {
  String dropdownValue = '최신 등록 순';
  final numberDisplay = createDisplay();

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
          guestPrice: 6,
          joinCount: 423,
          likeCount: 7318,
          rewardNameList: ['5000원 쿠폰', '10000원 쿠폰'],
          thumbnail: 'assets/images/event2.jpg',
          status: EventStatus.ENDED),
    ];

    storeReportOverview =
        StoreReportOverview(guestPrice: 7, joinCount: 72345, likeCount: 701543);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, ext) => [
          SliverAppBar(
            automaticallyImplyLeading: false,
            actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 20, 15),
                child: Icon(Icons.close),
              )
            ],
            flexibleSpace: ClipRRect(
                child: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.fromLTRB(20, 10, 0, 15),
                  title: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '우리가게 마케팅 보고서',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 3),
                        Text(
                          '${eventReportList.length}개의 이벤트가 진행 중',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 10),
                        ),
                        SizedBox(height: kDefaultPadding / 4)
                      ]),
                  background: Stack(children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'assets/images/store1.jpg',
                          ),
                        ),
                      ),
                      height: size.height * 0.4,
                    ),
                    Container(
                      height: size.height * 0.4,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          gradient: LinearGradient(
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              colors: [
                                Colors.grey.withOpacity(0.0),
                                Colors.black.withOpacity(0.8),
                              ],
                              stops: [
                                0.0,
                                1.0
                              ])),
                    )
                  ]),
                ),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(0))),
            backgroundColor: kThemeColor,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(0))),
            expandedHeight: size.height * 0.3,
            pinned: true,
          ),
        ],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '개요',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                SizedBox(height: kDefaultPadding),
                Container(
                    padding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.attach_money,
                              size: 40,
                            ),
                            SizedBox(width: 10),
                            Row(children: [
                              Text('1',
                                  style: TextStyle(
                                    color: kThemeColor,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text('인 노출 당 ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              NumberSlideAnimation(
                                  number:
                                      storeReportOverview.guestPrice.toString(),
                                  duration: const Duration(seconds: 3),
                                  curve: Curves.easeOut,
                                  textStyle: TextStyle(
                                      color: kThemeColor,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                  format: NumberFormatMode.comma),
                              Text('원 사용',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14))
                            ]),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.group_outlined,
                              size: 40,
                            ),
                            SizedBox(width: 10),
                            Row(children: [
                              Text('총 ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              NumberSlideAnimation(
                                  number:
                                      storeReportOverview.joinCount.toString(),
                                  duration: const Duration(seconds: 3),
                                  curve: Curves.easeOut,
                                  textStyle: TextStyle(
                                      color: kThemeColor,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                  format: NumberFormatMode.comma),
                              Text('명 참여',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14))
                            ]),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.favorite_outline,
                              size: 40,
                            ),
                            SizedBox(width: 10),
                            Row(children: [
                              Text('누적 좋아요 ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              NumberSlideAnimation(
                                  number:
                                      storeReportOverview.likeCount.toString(),
                                  duration: const Duration(seconds: 3),
                                  curve: Curves.easeOut,
                                  textStyle: TextStyle(
                                      color: kThemeColor,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                  format: NumberFormatMode.comma),
                              Text('개',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14))
                            ]),
                          ],
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 20,
                            offset: Offset(0, 0),
                          ),
                        ])),
                SizedBox(height: kDefaultPadding / 3 * 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '이벤트 별 보고서',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(
                            Icons.sort,
                            color: kThemeColor,
                          ),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: kThemeColor),
                          underline: Container(
                            height: 2,
                            color: kThemeColor,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>[
                            '최신 등록 순',
                            '높은 객단가 순',
                            '낮은 객단가 순',
                            '많은 참가자 순',
                            '적은 참가자 순',
                            '많은 좋아요 순',
                            '적은 좋아요 순'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                  width: 100,
                                  child: Text(
                                    value,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  )),
                            );
                          }).toList())
                    ],
                  ),
                ),
                SizedBox(height: kDefaultPadding / 3 * 2),
                Column(
                    children: List.generate(
                  eventReportList.length,
                  (index) => Container(
                      width: size.width,
                      margin: const EdgeInsets.only(bottom: kDefaultPadding),
                      child: Card(
                          color: Colors.white,
                          elevation: 0.75,
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30)),
                                  child: Stack(
                                    children: [
                                      Image.asset(
                                        eventReportList[index].thumbnail,
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned(
                                          bottom: 15,
                                          right: 15,
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                4, 1, 4, 2),
                                            width: 50,
                                            child: Center(
                                              child: Text(
                                                eventReportList[index].status ==
                                                        EventStatus.PROCEEDING
                                                    ? '진행 중'
                                                    : '종료',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            color: eventReportList[index]
                                                        .status ==
                                                    EventStatus.PROCEEDING
                                                ? Colors.greenAccent.shade700
                                                : Colors.grey.shade600,
                                          ))
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 10, 15, 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(eventReportList[index].eventName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                        SizedBox(height: kDefaultPadding / 2),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.attach_money,
                                              size: 16,
                                              color: Colors.black54,
                                            ),
                                            SizedBox(
                                                width: kDefaultPadding / 5),
                                            Text(
                                              '${numberDisplay(eventReportList[index].guestPrice)}원',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14),
                                            ),
                                            SizedBox(
                                                width: kDefaultPadding / 2),
                                            Icon(
                                              Icons.group,
                                              size: 16,
                                              color: Colors.black54,
                                            ),
                                            SizedBox(
                                                width: kDefaultPadding / 3),
                                            Text(
                                                '${numberDisplay(eventReportList[index].joinCount)}명',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 14)),
                                            SizedBox(
                                                width: kDefaultPadding / 2),
                                            Icon(
                                              Icons.favorite,
                                              size: 16,
                                              color: Colors.black54,
                                            ),
                                            SizedBox(
                                                width: kDefaultPadding / 3),
                                            Text(
                                                '${numberDisplay(eventReportList[index].likeCount)}개',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                        SizedBox(height: kDefaultPadding / 3),
                                        Wrap(
                                            direction: Axis.horizontal,
                                            spacing: 5.0,
                                            children: List.generate(
                                              eventReportList[index]
                                                  .rewardNameList
                                                  .length,
                                              (rewardIndex) => Chip(
                                                label: Text(
                                                  eventReportList[index]
                                                          .rewardNameList[
                                                      rewardIndex],
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(3),
                                                backgroundColor: kThemeColor
                                                    .withOpacity(0.2),
                                              ),
                                            )),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))))),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
