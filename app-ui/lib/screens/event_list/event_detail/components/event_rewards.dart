import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';

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
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: kDefaultFontColor)),
      SizedBox(height: kDefaultPadding),
      SizedBox(
        height: 150,
        child: ListView.separated(
          itemBuilder: (context, index) => ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              '$s3Url${event.rewardList[index]!.imgPath}',
              fit: BoxFit.cover,
              width: 130,
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
