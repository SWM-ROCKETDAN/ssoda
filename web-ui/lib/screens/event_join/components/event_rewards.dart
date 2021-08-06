import 'package:flutter/material.dart';
import 'package:hashchecker_web/api.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/models/event.dart';
import 'package:hashchecker_web/models/reward.dart';

class EventRewards extends StatelessWidget {
  const EventRewards({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('이벤트 상품',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
      SizedBox(height: kDefaultPadding),
      SizedBox(
        height: 150,
        child: ListView.separated(
          itemBuilder: (context, index) => ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              '$s3Url${data['rewards'][index].imgPath}',
              fit: BoxFit.cover,
              width: 130,
            ),
          ),
          itemCount: data['rewards'].length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(3, 6, 3, 6),
          separatorBuilder: (context, index) => SizedBox(width: 12),
        ),
      )
    ]);
  }
}
