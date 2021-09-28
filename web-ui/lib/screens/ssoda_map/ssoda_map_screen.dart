import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/screens/reward_get/reward_get_screen.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SsodaMapScreen extends StatefulWidget {
  const SsodaMapScreen({Key? key}) : super(key: key);

  @override
  _SsodaMapScreenState createState() => _SsodaMapScreenState();
}

class _SsodaMapScreenState extends State<SsodaMapScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      child: Center(
        child: Text(
          'SSODA\nSNS 해시태그 이벤트 마케팅 매니저',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: kThemeColor),
        ),
      ),
    ));
  }
}
