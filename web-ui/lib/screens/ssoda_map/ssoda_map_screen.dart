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
  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Center(
            child: Text(
              '이벤트 리스트 페이지',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
