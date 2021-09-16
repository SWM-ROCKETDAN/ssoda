import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        color: kScaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/not_ready.png'),
            Text(
              '이 페이지는 아직 준비 중입니다',
              style: TextStyle(color: kLiteFontColor, fontSize: 13),
            ),
            Text(
              '업데이트를 기대해주세요!',
              style:
                  TextStyle(color: kLiteFontColor, height: 1.3, fontSize: 13),
            )
          ],
        ));
  }
}
