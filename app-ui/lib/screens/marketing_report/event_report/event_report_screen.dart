import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event_report.dart';

import 'components/daily_report.dart';
import 'components/monthly_report.dart';
import 'components/total_report.dart';
import 'components/weekly_report.dart';

class EventReportScreen extends StatefulWidget {
  const EventReportScreen(
      {Key? key, required this.indexForHero, required this.eventThumbnail})
      : super(key: key);

  final int indexForHero;
  final String eventThumbnail; // it will be set api & initState
  @override
  _EventReportScreenState createState() => _EventReportScreenState();
}

class _EventReportScreenState extends State<EventReportScreen> {
  late EventReport eventReport;

  @override
  void initState() {
    super.initState();
    eventReport = EventReport(
        eventName: '우리가게 SNS 해시태그 이벤트',
        joinCount: 4379,
        likeCount: 7423,
        livePostCount: 257,
        deadPostCount: 127,
        commentCount: 2184,
        exposeCount: 51824,
        followerSum: 51623,
        followerAvg: 186,
        costSum: 372100,
        costPerReward: [50000, 65000, 50000, 75000, 90000]);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: DefaultTabController(
      length: 4,
      child: NestedScrollView(
          headerSliverBuilder: (context, ext) => [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 25, 20),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.close)),
                    )
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.fromLTRB(20, 10, 0, 15),
                    title: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            eventReport.eventName,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                            maxLines: 1,
                          ),
                          AutoSizeText(
                            '마케팅 성과 레포트',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            maxLines: 1,
                          )
                        ]),
                    background: Stack(children: <Widget>[
                      Hero(
                          tag: 'reportThumbnail${widget.indexForHero}',
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  widget.eventThumbnail,
                                ),
                              ),
                            ),
                            height: size.height * 0.4,
                          )),
                      Container(
                        height: size.height * 0.4,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                                begin: FractionalOffset.center,
                                end: FractionalOffset.bottomCenter,
                                colors: [
                                  Colors.transparent.withOpacity(0.0),
                                  Colors.black.withOpacity(0.7),
                                ],
                                stops: [
                                  0.0,
                                  1.0
                                ])),
                      )
                    ]),
                  ),
                  backgroundColor: kDefaultFontColor.withOpacity(0.87),
                  foregroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0))),
                  expandedHeight: size.height * 0.3,
                  pinned: true,
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      indicatorColor: kDefaultFontColor,
                      labelColor: kDefaultFontColor,
                      unselectedLabelColor: kLiteFontColor.withOpacity(0.8),
                      tabs: [
                        Tab(text: "일 별"),
                        Tab(text: "주 별"),
                        Tab(text: "월 별"),
                        Tab(text: "종 합"),
                      ],
                    ),
                  ),
                  pinned: true,
                )
              ],
          body: TabBarView(
            children: [
              DailyReport(size: size, eventReport: eventReport),
              WeeklyReport(size: size, eventReport: eventReport),
              MonthlyReport(size: size, eventReport: eventReport),
              TotalReport(size: size, eventReport: eventReport)
            ],
          )),
    ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
      decoration: BoxDecoration(color: kScaffoldBackgroundColor, boxShadow: [
        BoxShadow(
            color: kShadowColor,
            offset: Offset(0.0, 1.0),
            blurRadius: 1.0,
            spreadRadius: 0.7),
      ]),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
