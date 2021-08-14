import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

import 'event_hashtags.dart';
import 'event_image.dart';
import 'event_period.dart';
import 'event_require.dart';
import 'event_reward.dart';
import 'event_template.dart';
import 'event_title.dart';
import 'step_help.dart';
import 'step_text.dart';

class StepField extends StatelessWidget {
  final step;
  final event;
  const StepField({Key? key, required this.step, required this.event})
      : super(key: key);

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StepText(step: step),
              if (step != 3 && step != 5 && step != 6) StepHelp(step: step)
            ]),
        SizedBox(height: kDefaultPadding),
        _getStepComponents(step),
      ],
    );
  }

  Widget _getStepComponents(int step) {
    switch (step) {
      case 0:
        return EventTitle(event: event);
      case 1:
        return EventReward(event: event);
      case 2:
        return EventHashtags(event: event);
      case 3:
        return EventPeriod(event: event);
      case 4:
        return EventImage(event: event);
      case 5:
        return EventRequire(event: event);
      case 6:
        return EventTemplate(event: event);
      default:
        return Container(child: Text('유효하지 않은 단계입니다.'));
    }
  }
}
