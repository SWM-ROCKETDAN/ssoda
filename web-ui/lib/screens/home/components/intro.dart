import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      width: size.width,
      height: size.height,
      color: kScaffoldBackgroundColor,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText.rich(
            TextSpan(children: [
              TextSpan(text: '"SNS 이벤트 마케팅"\n'),
              TextSpan(text: '이제 '),
              TextSpan(
                  text: '쏘다',
                  style: TextStyle(
                      color: kThemeColor, fontWeight: FontWeight.w900)),
              TextSpan(text: '로 직접 하세요!'),
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
            '쏘다는 사장님들을 위한 SNS 해시태그\n마케팅 자동화 매니저입니다',
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
