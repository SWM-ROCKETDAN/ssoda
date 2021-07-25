import 'package:flutter/material.dart';

class KakaoSignInButton extends StatelessWidget {
  const KakaoSignInButton({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: TextButton(
          onPressed: () {},
          child: Row(children: [
            Image.asset(
              'assets/images/sign_in/kakao_logo.png',
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10),
            Text(
              '카카오로 시작하기',
              style: TextStyle(
                color: Color(0xFF381E1E),
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
                  MaterialStateProperty.all<Color>(Color(0xFFFFE600)),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))))),
    );
  }
}
