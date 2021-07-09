import 'package:flutter/material.dart';
import 'package:hashchecker/models/event.dart';
import 'dart:io';

class EventRewards extends StatelessWidget {
  const EventRewards({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('이벤트 상품',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
      SizedBox(height: 15),
      SizedBox(
        height: 116,
        child: ListView.separated(
          itemBuilder: (context, index) => ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.file(
              File(event.rewardList[index]!.imgPath),
              fit: BoxFit.cover,
              width: 100,
              height: 110,
            ),
          ),
          itemCount: event.rewardList.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(3, 6, 3, 6),
          separatorBuilder: (context, index) => SizedBox(width: 12),
        ),
      )
    ]);
  }
}
