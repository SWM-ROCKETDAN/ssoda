import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/models/event.dart';
import 'package:hashchecker_web/models/reward.dart';

class EventPeriod extends StatelessWidget {
  const EventPeriod({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('이벤트 기간',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
      SizedBox(height: kDefaultPadding),
      data['event'].period.finishDate == null
          ? Text(
              '${data['event'].period.startDate.toString().substring(0, 10)} ~ 계속')
          : Text(
              '${data['event'].period.startDate.toString().substring(0, 10)} ~ ${data['event'].period.finishDate.toString().substring(0, 10)}')
    ]);
  }
}
