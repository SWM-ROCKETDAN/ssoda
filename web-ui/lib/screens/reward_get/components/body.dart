import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';

import 'done_button.dart';
import 'header_with_reward.dart';
import 'message_field.dart';

class Body extends StatelessWidget {
  final eventTitle;
  final rewardName;
  final rewardImage;
  const Body(
      {Key? key,
      required this.size,
      required this.eventTitle,
      required this.rewardName,
      required this.rewardImage})
      : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      HeaderWithReward(size: size, rewardImagePath: rewardImage),
      SizedBox(height: kDefaultPadding),
      MessageField(eventTitle: eventTitle, rewardName: rewardName),
      DoneButton()
    ]);
  }
}
