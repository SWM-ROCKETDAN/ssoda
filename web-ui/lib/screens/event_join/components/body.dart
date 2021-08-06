import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/models/event.dart';
import 'package:hashchecker_web/models/reward.dart';
import 'package:hashchecker_web/screens/event_join/components/event_join_with_url.dart';

import 'event_description.dart';
import 'header_with_images.dart';
import 'event_title.dart';
import 'event_rewards.dart';
import 'event_hashtags.dart';
import 'event_requirements.dart';
import 'event_period.dart';

class Body extends StatelessWidget {
  final Map<String, dynamic> data;
  final id;
  const Body({Key? key, required this.data, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(data['rewards']);
    Size size = MediaQuery.of(context).size;

    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: data['event'].title,
    ));

    return SingleChildScrollView(
        child: Column(
      children: [
        HeaderWithImages(size: size, data: data),
        SizedBox(height: kDefaultPadding / 4 * 3),
        EventTitle(data: data),
        SizedBox(height: kDefaultPadding),
        EventDescription(data: data),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Divider(height: kDefaultPadding * 2),
            EventRewards(data: data),
            Divider(height: kDefaultPadding * 2),
            EventHashtags(data: data),
            Divider(height: kDefaultPadding * 2),
            EventRequirements(data: data),
            Divider(height: kDefaultPadding * 2),
            EventPeriod(data: data),
            Divider(height: kDefaultPadding * 2),
            EventJoinWithUrl(data: data, id: id)
          ]),
        ),
      ],
    ));
  }
}
