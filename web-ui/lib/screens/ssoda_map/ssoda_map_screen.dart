import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';

class SsodaMapScreen extends StatelessWidget {
  const SsodaMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: kScaffoldBackgroundColor,
        child: Text('SSODA',
            style: TextStyle(
                color: kThemeColor,
                fontSize: 24,
                fontWeight: FontWeight.bold)));
  }
}
