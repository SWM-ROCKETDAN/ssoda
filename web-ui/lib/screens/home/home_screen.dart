import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/screens/home/components/intro.dart';

import 'components/create.dart';
import 'components/join.dart';
import 'components/outro.dart';
import 'components/report.dart';
import 'components/footer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  var _scrollOffset = 0.0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<double> _offsetList = [
      size.height * 0.33,
      size.height * 1.33,
      size.height * 2.33,
      size.height * 3.33
    ];
    _scrollController.addListener(() {
      if (_offsetList.contains(_scrollController.offset))
        setState(() {
          _scrollOffset = _scrollController.offset;
        });
    });
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: 90,
        leading: GestureDetector(
          onTap: () {
            _scrollController.animateTo(0,
                duration: Duration(milliseconds: 1500),
                curve: Curves.fastOutSlowIn);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 15),
            width: size.width * 2 / 7,
            child: Image.asset('assets/images/appbar_logo.png'),
          ),
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
      body: ListView(children: [
        Intro(scrollController: _scrollController),
        Create(
            scrollController: _scrollController, scrollOffset: _scrollOffset),
        Join(scrollController: _scrollController, scrollOffset: _scrollOffset),
        Report(
            scrollController: _scrollController, scrollOffset: _scrollOffset),
        Outro(scrollController: _scrollController, scrollOffset: _scrollOffset),
        Footer()
      ], controller: _scrollController),
    );
  }
}
