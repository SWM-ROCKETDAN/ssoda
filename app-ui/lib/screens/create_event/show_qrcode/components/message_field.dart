import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class MessageField extends StatelessWidget {
  const MessageField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.check, color: Colors.greenAccent.shade700),
              SizedBox(width: kDefaultPadding / 3),
              Text(
                '이벤트가 등록되었습니다 ',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: kDefaultFontColor),
              ),
            ]),
            SizedBox(height: kDefaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.help_outline, size: 16, color: kLiteFontColor),
                Text(
                  ' QR 코드는 어떻게 사용하나요?',
                  style: TextStyle(color: kLiteFontColor, fontSize: 12),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
