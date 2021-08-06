import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/models/event.dart';
import 'package:hashchecker_web/models/reward.dart';

class EventRequirements extends StatelessWidget {
  const EventRequirements({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('추가 조건',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
      SizedBox(height: kDefaultPadding),
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
              data['event'].requireList.length,
              (index) => data['event'].requireList[index]
                  ? Text('$index번째 요청사항\n')
                  : Container()))
    ]);
  }
}
