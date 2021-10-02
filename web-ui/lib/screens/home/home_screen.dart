import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/screens/home/components/intro.dart';

import 'components/create.dart';
import 'components/join.dart';
import 'components/outro.dart';
import 'components/report.dart';
import 'components/footer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    final _scrollController = ScrollController();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: 90,
        leading: Container(
          margin: const EdgeInsets.only(left: 15),
          width: size.width * 2 / 7,
          child: Image.asset('assets/images/appbar_logo.png'),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            width: size.width * 2 / 7,
            child: TextButton(
              onPressed: () {
                _scrollController.animateTo(size.height * 4 + kToolbarHeight,
                    duration: Duration(milliseconds: 1500),
                    curve: Curves.fastOutSlowIn);
              },
              child: Text('다운로드', style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kThemeColor),
                  overlayColor:
                      MaterialStateProperty.all<Color>(Colors.white30),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32))),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(horizontal: 15))),
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
          children: [Intro(), Create(), Join(), Report(), Outro(), Footer()],
          controller: _scrollController),
    );
  }
}
