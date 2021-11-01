import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class NaverSmartStoreScreen extends StatelessWidget {
  const NaverSmartStoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kScaffoldBackgroundColor,
        title: Text(
          '스토어 등록',
          style: TextStyle(color: kDefaultFontColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              width: size.width * 0.25,
              height: size.width * 0.22,
              child: ElevatedButton(
                onPressed: () {},
                child: Center(
                    child: Image.network(
                        'https://lh3.googleusercontent.com/proxy/Nwma6Q0q2vBcuDVHkFJmfwudYh_6hQTRo53reAzQaeRl8X3P-DjeOuUNFw9eV2ueZtgrojpiaabnlsnxgJL2p78WkgyWvZ5vcSa8-aEb7jpp_ICyQ_MpBKdRsX8ORyh2h7UA6km083K4ryDdx5TRcT_6yBU')),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.all(0)),
                    elevation: MaterialStateProperty.all<double>(0),
                    side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: kThemeColor, width: 2)),
                    overlayColor:
                        MaterialStateProperty.all<Color>(kShadowColor),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)))),
              ),
            ),
            SizedBox(
              width: kDefaultPadding,
            ),
            SizedBox(
              width: size.width * 0.25,
              height: size.width * 0.22,
              child: ElevatedButton(
                onPressed: () {},
                child: Center(
                    child: Image.network(
                        'https://blog.kakaocdn.net/dn/6ui8u/btqDtzRrCzg/ZM8q87L5frjEl0za6UnIk1/img.jpg')),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.all(0)),
                    elevation: MaterialStateProperty.all<double>(0),
                    side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: kLiteFontColor)),
                    overlayColor:
                        MaterialStateProperty.all<Color>(kShadowColor),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        kScaffoldBackgroundColor),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)))),
              ),
            ),
            SizedBox(
              width: kDefaultPadding,
            ),
            SizedBox(
              width: size.width * 0.25,
              height: size.width * 0.22,
              child: ElevatedButton(
                onPressed: () {},
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.public_rounded,
                        color: kLiteFontColor,
                        size: 20,
                      ),
                      SizedBox(
                        height: kDefaultPadding / 3,
                      ),
                      Text('개인 스토어',
                          style:
                              TextStyle(color: kLiteFontColor, fontSize: 12)),
                    ],
                  ),
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.all(0)),
                    elevation: MaterialStateProperty.all<double>(0),
                    side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: kLiteFontColor)),
                    overlayColor:
                        MaterialStateProperty.all<Color>(kShadowColor),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        kScaffoldBackgroundColor),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)))),
              ),
            ),
          ]),
          SizedBox(height: kDefaultPadding),
          SizedBox(
            width: size.width,
            height: 55,
            child: TextButton(
                onPressed: () {},
                child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/sign_in/naver_logo.png',
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                          color: Colors.white,
                        ),
                        Text(
                          '네이버 스마트 스토어',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' 시군요!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        )
                      ]),
                ),
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all<Color>(
                        Colors.white.withOpacity(0.1)),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.fromLTRB(20, 8, 20, 8)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF03C75A)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18))))),
          ),
          SizedBox(height: kDefaultPadding),
          Row(
            children: [
              Icon(Icons.check_circle_rounded, color: kThemeColor),
              SizedBox(width: kDefaultPadding),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: kShadowColor,

                          blurRadius: 4,
                          offset: Offset(2, 2), // changes position of shadow
                        ),
                      ],
                      color: kScaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    decoration: InputDecoration(
                        counterText: "",
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: kThemeColor, width: 1),
                            borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: kScaffoldBackgroundColor, width: 0),
                            borderRadius: BorderRadius.circular(12)),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        hintText: '가게 URL',
                        hintStyle: TextStyle(color: kLiteFontColor)),
                  ),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
