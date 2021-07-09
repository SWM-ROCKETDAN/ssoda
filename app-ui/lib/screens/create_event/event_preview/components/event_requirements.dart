import 'package:flutter/material.dart';
import 'package:hashchecker/models/event.dart';

class EventRequirements extends StatelessWidget {
  const EventRequirements({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('추가 조건',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
      SizedBox(height: 15),
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
              event.requireList.length,
              (index) => event.requireList[index]
                  ? Text('${index}번째 요청사항\n')
                  : Container()))
    ]);
  }
}
