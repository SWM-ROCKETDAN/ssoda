import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:ms_undraw/ms_undraw.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({Key? key}) : super(key: key);

  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  late List<Event> eventList;

  @override
  void initState() {
    super.initState();
    eventList = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: eventList.isEmpty
            ? Container(
                padding: const EdgeInsets.all(20),
                color: kScaffoldBackgroundColor,
                child: Stack(
                  children: [
                    UnDraw(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 160),
                      color: kThemeColor,
                      illustration: UnDrawIllustration.empty,
                      placeholder: CircularProgressIndicator(
                        color: kThemeColor,
                      ),
                      errorWidget: Icon(Icons.error_outline,
                          color: Colors.red, size: 50),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.25,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Text(
                            '아직 아무런 이벤트가 등록되지 않았습니다',
                            style: TextStyle(color: kLiteFontColor),
                          ),
                          SizedBox(height: kDefaultPadding / 4),
                          Text(
                            '먼저 이벤트를 등록해주세요!',
                            style: TextStyle(color: kLiteFontColor),
                          ),
                        ],
                      ),
                    )
                  ],
                ))
            : Container());
  }
}
