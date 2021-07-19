import 'package:flutter/material.dart';
import 'package:hashchecker/models/event.dart';

import 'header_with_images.dart';
import 'event_title.dart';
import 'event_rewards.dart';
import 'event_hashtags.dart';
import 'event_requirements.dart';
import 'event_period.dart';
import 'create_event_button.dart';

class Body extends StatelessWidget {
  final Event event;
  const Body({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
        child: Column(
      children: [
        HeaderWithImages(size: size, event: event),
        SizedBox(height: 30),
        EventTitle(event: event),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(height: 30),
              EventRewards(event: event),
              Divider(height: 30),
              EventHashtags(event: event),
              Divider(height: 30),
              EventRequirements(event: event),
              Divider(height: 30),
              EventPeriod(event: event),
              Divider(height: 30),
              CreateEventButton()
            ],
          ),
        ),
      ],
    ));
  }
}
