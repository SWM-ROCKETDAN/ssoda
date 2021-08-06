import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker_web/models/event.dart';
import 'package:hashchecker_web/models/reward.dart';

class EventDescription extends StatelessWidget {
  const EventDescription({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AutoSizeText.rich(
        TextSpan(children: [
          TextSpan(text: '인스타그램에 #해시태그와 함께 글 남기고\n'),
          TextSpan(
              text: _createRewardNameList(),
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: ' 받아가세요!')
        ]),
        textAlign: TextAlign.center,
        maxLines: 2,
      ),
    );
  }

  String _createRewardNameList() {
    String rewardNameList = "";
    for (int i = 0; i < data['rewards'].length; i++) {
      rewardNameList += data['rewards'][i].name;
      if (i < data['rewards'].length - 1) rewardNameList += " / ";
    }
    return rewardNameList;
  }
}
