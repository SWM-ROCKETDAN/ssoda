import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';

class Create extends StatelessWidget {
  const Create({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      width: size.width,
      height: size.height - kToolbarHeight - statusBarHeight,
      color: kThemeColor.withOpacity(0.033),
      padding: const EdgeInsets.fromLTRB(20, 20 + kToolbarHeight, 20, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText.rich(
            TextSpan(children: [
              TextSpan(text: '이벤트를 생성하면\n'),
              TextSpan(
                  text: '쏘다',
                  style: TextStyle(
                      color: kThemeColor, fontWeight: FontWeight.w900)),
              TextSpan(text: '가 '),
              TextSpan(
                  text: 'QR 코드',
                  style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.w900)),
              TextSpan(text: '를 드려요!'),
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
            '이벤트 정보를 입력하면 이벤트 템플릿이 생성되고\n이벤트 참여 웹페이지의 QR 코드가 발급됩니다',
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
