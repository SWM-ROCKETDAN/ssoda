import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/naver_sign_in.dart';

import 'components/kakao_sign_in_button.dart';
import 'components/naver_sign_in_button.dart';

import 'dart:async';

import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final NaverSignIn naverSignIn = NaverSignIn(
      isLogin: false,
      accessToken: null,
      expiresAt: null,
      tokenType: null,
      refreshToken: null,
      accountInfo: AccountInfo(name: null, email: null));

  String? callbackResponse;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('네이버 SDK 로그인',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24)),
                      SizedBox(height: 5),
                      Text('isLogin: ${naverSignIn.isLogin}'),
                      SizedBox(height: 5),
                      Text('accessToken: ${naverSignIn.accessToken}'),
                      SizedBox(height: 5),
                      Text('tokenType: ${naverSignIn.tokenType}'),
                      SizedBox(height: 5),
                      Text('expiresAt: ${naverSignIn.expiresAt}'),
                      SizedBox(height: 5),
                      Text('userName: ${naverSignIn.accountInfo!.name}'),
                      SizedBox(height: 5),
                      Text('userEmail: ${naverSignIn.accountInfo!.email}'),
                      SizedBox(height: 30),
                      Text('네이버 해경 로그인',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24)),
                      SizedBox(height: 5),
                      Text('callbackResponse: $callbackResponse'),
                    ],
                  )),
                  Column(
                    children: [
                      NaverSignInButton(
                        size: size,
                        signIn: naverSignInPressed,
                        signOut: naverSignOutPressed,
                        isLogin: naverSignIn.isLogin,
                      ),
                      SizedBox(height: kDefaultPadding / 3 * 2),
                      KakaoSignInButton(size: size),
                      SizedBox(height: kDefaultPadding / 3 * 2),
                      SizedBox(
                        width: size.width,
                        child: ElevatedButton(
                            onPressed: () async {
                              final result = await FlutterWebAuth.authenticate(
                                  url:
                                      "http://ec2-3-37-85-236.ap-northeast-2.compute.amazonaws.com:8080/oauth2/authorization/naver",
                                  callbackUrlScheme:
                                      'com.rocketdan.hashchecker');
                              print(result);
                              setState(() {
                                callbackResponse = result;
                              });

// Extract token from resulting url
                            },
                            child: Text('해경 로그인')),
                      ),
                    ],
                  ),
                ])),
      ),
    );
  }

  Future<void> naverSignInPressed() async {
    NaverLoginResult res = await FlutterNaverLogin.logIn();
    setState(() {
      naverSignIn.isLogin = true;
    });
    getNaverToken();
    getNaverUser();
  }

  Future<void> getNaverToken() async {
    NaverAccessToken res = await FlutterNaverLogin.currentAccessToken;
    setState(() {
      naverSignIn.accessToken = res.accessToken;
      naverSignIn.tokenType = res.tokenType;
      naverSignIn.expiresAt = res.expiresAt;
    });
  }

  Future<void> naverSignOutPressed() async {
    FlutterNaverLogin.logOut();
    setState(() {
      naverSignIn.isLogin = false;
      naverSignIn.accessToken = null;
      naverSignIn.tokenType = null;
      naverSignIn.expiresAt = null;
      naverSignIn.accountInfo!.name = null;
      naverSignIn.accountInfo!.email = null;
    });
  }

  Future<void> getNaverUser() async {
    NaverAccountResult res = await FlutterNaverLogin.currentAccount();
    setState(() {
      naverSignIn.accountInfo!.name = res.name;
      naverSignIn.accountInfo!.email = res.email;
    });
  }
}
