import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/event_list_item.dart';
import 'components/empty.dart';
import 'components/event_list_tile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({Key? key}) : super(key: key);

  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  late List<EventListItem> eventList;
  final _eventSortDropdownItemList = ['최신 등록 순', '빠른 종료 순', '가나다 순'];
  final _statusFilterString = ['전체', '진행 중', '대기 중', '종료'];
  final _statusStringMap = {
    EventStatus.WAITING: '대기 중',
    EventStatus.PROCEEDING: '진행 중',
    EventStatus.ENDED: '종료'
  };
  final _statusColorMap = {
    EventStatus.WAITING: kLiteFontColor,
    EventStatus.PROCEEDING: kThemeColor,
    EventStatus.ENDED: kDefaultFontColor
  };
  String dropdownValue = '최신 등록 순';
  int _selectedStatusFilter = 0;

  @override
  void initState() {
    super.initState();
    eventList = [
      EventListItem(
          title: '우리가게 SNS 해시태그 이벤트',
          startDate: '2021-04-14',
          finishDate: '2021-04-14',
          thumbnail: 'assets/images/event1.jpg',
          status: EventStatus.PROCEEDING),
      EventListItem(
          title: '오픈기념 아메리카노 이벤트',
          startDate: '2021-09-23',
          finishDate: '2021-11-05',
          thumbnail: 'assets/images/store1.jpg',
          status: EventStatus.WAITING),
      EventListItem(
          title: '우리가게 9월 한정 쿠폰 이벤트',
          startDate: '2021-09-01',
          finishDate: '2021-09-30',
          thumbnail: 'assets/images/event2.jpg',
          status: EventStatus.ENDED),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: eventList.isEmpty
            ? Empty()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '이벤트 목록',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 24,
                                color: kDefaultFontColor),
                          ),
                          DropdownButton(
                              dropdownColor:
                                  kScaffoldBackgroundColor.withOpacity(0.9),
                              value: dropdownValue,
                              icon: const Icon(
                                Icons.sort,
                                color: kDefaultFontColor,
                                size: 20,
                              ),
                              iconSize: 24,
                              elevation: 0,
                              style: TextStyle(
                                  color: kDefaultFontColor, fontSize: 13),
                              underline: Container(
                                height: 0,
                                color: kDefaultFontColor,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: _eventSortDropdownItemList
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: SizedBox(
                                      width: 85,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: kDefaultFontColor),
                                        textAlign: TextAlign.center,
                                      )),
                                );
                              }).toList())
                        ],
                      ),
                      SizedBox(height: kDefaultPadding / 3),
                      Row(
                          children: List.generate(
                              _statusFilterString.length,
                              (index) => Container(
                                    height: 30,
                                    width: 60,
                                    margin: const EdgeInsets.only(right: 8),
                                    child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _selectedStatusFilter = index;
                                          });
                                        },
                                        child: Text(
                                          _statusFilterString[index],
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  _selectedStatusFilter == index
                                                      ? kScaffoldBackgroundColor
                                                      : kThemeColor),
                                        ),
                                        style: ButtonStyle(
                                            padding:
                                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                                    EdgeInsets.all(0)),
                                            backgroundColor:
                                                MaterialStateProperty.all<Color>(
                                                    _selectedStatusFilter == index
                                                        ? kThemeColor
                                                        : Colors.transparent),
                                            shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(27.0),
                                                side: _selectedStatusFilter == index
                                                    ? BorderSide.none
                                                    : BorderSide(
                                                        color: kThemeColor))))),
                                  ))),
                      SizedBox(height: kDefaultPadding * 1.5),
                      AnimationLimiter(
                        child: Column(
                            children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 500),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 75.0,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: List.generate(
                            eventList.length,
                            (index) => (_selectedStatusFilter == 0 ||
                                    _statusStringMap[eventList[index].status] ==
                                        _statusFilterString[
                                            _selectedStatusFilter])
                                ? EventListTile(
                                    size: size,
                                    index: index,
                                    eventList: eventList,
                                    statusStringMap: _statusStringMap,
                                    statusColorMap: _statusColorMap)
                                : Container(),
                          ),
                        )),
                      )
                    ],
                  ),
                ),
              ));
  }
}
