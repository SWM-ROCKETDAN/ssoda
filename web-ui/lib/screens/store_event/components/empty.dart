import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';

class Empty extends StatelessWidget {
  const Empty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        color: kScaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/empty.png'),
            Text(
              '아직 아무런 이벤트가 등록되지 않았습니다',
              style: TextStyle(color: kLiteFontColor),
            ),
            Text(
              '먼저 이벤트를 등록해주세요!',
              style: TextStyle(color: kLiteFontColor, height: 1.3),
            )
          ],
        ));
  }
}
