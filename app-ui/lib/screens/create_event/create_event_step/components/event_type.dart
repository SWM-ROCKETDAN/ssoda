import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class EventType extends StatefulWidget {
  const EventType({Key? key}) : super(key: key);

  @override
  _EventTypeState createState() => _EventTypeState();
}

class _EventTypeState extends State<EventType> {
  var _isRandomSelected = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '이벤트 종류를 선택해주세요',
            style: TextStyle(
                height: 1.2,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kDefaultFontColor),
          ),
          SizedBox(height: kDefaultPadding * 2),
          SizedBox(
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.75,
                  height: size.height * 0.2,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _isRandomSelected = false;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/images/podium.png',
                            width: size.width * 0.12,
                            color: _isRandomSelected
                                ? kLiteFontColor
                                : kThemeColor),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '맞춤형 상품',
                              style: TextStyle(
                                  color: _isRandomSelected
                                      ? kLiteFontColor
                                      : kThemeColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: kDefaultPadding / 5),
                            Text('마케팅 기여도가 높은 고객일수록\n높은 단계의 상품을 지급합니다',
                                style: TextStyle(
                                    color: _isRandomSelected
                                        ? kLiteFontColor
                                        : kThemeColor,
                                    fontSize: 10),
                                textAlign: TextAlign.center)
                          ],
                        )
                      ],
                    ),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0))),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            kScaffoldBackgroundColor),
                        overlayColor: MaterialStateProperty.all<Color>(
                            kThemeColor.withOpacity(0.2)),
                        side: MaterialStateProperty.all<BorderSide>(BorderSide(
                            color: _isRandomSelected
                                ? kLiteFontColor
                                : kThemeColor))),
                  ),
                ),
                SizedBox(height: kDefaultPadding * 1.5),
                SizedBox(
                  width: size.width * 0.75,
                  height: size.height * 0.2,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _isRandomSelected = true;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/images/roulette.png',
                            width: size.width * 0.12,
                            color: !_isRandomSelected
                                ? kLiteFontColor
                                : kThemeColor),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '랜덤 상품',
                              style: TextStyle(
                                  color: !_isRandomSelected
                                      ? kLiteFontColor
                                      : kThemeColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: kDefaultPadding / 5),
                            Text('상품 보유 수량에 기반한 확률로\n랜덤 단계의 상품을 지급합니다',
                                style: TextStyle(
                                    color: !_isRandomSelected
                                        ? kLiteFontColor
                                        : kThemeColor,
                                    fontSize: 10),
                                textAlign: TextAlign.center)
                          ],
                        )
                      ],
                    ),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0))),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            kScaffoldBackgroundColor),
                        overlayColor: MaterialStateProperty.all<Color>(
                            kThemeColor.withOpacity(0.2)),
                        side: MaterialStateProperty.all<BorderSide>(BorderSide(
                            color: !_isRandomSelected
                                ? kLiteFontColor
                                : kThemeColor))),
                  ),
                )
              ],
            ),
          )
        ]);
  }
}
