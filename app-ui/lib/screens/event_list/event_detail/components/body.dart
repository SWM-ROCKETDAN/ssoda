import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/models/selected_store.dart';
import 'package:provider/provider.dart';

import 'event_description.dart';
import 'header_with_images.dart';
import 'event_title.dart';
import 'event_rewards.dart';
import 'event_hashtags.dart';
import 'event_requirements.dart';
import 'event_period.dart';
import 'close_detail_button.dart';

class Body extends StatelessWidget {
  final Event event;
  const Body({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storeId = context.read<SelectedStore>().id;
    return SingleChildScrollView(
        child: Column(
      children: [
        HeaderWithImages(storeId: storeId, event: event),
        SizedBox(height: kDefaultPadding / 4 * 3),
        EventTitle(event: event),
        SizedBox(height: kDefaultPadding),
        EventDescription(event: event),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(height: kDefaultPadding * 2, color: kShadowColor),
              EventRewards(event: event),
              Divider(height: kDefaultPadding * 2, color: kShadowColor),
              EventHashtags(event: event),
              Divider(height: kDefaultPadding * 2, color: kShadowColor),
              EventPeriod(event: event),
              Divider(height: kDefaultPadding * 2, color: kShadowColor),
              CloseDetailButton()
            ],
          ),
        ),
      ],
    ));
  }
}
