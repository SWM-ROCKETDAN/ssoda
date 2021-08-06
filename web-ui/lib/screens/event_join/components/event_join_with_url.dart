import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/models/event.dart';

class EventJoinWithUrl extends StatefulWidget {
  final Event event;
  const EventJoinWithUrl({Key? key, required this.event}) : super(key: key);

  @override
  _EventJoinWithUrlState createState() => _EventJoinWithUrlState();
}

class _EventJoinWithUrlState extends State<EventJoinWithUrl> {
  @override
  Widget build(BuildContext context) {
    final _urlController = new TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('이벤트 참여하기',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        SizedBox(height: kDefaultPadding),
        TextField(
          controller: _urlController,
          style: TextStyle(fontSize: 14),
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.link),
              hintText: '인스타그램 게시글 URL을 붙여넣기 해주세요!',
              contentPadding: const EdgeInsets.all(8),
              isDense: true),
        ),
        SizedBox(height: kDefaultPadding / 3),
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: ElevatedButton(
                onPressed: () {}, child: Text('URL 업로드하고 이벤트 참여하기'))),
        SizedBox(height: kDefaultPadding),
        Row(
          children: [
            Icon(
              Icons.help_outline,
              color: Colors.black54,
              size: 16,
            ),
            Text(' 참여 방법',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black54)),
          ],
        ),
        SizedBox(height: kDefaultPadding / 3),
        RichText(
            text: TextSpan(children: [
          TextSpan(text: '1. 조건에 맞춰 인스타그램에 게시글을 작성\n'),
          TextSpan(text: '2. 작성한 '),
          TextSpan(
              text: '게시글의 링크', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '를 복사-붙여넣기하여 업로드\n'),
          TextSpan(text: '3. 조건 달성률에 따라 이벤트 상품 즉시 지급!')
        ], style: TextStyle(color: Colors.black54, fontSize: 13))),
      ],
    );
  }
}
