import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';

class SsodaMapScreen extends StatelessWidget {
  const SsodaMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Image.asset(
                'assets/images/home/icon.png',
                width: size.width * 0.3,
                height: size.height * 0.3,
              ),
              SizedBox(height: kDefaultPadding),
              AutoSizeText.rich(
                TextSpan(children: [
                  TextSpan(text: '위치 기반 SNS 이벤트 진행 매장 정보 제공 서비스\n'),
                  TextSpan(
                      text: '쏘다맵',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: kThemeColor)),
                  TextSpan(text: '은 현재 개발 중입니다.\n조금만 기다려주세요!')
                ]),
                textAlign: TextAlign.center,
                maxLines: 3,
                minFontSize: 8,
                style: TextStyle(
                    color: kDefaultFontColor, height: 1.4, fontSize: 13),
              ),
            ])),
      ),
    );
  }
}
