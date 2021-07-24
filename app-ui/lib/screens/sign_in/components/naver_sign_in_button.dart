import 'package:flutter/material.dart';

class NaverSignInButton extends StatelessWidget {
  const NaverSignInButton({
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
              'assets/images/sign_in/naver_logo.png',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10),
            Text(
              '네이버로 시작하기',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            )
          ]),
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.fromLTRB(20, 4, 20, 4)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFF00C300)),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))))),
    );
  }
}
