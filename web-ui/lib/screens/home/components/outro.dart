import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';

class Outro extends StatelessWidget {
  const Outro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      width: size.width,
      height: size.height - kToolbarHeight - statusBarHeight,
      color: kDefaultFontColor,
      padding: const EdgeInsets.fromLTRB(40, 40 + kToolbarHeight, 40, 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText.rich(
            TextSpan(children: [
              TextSpan(text: '사장님, 이제\n'),
              TextSpan(
                  text: '쏘다',
                  style: TextStyle(
                      color: kLogoColor, fontWeight: FontWeight.w900)),
              TextSpan(text: '로 쏘세요'),
            ]),
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.3,
                  height: size.width * 0.3,
                  child: Image.asset('assets/images/home/icon.png'),
                ),
                SizedBox(height: kDefaultPadding * 3),
                Container(
                  width: size.width * 0.4,
                  child:
                      Image.asset('assets/images/home/google-play-badge.png'),
                ),
                SizedBox(height: kDefaultPadding / 2),
                Container(
                  width: size.width * 0.4,
                  child: Image.asset('assets/images/home/app-store-badge.png'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
