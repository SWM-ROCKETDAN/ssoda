import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NaverSignInButton extends StatelessWidget {
  const NaverSignInButton(
      {Key? key,
      required this.size,
      required this.signIn,
      required this.signOut,
      required this.isLogin})
      : super(key: key);

  final Size size;
  final AsyncCallback signIn;
  final AsyncCallback signOut;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: TextButton(
          onPressed: isLogin ? signOut : signIn,
          child: Row(children: [
            Image.asset(
              'assets/images/sign_in/naver_logo.png',
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 5),
            Text(
              isLogin ? '네이버에서 로그아웃' : '네이버로 시작하기',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            )
          ]),
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color>(
                  Colors.white.withOpacity(0.1)),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.fromLTRB(20, 8, 20, 8)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFF03C75A)),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))))),
    );
  }
}
