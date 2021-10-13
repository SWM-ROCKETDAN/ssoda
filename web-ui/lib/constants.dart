import 'package:flutter/material.dart';

const kThemeColor = Color(0xFF0071f1);
const kScaffoldBackgroundColor = Color(0xFFfdfdfe);
final kShadowColor = Color(0xFF90a0b8).withOpacity(0.3);
const kDefaultFontColor = Color(0xFF001024);
const kLiteFontColor = Color(0xFF848c97);
const kLogoColor = Color(0xFF0088ff);
const kDefaultPadding = 15.0;
const kDefaultNumberSliderDuration = Duration(seconds: 2);
const kGooglePlayStoreDownloadUrl =
    'https://play.google.com/store/apps/details?id=com.rocketdan.ssoda';

Widget buildErrorPage({String? message}) {
  return Center(
    child: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Icon(Icons.wifi_off_rounded, color: kDefaultFontColor),
          SizedBox(height: kDefaultPadding),
          Text(message ?? '정보를 가져올 수 없습니다.\n인터넷 연결 상태를 확인해주세요.',
              textAlign: TextAlign.center,
              style: TextStyle(height: 1.2, color: kLiteFontColor))
        ])),
  );
}
