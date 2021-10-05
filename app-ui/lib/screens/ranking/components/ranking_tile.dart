import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:number_display/number_display.dart';

class RankingTile extends StatelessWidget {
  const RankingTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberDisplay = createDisplay();
    return Container(
      height: 85,
      margin: const EdgeInsets.symmetric(vertical: 10),
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
                    height: 85,
                    width: 85 / 3 * 4.01,
                    child: Stack(
                      children: [
                        ClipRRect(
                          child: Image.network(
                            'https://ssoda-bucket.s3.ap-northeast-2.amazonaws.com/image/event/202110/1633271835601_image_cropper_1633271832843.jpg',
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(12)),
                        ),
                        Container(
                            decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              kScaffoldBackgroundColor,
                              kScaffoldBackgroundColor.withOpacity(0)
                            ],
                            begin: Alignment.centerRight,
                            end: Alignment.center,
                          ),
                        )),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    /*
                          Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: kShadowColor,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/icon/icon.png'),
                                      fit: BoxFit.cover))),*/
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('이벤트를 진행 중인 가게 명',
                            style:
                                TextStyle(color: kLiteFontColor, fontSize: 10)),
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
                                        color: kLiteFontColor, fontSize: 10)),
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
                                        color: kLiteFontColor, fontSize: 10)),
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
    );
  }
}
