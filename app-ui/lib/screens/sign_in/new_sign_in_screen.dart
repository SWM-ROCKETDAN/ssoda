import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/env.dart';

import 'components/kakao_sign_in_button.dart';
import 'components/naver_sign_in_button.dart';

class NewSignInScreen extends StatefulWidget {
  const NewSignInScreen({Key? key}) : super(key: key);

  @override
  _NewSignInScreenState createState() => _NewSignInScreenState();
}

class _NewSignInScreenState extends State<NewSignInScreen> {
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
                        children: []),
                  ),
                  Column(
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
                ])),
      ),
    );
  }

  Future<void> naverLoginPressed() async {
    final callbackUrlScheme = 'com.rocketdan.hashchecker';

    final url = Uri.parse(
        'http://ec2-3-37-85-236.ap-northeast-2.compute.amazonaws.com:8080/oauth2/authorization/naver?redirect_uri=com.rocketdan.hashchecker:/');

    final result = await FlutterWebAuth.authenticate(
        url: url.toString(), callbackUrlScheme: callbackUrlScheme);

    print(result);
  }

  Future<void> kakaoLoginPressed() async {
    final redirectUri = Uri.parse('http://rocketdan.hashchecker.com/kakao');

    final callbackUrlScheme = 'com.rocketdan.hashchecker';

    final state = Uri.parse('com.rocketdan.hashchecker');

    final url = Uri.https('kauth.kakao.com', '/oauth/authorize', {
      'client_id': KAKAO_APP_KEY,
      'redirect_uri': redirectUri.toString(),
      'response_type': 'code',
      'state': state.toString()
    });

    final result = await FlutterWebAuth.authenticate(
        url: url.toString(), callbackUrlScheme: callbackUrlScheme);

    print(result);
  }

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
