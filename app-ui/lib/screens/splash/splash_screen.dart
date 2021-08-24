import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import 'components/copyright.dart';
import 'components/logo.dart';

enum AniProps { size0, size1, size2, size3, size4, size5, color }

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _tween = TimelineTween<AniProps>()
      ..addScene(
              begin: 0.milliseconds,
              duration: 750.milliseconds,
              curve: Curves.fastOutSlowIn)
          .animate(AniProps.size0, tween: 0.0.tweenTo(size.width * 0.4))
      ..addScene(begin: 100.milliseconds, duration: 1.seconds, curve: Curves.fastOutSlowIn)
          .animate(AniProps.size1, tween: 0.0.tweenTo(size.width * 0.4))
      ..addScene(begin: 300.milliseconds, duration: 1.seconds, curve: Curves.fastOutSlowIn)
          .animate(AniProps.size2, tween: 0.0.tweenTo(size.width * 0.4))
      ..addScene(begin: 500.milliseconds, duration: 1.seconds, curve: Curves.fastOutSlowIn)
          .animate(AniProps.size3, tween: 0.0.tweenTo(size.width * 0.4))
      ..addScene(
              begin: 700.milliseconds,
              duration: 1.seconds,
              curve: Curves.fastOutSlowIn)
          .animate(AniProps.size4, tween: 0.0.tweenTo(size.width * 0.4))
      ..addScene(
              begin: 900.milliseconds,
              duration: 1.seconds,
              curve: Curves.fastOutSlowIn)
          .animate(AniProps.size5, tween: 0.0.tweenTo(size.width * 0.4))
      ..addScene(
              begin: 1900.milliseconds,
              duration: 500.milliseconds,
              curve: Curves.fastOutSlowIn)
          .animate(AniProps.color, tween: kScaffoldBackgroundColor.tweenTo(kLogoColor));
    return Scaffold(
      body: Container(
          color: kScaffoldBackgroundColor,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Logo(tween: _tween, size: size), Copyright()],
          )),
    );
  }
}
