import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';

class Join extends StatelessWidget {
  const Join({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      width: size.width,
      height: size.height - kToolbarHeight - statusBarHeight,
      color: kThemeColor.withOpacity(0.067),
      padding: const EdgeInsets.fromLTRB(20, 20 + kToolbarHeight, 20, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText.rich(
            TextSpan(children: [
              TextSpan(text: '이벤트 참여 확인도\n'),
              TextSpan(
                  text: '쏘다',
                  style: TextStyle(
                      color: kThemeColor, fontWeight: FontWeight.w900)),
              TextSpan(text: '에게 '),
              TextSpan(text: '맡기세요!'),
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
            '고객이 올린 게시글을 자동으로 검사하고\n비정상적인 경우엔 상품을 제공하지 않습니다',
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
