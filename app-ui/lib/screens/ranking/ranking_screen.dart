import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:number_display/number_display.dart';

import 'components/ranking_tile.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: kDefaultPadding / 1.2),
                    Column(
                      children: List.generate(
                        10,
                        (index) => RankingTile(),
                      ),
                    ),
                  ])),
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.ideographic,
        children: [
          Text(
            '이벤트 랭킹',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: kDefaultFontColor),
          ),
          SizedBox(width: kDefaultPadding / 2),
          Text(
            '매일 오전 12:00 마다 업데이트 됩니다',
            style: TextStyle(color: kLiteFontColor, fontSize: 10),
          )
        ],
      ),
      backgroundColor: kScaffoldBackgroundColor,
      elevation: 0,
    );
  }
}
