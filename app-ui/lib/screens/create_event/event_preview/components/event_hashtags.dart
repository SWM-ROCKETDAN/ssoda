import 'package:flutter/material.dart';
import '../../../../models/event.dart';

class EventHashtags extends StatelessWidget {
  const EventHashtags({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('필수 해시태그',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
      SizedBox(height: 15),
      Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8.0,
          children: List.generate(
              event.hashtagList.length,
              (index) => Chip(
                    avatar: CircleAvatar(
                      child: Icon(
                        Icons.tag,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.black,
                    ),
                    label: Text(event.hashtagList[index]),
                    labelPadding: const EdgeInsets.fromLTRB(6, 3, 7, 3),
                    elevation: 3.0,
                    backgroundColor: Colors.white,
                  )))
    ]);
  }
}
