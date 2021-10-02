import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';

class Report extends StatelessWidget {
  const Report({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      width: size.width,
      height: size.height,
      color: kThemeColor.withOpacity(0.1),
      padding: const EdgeInsets.fromLTRB(20, 20 + kToolbarHeight, 20, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText.rich(
            TextSpan(children: [
              TextSpan(text: '이벤트 마케팅 성과도\n'),
              TextSpan(
                  text: '쏘다',
                  style: TextStyle(
                      color: kThemeColor, fontWeight: FontWeight.w900)),
              TextSpan(text: '에서 '),
              TextSpan(text: '바로 확인하세요!'),
            ]),
            style: TextStyle(
                color: kDefaultFontColor,
                fontSize: 24,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          SizedBox(height: kDefaultPadding / 2),
          AutoSizeText(
            '이벤트 참여 기록과 참여자 정보를 종합하여\n마케팅 성과 보고서를 실시간으로 제공합니다',
            style: TextStyle(color: kLiteFontColor, fontSize: 12),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          SizedBox(height: kDefaultPadding),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset('assets/images/home/intro.png')))
        ],
      ),
    );
  }
}
