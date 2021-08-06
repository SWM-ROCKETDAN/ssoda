import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/models/event.dart';
import 'package:hashchecker_web/models/reward.dart';

class EventHashtags extends StatelessWidget {
  const EventHashtags({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('필수 해시태그',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          ElevatedButton(
            child: Text(
              '전체 복사',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              _copyHashtagsToClipboard(context);
            },
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.fromLTRB(20, 10, 20, 10)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.black.withOpacity(0.8)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(27)))),
          ),
        ],
      ),
      SizedBox(height: kDefaultPadding),
      Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8.0,
          children: List.generate(
              data['event'].hashtagList.length,
              (index) => Chip(
                    avatar: CircleAvatar(
                      radius: 14,
                      child: Icon(
                        Icons.tag,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: Colors.black.withOpacity(0.8),
                    ),
                    label: Text(data['event'].hashtagList[index]),
                    labelPadding: const EdgeInsets.fromLTRB(6, 2, 5, 2),
                    elevation: 3.0,
                    backgroundColor: Colors.white,
                  )))
    ]);
  }

  void _copyHashtagsToClipboard(BuildContext context) {
    String hashtags = "";
    for (int i = 0; i < data['event'].hashtagList.length; i++)
      hashtags += '#${data['event'].hashtagList[i]} ';

    Clipboard.setData(ClipboardData(text: hashtags));

    final snackBar = SnackBar(
      content: Text('해시태그 목록이 전부 클립보드에 복사되었습니다.'),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 2500),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
