import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';

import 'done_button.dart';
import 'header_with_reward.dart';
import 'message_field.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      HeaderWithReward(size: size),
      SizedBox(height: kDefaultPadding),
      MessageField(),
      DoneButton()
    ]);
  }
}
