import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

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
      body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultTextStyle(
                  style: TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText('Hello',
                          speed: const Duration(milliseconds: 500)),
                    ],
                    isRepeatingAnimation: true,
                  ),
                ),
              ],
            )),
            Column(
              children: [
                NaverSignInButton(size: size),
                SizedBox(height: kDefaultPadding / 3 * 2),
                KakaoSignInButton(size: size),
              ],
            ),
          ])),
    );
  }
}
