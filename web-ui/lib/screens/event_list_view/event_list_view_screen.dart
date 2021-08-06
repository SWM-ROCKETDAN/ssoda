import 'package:flutter/material.dart';

class EventListViewScreen extends StatefulWidget {
  const EventListViewScreen({Key? key}) : super(key: key);

  @override
  _EventListViewScreenState createState() => _EventListViewScreenState();
}

class _EventListViewScreenState extends State<EventListViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Center(
            child: Text(
              '이벤트 리스트 페이지',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
