import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:number_display/number_display.dart';

class FirstRankingTile extends StatelessWidget {
  const FirstRankingTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberDisplay = createDisplay();
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
        child: Stack(children: [
          Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: kShadowColor,
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(3, 3), // changes position of shadow
                  ),
                ],
                color: kScaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(12)),
            child: Material(
              color: Colors.white.withOpacity(0.0),
              child: InkWell(
                onTap: () {},
                highlightColor: kShadowColor,
                overlayColor: MaterialStateProperty.all<Color>(kShadowColor),
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Container(
                              height: size.height * 0.075,
                              width: size.height * 0.075,
                              decoration: BoxDecoration(
                                  color: kShadowColor,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/icon/icon.png'),
                                      fit: BoxFit.cover))),
                          SizedBox(height: kDefaultPadding / 2),
                          Text('이벤트를 진행 중인 가게 명',
                              style: TextStyle(
                                  color: kLiteFontColor, fontSize: 12)),
                          SizedBox(height: kDefaultPadding / 7.5),
                          Text('진행 중인 이벤트 제목',
                              style: TextStyle(
                                  color: kDefaultFontColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          SizedBox(height: kDefaultPadding / 2),
                          Container(
                            height: 15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(children: [
                                  Icon(
                                    Icons.attach_money_rounded,
                                    size: 14,
                                    color: Colors.blueGrey,
                                  ),
                                  Text(
                                    '${numberDisplay(1234)}원',
                                    style: TextStyle(
                                        color: kLiteFontColor, fontSize: 12),
                                  ),
                                ]),
                                VerticalDivider(
                                  width: kDefaultPadding,
                                  color: kShadowColor.withOpacity(0.6),
                                ),
                                Row(children: [
                                  Icon(
                                    Icons.group_rounded,
                                    size: 14,
                                    color: Colors.blueGrey,
                                  ),
                                  SizedBox(width: kDefaultPadding / 3),
                                  Text('${numberDisplay(1234)}명',
                                      style: TextStyle(
                                          color: kLiteFontColor, fontSize: 12)),
                                ]),
                                VerticalDivider(
                                  width: kDefaultPadding,
                                  color: kShadowColor.withOpacity(0.6),
                                ),
                                Row(children: [
                                  Icon(
                                    Icons.favorite_rounded,
                                    size: 14,
                                    color: Colors.blueGrey,
                                  ),
                                  SizedBox(width: kDefaultPadding / 3),
                                  Text('${numberDisplay(1234)}개',
                                      style: TextStyle(
                                          color: kLiteFontColor, fontSize: 12)),
                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              left: 0,
              top: 5,
              child: Image.asset('assets/images/ranking/1.png',
                  width: size.width * 0.15, height: size.width * 0.15)),
        ]),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://ssoda-bucket.s3.ap-northeast-2.amazonaws.com/image/event/202110/1633271835601_image_cropper_1633271832843.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  kScaffoldBackgroundColor.withOpacity(0.25),
                  BlendMode.luminosity)),
        ));
  }
}
