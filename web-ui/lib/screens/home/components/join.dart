import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hashchecker_web/constants.dart';

class Join extends StatelessWidget {
  const Join({Key? key, required this.scrollController}) : super(key: key);
  final scrollController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return GestureDetector(
      onTap: () {
        scrollController.animateTo(size.height * 2 + kToolbarHeight,
            duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
      },
      child: Container(
          width: size.width,
          height: size.height,
          color: kThemeColor.withOpacity(0.067),
          padding: const EdgeInsets.fromLTRB(20, 20 + kToolbarHeight, 20, 20),
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
                    TextSpan(text: '번거로웠던 '),
                    TextSpan(
                        text: '게시글 검사',
                        style: TextStyle(
                            color: Colors.pinkAccent.shade200,
                            fontWeight: FontWeight.w800)),
                    TextSpan(text: '\n이제 '),
                    TextSpan(
                        text: '쏘다',
                        style: TextStyle(
                            color: kThemeColor, fontWeight: FontWeight.w900)),
                    TextSpan(text: '에게 맡기세요!'),
                  ]),
                  style: TextStyle(
                      color: kDefaultFontColor,
                      fontSize: 24,
                      height: 1.2,
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
                Container(
                    height: size.height * 0.6,
                    margin: const EdgeInsets.all(20),
                    child: Image.asset('assets/images/home/intro.png')),
              ],
            ),
          ))),
    );
  }
}
