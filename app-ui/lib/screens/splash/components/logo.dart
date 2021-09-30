import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/screens/splash/splash_screen.dart';
import 'package:simple_animations/simple_animations.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
    required TimelineTween<AniProps> tween,
    required this.size,
  })  : _tween = tween,
        super(key: key);

  final TimelineTween<AniProps> _tween;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PlayAnimation<TimelineValue<AniProps>>(
          tween: _tween,
          duration: _tween.duration,
          builder: (context, child, value) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: size.width * 0.4,
                        width: size.width * 0.4,
                        child: Stack(children: [
                          Center(
                            child: Image.asset(
                                'assets/images/splash/logo_1.png',
                                width: value.get(AniProps.size0),
                                height: value.get(AniProps.size0)),
                          ),
                          Center(
                            child: Image.asset(
                                'assets/images/splash/logo_2.png',
                                width: value.get(AniProps.size1),
                                height: value.get(AniProps.size1)),
                          ),
                          Center(
                            child: Image.asset(
                                'assets/images/splash/logo_3.png',
                                width: value.get(AniProps.size2),
                                height: value.get(AniProps.size2)),
                          ),
                          Center(
                            child: Image.asset(
                                'assets/images/splash/logo_4.png',
                                width: value.get(AniProps.size3),
                                height: value.get(AniProps.size3)),
                          ),
                          Center(
                            child: Image.asset(
                                'assets/images/splash/logo_5.png',
                                width: value.get(AniProps.size4),
                                height: value.get(AniProps.size4)),
                          ),
                          Center(
                            child: Image.asset(
                                'assets/images/splash/logo_6.png',
                                width: value.get(AniProps.size5),
                                height: value.get(AniProps.size5)),
                          ),
                        ]),
                      ),
                    ),
                    AutoSizeText(
                      '우리가게 SNS 이벤트 마케팅 매니저',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: value.get(AniProps.color)),
                      maxLines: 1,
                    ),
                  ])),
    );
  }
}
