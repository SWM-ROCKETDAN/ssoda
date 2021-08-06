import 'package:flutter/material.dart';
import 'components/body.dart';

class RewardGetScreen extends StatelessWidget {
  final eventTitle;
  final rewardName;
  final rewardImage;
  const RewardGetScreen(
      {Key? key,
      required this.eventTitle,
      required this.rewardName,
      required this.rewardImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Body(
            size: size,
            eventTitle: eventTitle,
            rewardName: rewardName,
            rewardImage: rewardImage));
  }
}
