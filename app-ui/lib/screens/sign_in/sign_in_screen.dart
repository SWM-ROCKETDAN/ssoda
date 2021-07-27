import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

import 'components/kakao_sign_in_button.dart';
import 'components/naver_sign_in_button.dart';

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isLogin = false;

  String? accesToken;

  String? expiresAt;

  String? tokenType;

  String? name;

  String? refreshToken;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            child: Column(children: [
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                    Column(
                      children: <Widget>[
                        new Text('isLogin: $isLogin\n'),
                        new Text('accessToken: $accesToken\n'),
                        new Text('tokenType: $tokenType\n'),
                        new Text('user: $name\n'),
                      ],
                    ),
                    ElevatedButton(
                        key: null,
                        onPressed: buttonLoginPressed,
                        child: Text(
                          "LogIn",
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontFamily: "Roboto"),
                        )),
                    ElevatedButton(
                        key: null,
                        onPressed: buttonLogoutPressed,
                        child: Text(
                          "LogOut",
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontFamily: "Roboto"),
                        )),
                    ElevatedButton(
                        key: null,
                        onPressed: buttonTokenPressed,
                        child: Text(
                          "GetToken",
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontFamily: "Roboto"),
                        )),
                    ElevatedButton(
                        key: null,
                        onPressed: buttonGetUserPressed,
                        child: Text(
                          "GetUser",
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontFamily: "Roboto"),
                        ))
                  ])),
              Column(
                children: [
                  NaverSignInButton(size: size),
                  SizedBox(height: kDefaultPadding / 3 * 2),
                  KakaoSignInButton(size: size),
                ],
              ),
            ])),
      ),
    );
  }

  Future<void> buttonLoginPressed() async {
    NaverLoginResult res = await FlutterNaverLogin.logIn();
    setState(() {
      name = res.account.nickname;
      isLogin = true;
    });
    buttonTokenPressed();
    buttonGetUserPressed();
  }

  Future<void> buttonTokenPressed() async {
    NaverAccessToken res = await FlutterNaverLogin.currentAccessToken;
    setState(() {
      accesToken = res.accessToken;
      tokenType = res.tokenType;
    });
  }

  Future<void> buttonLogoutPressed() async {
    FlutterNaverLogin.logOut();
    setState(() {
      isLogin = false;
      accesToken = null;
      tokenType = null;
      name = null;
    });
  }

  Future<void> buttonGetUserPressed() async {
    NaverAccountResult res = await FlutterNaverLogin.currentAccount();
    setState(() {
      name = res.name;
    });
  }
}
