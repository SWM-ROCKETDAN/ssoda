import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class Copyright extends StatelessWidget {
  const Copyright({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Copyright ⓒ 2021 Rocketdan All rights reserved.',
      style: TextStyle(fontSize: 12, color: kLiteFontColor),
    );
  }
}
