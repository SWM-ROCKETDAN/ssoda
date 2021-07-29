import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/kakao_sign_in.dart';
import 'package:hashchecker/models/naver_sign_in.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/user.dart';
import 'package:kakao_flutter_sdk/common.dart';

import 'components/kakao_sign_in_button.dart';
import 'components/naver_sign_in_button.dart';

import 'dart:async';

import 'package:flutter_naver_login/flutter_naver_login.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final NaverSignIn naverSignIn = NaverSignIn(
      isLogin: false,
      accessToken: null,
      accountInfo: NaverAccountInfo(name: null, email: null));

  final KakaoSignIn kakaoSignIn = KakaoSignIn(
      isLogin: false,
      authCode: null,
      accessToken: null,
      accountInfo: KakaoAccountInfo(name: null, email: null));

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
                      Text('userName: ${naverSignIn.accountInfo.name}'),
                      SizedBox(height: 5),
                      Text('userEmail: ${naverSignIn.accountInfo.email}'),
                      SizedBox(height: kDefaultPadding * 3),
                      Text('카카오 SDK 로그인',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24)),
                      SizedBox(height: 5),
                      Text('isLogin: ${kakaoSignIn.isLogin}'),
                      SizedBox(height: 5),
                      Text('accessToken: ${kakaoSignIn.accessToken}'),
                      SizedBox(height: 5),
                      Text('userName: ${kakaoSignIn.accountInfo.name}'),
                      SizedBox(height: 5),
                      Text('userEmail: ${kakaoSignIn.accountInfo.email}'),
                    ],
                  )),
                  Column(
                    children: [
                      NaverSignInButton(
                        size: size,
                        signIn: naverLoginPressed,
                        signOut: naverLogoutPressed,
                        isLogin: naverSignIn.isLogin,
                      ),
                      SizedBox(height: kDefaultPadding / 3 * 2),
                      KakaoSignInButton(
                        size: size,
                        signIn: kakaoLoginPressed,
                        isLogin: kakaoSignIn.isLogin,
                      ),
                      SizedBox(height: kDefaultPadding / 3 * 2),
                    ],
                  ),
                ])),
      ),
    );
  }

  Future<void> naverLoginPressed() async {
    // try login
    NaverLoginResult loginResult = await FlutterNaverLogin.logIn();

    // on login success
    if (loginResult.status == NaverLoginStatus.loggedIn) {
      // get token
      NaverAccessToken token = await FlutterNaverLogin.currentAccessToken;

      // get account info
      NaverAccountResult account = await FlutterNaverLogin.currentAccount();

      // set state
      setState(() {
        naverSignIn.isLogin = true;
        naverSignIn.accessToken = token.accessToken;
        naverSignIn.accountInfo.name = account.name;
        naverSignIn.accountInfo.email = account.email;
      });

      // on login error
    } else if (loginResult.status == NaverLoginStatus.error) {
      print('${loginResult.errorMessage}');
    }
  }

  Future<void> naverLogoutPressed() async {
    FlutterNaverLogin.logOut();
    setState(() {
      naverSignIn.isLogin = false;
      naverSignIn.accessToken = null;
      naverSignIn.accountInfo.name = null;
      naverSignIn.accountInfo.email = null;
    });
  }

  Future<void> kakaoLoginPressed() async {
    try {
      // check if is kakaotalk installed
      final installed = await isKakaoTalkInstalled();

      // login & get auth code via kakaotalk app
      if (installed) {
        await UserApi.instance.loginWithKakaoTalk();

        kakaoSignIn.authCode = await AuthCodeClient.instance.requestWithTalk();

        // login & get auth code kakao web
      } else {
        await UserApi.instance.loginWithKakaoAccount();

        kakaoSignIn.authCode = await AuthCodeClient.instance.request();
      }

      print(kakaoSignIn.authCode);
      // get token
      AccessTokenResponse token =
          await AuthApi.instance.issueAccessToken(kakaoSignIn.authCode!);

      // store access token for requesting api future
      AccessTokenStore.instance.toStore(token);

      // get account info
      User user = await UserApi.instance.me();

      // set state
      setState(() {
        kakaoSignIn.isLogin = true;
        kakaoSignIn.accessToken = token.accessToken;
        kakaoSignIn.accountInfo.name = user.kakaoAccount!.profile!.nickname;
        kakaoSignIn.accountInfo.email = user.kakaoAccount!.email;
        kakaoSignIn.accessToken = token.accessToken;
      });
    } catch (e) {
      print('error in login: $e');
    }
  }
}

/* check if it is first login and skip login

AccessToken token = await AccessTokenStore.instance.fromStore();
if (token.refreshToken == null) {
  Navigator.of(context).pushReplacementNamed('/login');
} else {
  Navigator.of(context).pushReplacementNamed("/main");
}

*/