import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/period.dart';
import 'package:hashchecker/models/requires.dart';
import 'package:hashchecker/models/reward.dart';
import 'package:hashchecker/models/reward_category.dart';
import 'package:hashchecker/models/template.dart';
import 'package:hashchecker/screens/hall/hall_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EventEditModal extends StatefulWidget {
  final int eventId;
  const EventEditModal({Key? key, required this.eventId}) : super(key: key);

  @override
  _EventEditModalState createState() => _EventEditModalState();
}

class _EventEditModalState extends State<EventEditModal> {
  late Future<Event> event;
  late TextEditingController _eventTitleController;
  TextEditingController _hashtagcontroller = TextEditingController();
  DateRangePickerController _startDatePickerController =
      DateRangePickerController();
  DateRangePickerController _finishDatePickerController =
      DateRangePickerController();

  Future<List<Reward>> _fetchRewardListData() async {
    var dio = await authDio();

    final getRewardListResponse = await dio.get(
        getApi(API.GET_REWARD_OF_EVENT, suffix: '/${widget.eventId}/rewards'));

    final fetchedRewardList = getRewardListResponse.data;

    print(fetchedRewardList);

    List<Reward> rewardList = List.generate(fetchedRewardList.length,
        (index) => Reward.fromJson(fetchedRewardList[index]));

    return rewardList;
  }

  Future<Event> _fetchEventData() async {
    List<Reward> _rewardList = await _fetchRewardListData();

    var dio = await authDio();

    final getEventResponse =
        await dio.get(getApi(API.GET_EVENT, suffix: '/${widget.eventId}'));

    final fetchedEvent = getEventResponse.data;

    Event event = Event.fromJson(fetchedEvent);
    event.rewardList = _rewardList;

    if (event.images.length < 3) event.images.add(null);
    _eventTitleController = TextEditingController(text: event.title);

    return event;
  }

  @override
  void initState() {
    super.initState();
    event = _fetchEventData();
  }

  @override
  void dispose() {
    _eventTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppBar(),
      body: WillPopScope(
        onWillPop: () async {
          bool shouldClose = true;
          await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                  title: Center(
                    child: Text('이벤트 수정',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: kDefaultFontColor),
                        textAlign: TextAlign.center),
                  ),
                  content: IntrinsicHeight(
                    child: Column(children: [
                      Text("저장되지 않은 내용이 있습니다.",
                          style: TextStyle(
                              fontSize: 14, color: kDefaultFontColor)),
                      SizedBox(height: kDefaultPadding / 5),
                      Text("그래도 나가시겠습니까?",
                          style: TextStyle(
                              fontSize: 14, color: kDefaultFontColor)),
                    ]),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                  actions: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('예',
                                style: TextStyle(
                                    color: kThemeColor, fontSize: 13)),
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all<Color>(
                                    kThemeColor.withOpacity(0.2))),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              shouldClose = false;
                              Navigator.of(context).pop();
                            },
                            child: Text('아니오', style: TextStyle(fontSize: 13)),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        kThemeColor)),
                          ),
                        ],
                      ),
                    )
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))));
          return shouldClose;
        },
        child: FutureBuilder<Event>(
            future: event,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Section(text: '대표 이미지'),
                        SizedBox(height: kDefaultPadding),
                        buildEventImageEdit(context, size, snapshot.data!),
                        SizedBox(height: kDefaultPadding),
                        Section(text: '이벤트 제목'),
                        buildEventTitleEdit(snapshot.data!),
                        SizedBox(height: kDefaultPadding * 2.5),
                        Section(text: '이벤트 상품'),
                        SizedBox(height: kDefaultPadding),
                        buildEventRewardEdit(snapshot.data!),
                        SizedBox(height: kDefaultPadding * 2.5),
                        Section(text: '필수 해시태그'),
                        SizedBox(height: kDefaultPadding / 3),
                        buildEventHashtagEdit(context, snapshot.data!),
                        SizedBox(height: kDefaultPadding * 2),
                        Section(text: '세부 요청사항'),
                        SizedBox(height: kDefaultPadding),
                        buildEventRequireEdit(size, snapshot.data!),
                        SizedBox(height: kDefaultPadding * 2.5),
                        Section(text: '이벤트 기간'),
                        SizedBox(height: kDefaultPadding / 2.5),
                        buildEventPeriodEdit(context, size, snapshot.data!),
                        buildEventPermanentSelection(snapshot.data!),
                        SizedBox(height: kDefaultPadding),
                        buildConfirmButton(size, context, snapshot.data!)
                      ],
                    )),
                  ),
                ));
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return Center(child: const CircularProgressIndicator());
            }),
      ),
    );
  }

  SizedBox buildConfirmButton(Size size, BuildContext context, Event event) {
    return SizedBox(
      width: size.width,
      height: 45,
      child: ElevatedButton(
        onPressed: () async {
          await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                  title: Center(
                    child: Text('이벤트 수정',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: kDefaultFontColor),
                        textAlign: TextAlign.center),
                  ),
                  content: Text("이벤트 수정이 완료되었습니다",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
                  contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                  actions: [
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HallScreen()));
                        },
                        child: Text('확인', style: TextStyle(fontSize: 13)),
                        style: ButtonStyle(
                            shadowColor:
                                MaterialStateProperty.all<Color>(kShadowColor),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kThemeColor)),
                      ),
                    )
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))));
          Navigator.pop(context);
        },
        child: Text('이대로 수정하기',
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
        style: ButtonStyle(
            shadowColor: MaterialStateProperty.all<Color>(kShadowColor),
            backgroundColor: MaterialStateProperty.all<Color>(kThemeColor),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.0)))),
      ),
    );
  }

  Container buildEventRequireEdit(Size size, Event event) {
    return Container(
      child: Center(
        child: Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            alignment: WrapAlignment.start,
            children: List.generate(
                requireStringList.length,
                (index) => SizedBox(
                      width: size.width * 0.23,
                      height: size.width * 0.23 * 1.2,
                      child: TextButton(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(requireIconList[index],
                                  color: event.requireList[index]
                                      ? kThemeColor
                                      : kLiteFontColor,
                                  size: 20),
                              SizedBox(height: kDefaultPadding / 5),
                              Text(
                                requireStringList[index],
                                style: TextStyle(
                                    color: event.requireList[index]
                                        ? kThemeColor
                                        : kLiteFontColor,
                                    fontSize: 11,
                                    fontWeight: event.requireList[index]
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          onPressed: () {
                            setState(() {
                              event.requireList[index] =
                                  !event.requireList[index];
                            });
                          },
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color>(
                                  event.requireList[index]
                                      ? kLiteFontColor.withOpacity(0.2)
                                      : kThemeColor.withOpacity(0.2)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  kScaffoldBackgroundColor),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                          color: event.requireList[index]
                                              ? kThemeColor
                                              : kLiteFontColor))))),
                    ))),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kScaffoldBackgroundColor,
      elevation: 1,
      title: Text(
        '이벤트 수정',
        style: TextStyle(
            color: kDefaultFontColor,
            fontSize: 19,
            fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  Container buildEventImageEdit(BuildContext context, Size size, Event event) {
    return Container(
        child: CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.22,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        initialPage: 0,
        autoPlay: false,
        viewportFraction: 0.66,
      ),
      items: List.generate(
          event.images.length,
          (index) => event.images[index] == null
              ? SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextButton(
                    onPressed: () {
                      _getImageFromGallery(context, index, event);
                    },
                    child: Center(
                        child: Icon(
                      Icons.add,
                      color: kLiteFontColor,
                      size: 40,
                    )),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0))),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            kScaffoldBackgroundColor),
                        overlayColor:
                            MaterialStateProperty.all<Color>(kShadowColor),
                        side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(color: kLiteFontColor))),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    _getImageFromGallery(context, index, event);
                  },
                  child: Stack(children: [
                    ClipRRect(
                      child: Image.network('$s3Url${event.images[index]}',
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    Positioned(
                        right: 10,
                        top: 10,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (event.images.last == null)
                                event.images.removeLast();
                              event.images[index] = null;
                            });
                          },
                          child: Icon(Icons.cancel_rounded,
                              size: 28, color: Colors.white.withOpacity(0.9)),
                        ))
                  ]),
                )).cast<Widget>().toList(),
    ));
  }

  Row buildEventPermanentSelection(Event event) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: event.period.finishDate == null,
          onChanged: (value) {
            setState(() {
              if (value!)
                event.period.finishDate = null;
              else
                event.period.finishDate =
                    event.period.startDate.add(Duration(days: 30));
            });
          },
          activeColor: kThemeColor,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              if (event.period.finishDate != null)
                event.period.finishDate = null;
              else
                event.period.finishDate =
                    event.period.startDate.add(Duration(days: 30));
            });
          },
          child: Text('상품 소진 시까지 영구진행',
              style: TextStyle(
                  fontSize: 14,
                  color: event.period.finishDate == null
                      ? kThemeColor
                      : kLiteFontColor)),
        )
      ],
    );
  }

  Row buildEventPeriodEdit(BuildContext context, Size size, Event event) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  bool showDateErr = false;
                  return StatefulBuilder(builder: (context, setDialogState) {
                    return AlertDialog(
                      contentPadding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                      actionsPadding: const EdgeInsets.fromLTRB(12, 0, 12, 4),
                      content: IntrinsicHeight(
                        child: Column(
                          children: [
                            Container(
                                width: size.width * 0.8,
                                height: size.height * 0.5,
                                child: SfDateRangePicker(
                                  selectionMode:
                                      DateRangePickerSelectionMode.single,
                                  selectionColor: kThemeColor,
                                  todayHighlightColor: kThemeColor,
                                  showNavigationArrow: true,
                                  initialSelectedDate: event.period.startDate,
                                  monthCellStyle: DateRangePickerMonthCellStyle(
                                      todayTextStyle: TextStyle(
                                          color: kThemeColor, fontSize: 12)),
                                  yearCellStyle: DateRangePickerYearCellStyle(
                                      todayTextStyle: TextStyle(
                                          color: kThemeColor, fontSize: 12)),
                                  controller: _startDatePickerController,
                                )),
                            if (showDateErr == true)
                              Text('시작 날짜가 종료 날짜보다 앞서 있어요!',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 12))
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('취소')),
                        ElevatedButton(
                            onPressed: () {
                              if (event.period.finishDate != null &&
                                  _startDatePickerController.selectedDate!
                                      .isAfter(event.period.finishDate!)) {
                                setDialogState(() {
                                  showDateErr = true;
                                });
                                _startDatePickerController.selectedDate =
                                    event.period.startDate;
                                return;
                              }
                              setState(() {
                                if (_startDatePickerController.selectedDate !=
                                    null)
                                  event.period.startDate =
                                      _startDatePickerController.selectedDate!;
                              });
                              Navigator.pop(context);
                            },
                            child: Text('확인'))
                      ],
                    );
                  });
                });
          },
          child: Row(
            children: [
              Icon(Icons.calendar_today_rounded,
                  color: kDefaultFontColor.withOpacity(0.85), size: 16),
              SizedBox(width: kDefaultPadding / 3),
              Text(
                event.period.startDate.toString().substring(0, 10),
                style: TextStyle(color: kDefaultFontColor.withOpacity(0.85)),
              ),
            ],
          ),
          style: ButtonStyle(
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              elevation: MaterialStateProperty.all<double>(4.0),
              shadowColor: MaterialStateProperty.all<Color>(
                  kShadowColor.withOpacity(0.3)),
              overlayColor: MaterialStateProperty.all<Color>(kShadowColor),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.fromLTRB(8, 8, 12, 8)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(kScaffoldBackgroundColor)),
        ),
        SizedBox(width: kDefaultPadding),
        Text('~', style: TextStyle(color: kDefaultFontColor)),
        SizedBox(width: kDefaultPadding),
        event.period.finishDate == null
            ? Text('상품 소진 시까지',
                style: TextStyle(
                    color: kDefaultFontColor.withOpacity(0.85),
                    fontSize: 14,
                    fontWeight: FontWeight.bold))
            : ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        bool showDateErr = false;
                        return StatefulBuilder(
                          builder: (context, setDialogState) => AlertDialog(
                            contentPadding:
                                const EdgeInsets.fromLTRB(12, 10, 12, 0),
                            actionsPadding:
                                const EdgeInsets.fromLTRB(12, 0, 12, 4),
                            content: IntrinsicHeight(
                              child: Column(
                                children: [
                                  Container(
                                      width: size.width * 0.8,
                                      height: size.height * 0.5,
                                      child: SfDateRangePicker(
                                        selectionMode:
                                            DateRangePickerSelectionMode.single,
                                        selectionColor: kThemeColor,
                                        todayHighlightColor: kThemeColor,
                                        showNavigationArrow: true,
                                        initialSelectedDate:
                                            event.period.finishDate,
                                        monthCellStyle:
                                            DateRangePickerMonthCellStyle(
                                                todayTextStyle: TextStyle(
                                                    color: kThemeColor,
                                                    fontSize: 12)),
                                        yearCellStyle:
                                            DateRangePickerYearCellStyle(
                                                todayTextStyle: TextStyle(
                                                    color: kThemeColor,
                                                    fontSize: 12)),
                                        controller: _finishDatePickerController,
                                      )),
                                  if (showDateErr == true)
                                    Text('시작 날짜가 종료 날짜보다 앞서 있어요!',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12))
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('취소')),
                              ElevatedButton(
                                  onPressed: () {
                                    if (_finishDatePickerController
                                                .selectedDate !=
                                            null &&
                                        event.period.startDate.isAfter(
                                            _finishDatePickerController
                                                .selectedDate!)) {
                                      setDialogState(() {
                                        showDateErr = true;
                                      });
                                      _finishDatePickerController.selectedDate =
                                          event.period.finishDate;
                                      return;
                                    }
                                    setState(() {
                                      if (_finishDatePickerController
                                              .selectedDate !=
                                          null)
                                        event.period.finishDate =
                                            _finishDatePickerController
                                                .selectedDate!;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text('확인'))
                            ],
                          ),
                        );
                      });
                },
                child: Row(
                  children: [
                    Icon(Icons.calendar_today_rounded,
                        color: kDefaultFontColor.withOpacity(0.85), size: 16),
                    SizedBox(width: kDefaultPadding / 3),
                    Text(event.period.finishDate.toString().substring(0, 10),
                        style: TextStyle(
                            color: kDefaultFontColor.withOpacity(0.85))),
                  ],
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    elevation: MaterialStateProperty.all<double>(4.0),
                    shadowColor: MaterialStateProperty.all<Color>(
                        kShadowColor.withOpacity(0.3)),
                    overlayColor:
                        MaterialStateProperty.all<Color>(kShadowColor),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.fromLTRB(8, 8, 12, 8)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        kScaffoldBackgroundColor)),
              ),
      ],
    );
  }

  Wrap buildEventHashtagEdit(BuildContext context, Event event) {
    return Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 7.0,
        runSpacing: -5,
        children: List.generate(
          event.hashtagList.length + 1,
          (index) => index == event.hashtagList.length
              ? CircleAvatar(
                  backgroundColor: kThemeColor,
                  radius: 16,
                  child: IconButton(
                      padding: const EdgeInsets.all(0),
                      highlightColor: Colors.transparent,
                      icon: Icon(Icons.add, size: 20),
                      color: Colors.white,
                      onPressed: () {
                        if (event.hashtagList.length == 10) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('해시태그는 최대 10개까지만 등록할 수 있습니다!'),
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(milliseconds: 2500),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          );
                        } else
                          _showHashtagInputDialog(context, event);
                      }),
                )
              : Chip(
                  avatar: CircleAvatar(
                      radius: 12,
                      child: Icon(
                        Icons.tag,
                        color: Colors.white,
                        size: 16,
                      ),
                      backgroundColor: kDefaultFontColor.withOpacity(0.85)),
                  onDeleted: () {
                    setState(() {
                      event.hashtagList.removeAt(index);
                    });
                  },
                  deleteIconColor: kLiteFontColor,
                  label: Text(
                    '${event.hashtagList[index]}',
                    style: TextStyle(fontSize: 13.3),
                  ),
                  labelPadding: const EdgeInsets.fromLTRB(4.3, 1.2, 0, 1.2),
                  elevation: 5.0,
                  shadowColor: kShadowColor,
                  backgroundColor: kScaffoldBackgroundColor,
                ),
        ));
  }

  Container buildEventRewardEdit(Event event) {
    return Container(
        height: 96,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: event.rewardList.length,
            separatorBuilder: (context, index) => SizedBox(width: 8),
            itemBuilder: (context, index) => event.rewardList[index] == null
                ? SizedBox(
                    width: 91,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Stack(children: [
                        Center(
                            child: Icon(
                          Icons.add,
                          size: 28,
                          color: kLiteFontColor,
                        )),
                      ]),
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(0),
                          side: MaterialStateProperty.all<BorderSide>(
                              BorderSide(color: kLiteFontColor)),
                          overlayColor:
                              MaterialStateProperty.all<Color>(kShadowColor),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              kScaffoldBackgroundColor),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)))),
                    ))
                : GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            '$s3Url${event.rewardList[index]!.imgPath}',
                            fit: BoxFit.cover,
                            width: 91,
                            height: 96,
                            color: Colors.black38,
                            colorBlendMode: BlendMode.darken,
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: 91,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${index + 1}단계',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                Text(
                                  '수정하기',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        if (event.rewardList.last == null &&
                                event.rewardList.length == index + 2 ||
                            event.rewardList.length == index + 1)
                          Positioned(
                              right: 0,
                              top: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (event.rewardList.last == null)
                                      event.rewardList.removeLast();
                                    event.rewardList[index] = null;
                                  });
                                },
                                child: Icon(
                                  Icons.cancel_rounded,
                                  color: Colors.white.withOpacity(0.8),
                                  size: 20,
                                ),
                              ))
                      ]),
                    ),
                  )));
  }

  SizedBox buildEventTitleEdit(Event event) {
    return SizedBox(
      height: 40,
      child: TextField(
          controller: _eventTitleController,
          onChanged: (_) {
            event.title = _eventTitleController.value.text.trim();
          },
          style: TextStyle(
            color: kDefaultFontColor,
            fontSize: 15,
          ),
          decoration: InputDecoration(
              hintText: '이벤트 제목을 입력해주세요',
              hintStyle: TextStyle(
                  color: kLiteFontColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold))),
    );
  }

  Future<void> _showHashtagInputDialog(
      BuildContext context, Event event) async {
    _hashtagcontroller = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          String? errMsg;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                title: Center(
                  child: Text(
                    '해시태그 추가하기',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                content: IntrinsicHeight(
                  child: Column(
                    children: [
                      TextField(
                        autofocus: true,
                        controller: _hashtagcontroller,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          hintText: '우리가게',
                          prefixIcon: Icon(Icons.tag),
                        ),
                        onSubmitted: (_) {
                          setState(() {
                            errMsg = _checkHashtag(context, event);
                          });
                          if (errMsg == null) Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: kDefaultPadding / 5),
                      if (errMsg != null)
                        Text(
                          errMsg!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        )
                    ],
                  ),
                ),
                actions: [
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            errMsg = _checkHashtag(context, event);
                          });
                          if (errMsg == null) Navigator.pop(context);
                        },
                        child: Text(
                          '추가',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  )
                ],
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)));
          });
        });
  }

  String? _checkHashtag(BuildContext context, Event event) {
    final validChar = RegExp(r'^[a-zA-Z0-9ㄱ-ㅎㅏ-ㅣ가-힣]+$');

    if (_hashtagcontroller.value.text.trim().isEmpty) return '해시태그를 입력해주세요';

    if (!validChar.hasMatch(_hashtagcontroller.value.text.trim()))
      return '공백 및 특수문자는 사용할 수 없습니다';

    if (event.hashtagList.indexOf(_hashtagcontroller.value.text.trim()) != -1)
      return '이미 추가한 해시태그입니다';

    if (_hashtagcontroller.value.text.trim().length > 10)
      return '해시태그의 길이는 최대 10글자입니다';

    setState(() {
      event.hashtagList.add(_hashtagcontroller.value.text.trim());
    });
    return null;
  }

  Future _getImageFromGallery(
      BuildContext context, int index, Event event) async {
    final ImagePicker _imagePicker = ImagePicker();
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (event.images[index] == null && event.images.length < 3)
        event.images.add(null);
      event.images[index] = image!.path;
    });
  }
}

class Section extends StatelessWidget {
  final text;
  const Section({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: kDefaultFontColor, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
