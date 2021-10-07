import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:number_display/number_display.dart';

class RankingTile extends StatelessWidget {
  const RankingTile({Key? key, required this.ranking}) : super(key: key);

  final ranking;
  @override
  Widget build(BuildContext context) {
    final numberDisplay = createDisplay();
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Stack(children: [
        Container(
          height: size.height * 0.12,
          margin: const EdgeInsets.fromLTRB(20, 15, 20, 15),
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
              child: Stack(
                children: [
                  Positioned(
                      left: 0,
                      child: Container(
                        child: Stack(
                          children: [
                            Container(
                                height: size.height * 0.12,
                                width: size.width * 0.37,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://ssoda-bucket.s3.ap-northeast-2.amazonaws.com/image/event/202110/1633271835601_image_cropper_1633271832843.jpg'),
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                            kScaffoldBackgroundColor
                                                .withOpacity(0.25),
                                            BlendMode.luminosity)),
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(12)))),
                            Container(
                                height: size.height * 0.12,
                                width: size.width * 0.371,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      kScaffoldBackgroundColor,
                                      kScaffoldBackgroundColor.withOpacity(0)
                                    ],
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                  ),
                                )),
                          ],
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 15, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: size.height * 0.075,
                            width: size.height * 0.075,
                            decoration: BoxDecoration(
                                color: kShadowColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 8,
                                      offset: Offset(0, 0),
                                      color: kDefaultFontColor.withOpacity(0.2))
                                ],
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/icon/icon.png'),
                                    fit: BoxFit.cover))),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('이벤트를 진행 중인 가게 명',
                                style: TextStyle(
                                    color: kLiteFontColor, fontSize: 10)),
                            SizedBox(height: kDefaultPadding / 7.5),
                            Text('진행 중인 이벤트 제목',
                                style: TextStyle(
                                    color: kDefaultFontColor,
                                    fontWeight: FontWeight.bold)),
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
                                      size: 12,
                                      color: Colors.blueGrey,
                                    ),
                                    Text(
                                      '${numberDisplay(1234)}원',
                                      style: TextStyle(
                                          color: kLiteFontColor, fontSize: 10),
                                    ),
                                  ]),
                                  VerticalDivider(
                                    width: kDefaultPadding,
                                    color: kShadowColor.withOpacity(0.6),
                                  ),
                                  Row(children: [
                                    Icon(
                                      Icons.group_rounded,
                                      size: 12,
                                      color: Colors.blueGrey,
                                    ),
                                    SizedBox(width: kDefaultPadding / 3),
                                    Text('${numberDisplay(1234)}명',
                                        style: TextStyle(
                                            color: kLiteFontColor,
                                            fontSize: 10)),
                                  ]),
                                  VerticalDivider(
                                    width: kDefaultPadding,
                                    color: kShadowColor.withOpacity(0.6),
                                  ),
                                  Row(children: [
                                    Icon(
                                      Icons.favorite_rounded,
                                      size: 12,
                                      color: Colors.blueGrey,
                                    ),
                                    SizedBox(width: kDefaultPadding / 3),
                                    Text('${numberDisplay(1234)}개',
                                        style: TextStyle(
                                            color: kLiteFontColor,
                                            fontSize: 10)),
                                  ]),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        if (ranking < 3)
          Positioned(
              left: 2,
              top: 0,
              child: Image.asset('assets/images/ranking/${ranking + 1}.png',
                  width: size.width * 0.1, height: size.width * 0.1)),
      ]),
    );
  }
}
