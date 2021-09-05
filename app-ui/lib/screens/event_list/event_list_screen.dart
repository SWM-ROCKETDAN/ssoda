import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/address.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/event_list_item.dart';
import 'package:hashchecker/models/store.dart';
import 'package:hashchecker/models/store_category.dart';
import 'package:hashchecker/screens/event_list/components/store_header.dart';
import 'components/empty.dart';
import 'components/event_list_tile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({Key? key}) : super(key: key);

  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  late Store store;
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
    store = Store(
        name: '우리가게 광나루역점',
        category: StoreCategory.RESTAURANT,
        address: Address(
            city: '서울시',
            country: '광진구',
            town: '광장동',
            road: '아차산로',
            building: '549',
            zipCode: '04983',
            latitude: 0,
            longitude: 0),
        description: '안녕하세요 우리가게 광나루역점입니다.',
        images: ['assets/images/store1.jpg', 'assets/images/event1.jpg'],
        logoImage: 'assets/images/store_logo_sample.jpg');

    eventList = [
      EventListItem(
          id: -1,
          title: '우리가게 SNS 해시태그 이벤트',
          startDate: '2021-04-14',
          finishDate: '2021-04-14',
          thumbnail: 'assets/images/event1.jpg',
          status: EventStatus.PROCEEDING),
      EventListItem(
          id: -1,
          title: '오픈기념 아메리카노 이벤트',
          startDate: '2021-09-23',
          finishDate: '2021-11-05',
          thumbnail: 'assets/images/store1.jpg',
          status: EventStatus.WAITING),
      EventListItem(
          id: -1,
          title: '우리가게 9월 한정 쿠폰 이벤트',
          startDate: '2021-09-01',
          finishDate: '2021-09-30',
          thumbnail: 'assets/images/event2.jpg',
          status: EventStatus.ENDED),
      EventListItem(
          id: -1,
          title: '우리가게 SNS 해시태그 이벤트',
          startDate: '2021-04-14',
          finishDate: '2021-04-14',
          thumbnail: 'assets/images/event1.jpg',
          status: EventStatus.PROCEEDING),
      EventListItem(
          id: -1,
          title: '오픈기념 아메리카노 이벤트',
          startDate: '2021-09-23',
          finishDate: '2021-11-05',
          thumbnail: 'assets/images/store1.jpg',
          status: EventStatus.WAITING),
      EventListItem(
          id: -1,
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
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          toolbarHeight: 0,
          expandedHeight: size.width / 16 * 9 * 1.65,
          backgroundColor: kScaffoldBackgroundColor,
          flexibleSpace:
              FlexibleSpaceBar(background: StoreHeader(store: store)),
          floating: false,
          elevation: 0,
        ),
        SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
                minHeight: 100,
                maxHeight: 100,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  color: kScaffoldBackgroundColor,
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '이벤트 목록',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
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
                            items:
                                _eventSortDropdownItemList.map((String value) {
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
                  ]),
                ))),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => eventList.isEmpty
                    ? Empty()
                    : Column(children: [
                        Column(
                          children: [
                            SizedBox(height: kDefaultPadding),
                            AnimationLimiter(
                              child: Column(
                                  children:
                                      AnimationConfiguration.toStaggeredList(
                                duration: const Duration(milliseconds: 500),
                                childAnimationBuilder: (widget) =>
                                    SlideAnimation(
                                  horizontalOffset: 75,
                                  child: FadeInAnimation(
                                    child: widget,
                                  ),
                                ),
                                children: List.generate(
                                  eventList.length,
                                  (index) => (_selectedStatusFilter == 0 ||
                                          _statusStringMap[
                                                  eventList[index].status] ==
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
                      ]),
                childCount: 1))
      ],
    ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  // 2
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  // 3
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
