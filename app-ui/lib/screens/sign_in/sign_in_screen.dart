import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/token.dart';
import 'package:hashchecker/screens/hall/hall_screen.dart';
import 'package:provider/provider.dart';

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
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/sign_in/hello.png'),
                        SizedBox(height: kDefaultPadding),
                        Text('시작하기',
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold)),
                        SizedBox(height: kDefaultPadding),
                        Text('네이버 또는 카카오를 통해 로그인 해주세요.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 17.0, height: 1.2)),
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
                    ],
                  ),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                ),
              ])),
    );
  }

  Future<void> naverLoginPressed() async {
    try {
      final url = Uri.parse(
          'http://ec2-3-37-85-236.ap-northeast-2.compute.amazonaws.com:8080/oauth2/authorization/naver?redirect_uri=$kAppUrlScheme');

      final result = await FlutterWebAuth.authenticate(
          url: url.toString(), callbackUrlScheme: kAppUrlScheme);

      final accessToken = Uri.parse(result).queryParameters['token'];

      if (accessToken != null) {
        context.read<Token>().token = accessToken;
        Navigator.of(context).push(_routeToHallScreen());
      } else
        throw Exception;
    } catch (e) {
      showLoginFailDialog();
    }
  }

  Future<void> kakaoLoginPressed() async {}

  void showLoginFailDialog() {
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
                Text("네트워크 연결 상태를 확인해주세요.", style: TextStyle(fontSize: 14)),
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

Route _routeToHallScreen() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const HallScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
