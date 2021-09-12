import 'package:flutter/material.dart';

const kThemeColor = Color(0xFF0071f1);
const kScaffoldBackgroundColor = Color(0xFFfdfdfe);
final kShadowColor = Color(0xFF90a0b8).withOpacity(0.3);
const kDefaultFontColor = Color(0xFF001024);
const kLiteFontColor = Color(0xFF848c97);
const kLogoColor = Color(0xFF0088ff);
const kDefaultPadding = 15.0;
const kDefaultNumberSliderDuration = Duration(seconds: 2);
const kAppUrlScheme = 'com.rocketdan.hashchecker';
final kNewImagePrefix = 'HASHCHECKER_NEW_IMAGE';

Route slidePageRouting(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.fastOutSlowIn;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
