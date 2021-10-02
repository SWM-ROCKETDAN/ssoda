import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Outro extends StatelessWidget {
  const Outro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      width: size.width,
      height: size.height,
      color: kDefaultFontColor,
      padding: const EdgeInsets.fromLTRB(40, 40 + kToolbarHeight, 40, 40),
      child: AnimationLimiter(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 750),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 75,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
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
                        color: Colors.white,
                        fontSize: 28,
                        height: 1.4,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  SizedBox(height: size.width * 0.25),
                  Container(
                    child: Image.asset(
                      'assets/images/home/icon.png',
                      width: size.width * 0.3,
                      height: size.width * 0.3,
                    ),
                  ),
                  SizedBox(height: size.width * 0.1),
                  GestureDetector(
                    onTap: () async {
                      await canLaunch(kGooglePlayStoreDownloadUrl)
                          ? await launch(kGooglePlayStoreDownloadUrl)
                          : throw '구글 플레이 스토어에 연결할 수 없습니다.';
                    },
                    child: Container(
                      width: size.width * 0.4,
                      child: Image.asset(
                          'assets/images/home/google-play-badge.png'),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding / 2),
                  Container(
                    width: size.width * 0.4,
                    child:
                        Image.asset('assets/images/home/app-store-badge.png'),
                  ),
                  SizedBox(height: size.width * 0.33),
                ],
              ))),
    );
  }
}
