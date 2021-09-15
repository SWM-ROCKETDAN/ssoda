import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/selected_store.dart';
import 'package:hashchecker/screens/create_store/components/intro.dart';
import 'package:hashchecker/screens/hall/hall_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/kakao_sign_in_button.dart';
import 'components/naver_sign_in_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/sign_in/hello.png'),
                        Text('시작하기',
                            style: TextStyle(
                                fontSize: 12.0, color: kLiteFontColor)),
                        SizedBox(height: kDefaultPadding / 2),
                        Text('안녕하세요, 사장님',
                            style: TextStyle(
                                fontSize: 26.0, fontWeight: FontWeight.bold))
                      ]),
                ),
                Container(
                  child: Column(
                    children: [
                      NaverSignInButton(
                        size: size,
                        signIn: naverLoginPressed,
                      ),
                      SizedBox(height: kDefaultPadding / 3 * 2),
                      KakaoSignInButton(
                        size: size,
                        signIn: kakaoLoginPressed,
                      ),
                      SizedBox(height: kDefaultPadding / 3 * 2),
                      Text('로그인 할 플랫폼을 선택해주세요!',
                          style:
                              TextStyle(fontSize: 12.0, color: kLiteFontColor)),
                    ],
                  ),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                ),
              ])),
    );
  }

  void naverLoginPressed() {
    signIn(getApi(API.NAVER_LOGIN));
  }

  void kakaoLoginPressed() {
    signIn(getApi(API.KAKAO_LOGIN));
  }

  Future<void> signIn(String api) async {
    final storage = new FlutterSecureStorage();
    try {
      // open login page & redirect auth code to back-end
      final url = Uri.parse('$api?redirect_uri=$kAppUrlScheme');

      // get callback data from back-end
      final result = await FlutterWebAuth.authenticate(
          url: url.toString(), callbackUrlScheme: kAppUrlScheme);

      // parsing accessToken & refreshToken from callback data
      final accessToken = Uri.parse(result).queryParameters['access-token'];
      final refreshToken = Uri.parse(result).queryParameters['refresh-token'];

      // save tokens on secure storage
      await storage.write(key: 'ACCESS_TOKEN', value: accessToken);
      await storage.write(key: 'REFRESH_TOKEN', value: refreshToken);
    } catch (e) {
      showLoginFailDialog(e.toString());
    }

    Widget nextScreen;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final selectedStore = prefs.getInt('selectedStore');
    if (selectedStore == null)
      nextScreen = CreateStoreIntroScreen();
    else
      nextScreen = HallScreen();

    Navigator.of(context).push(slidePageRouting(nextScreen));
  }

  void showLoginFailDialog(String errMsg) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Center(
                child: Text(
              "로그인 오류",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )),
            content: IntrinsicHeight(
              child: Column(children: [
                Text("로그인 도중 오류가 발생하였습니다.", style: TextStyle(fontSize: 14)),
                SizedBox(height: kDefaultPadding / 5),
                Text(errMsg, style: TextStyle(fontSize: 14)),
              ]),
            ),
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            actions: [
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('확인')),
              )
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))));
  }
}
