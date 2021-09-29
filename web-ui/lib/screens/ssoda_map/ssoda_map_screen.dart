import 'dart:async';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/screens/reward_get/reward_get_screen.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class SsodaMapScreen extends StatelessWidget {
  const SsodaMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Roulette()));
            },
            child: Text('시발'),
          ),
        ));
  }
}

class Roulette extends StatelessWidget {
  const Roulette({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      padding: const EdgeInsets.all(20),
      child: FortuneWheel(
        indicators: [
          FortuneIndicator(
              alignment: Alignment.topCenter,
              child: TriangleIndicator(
                color: Colors.white.withOpacity(0.7),
              )),
        ],
        physics: NoPanPhysics(),
        selected: Stream.value(4),
        items: [
          FortuneItem(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: AutoSizeText(
                  '   1단계',
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  maxLines: 1,
                  minFontSize: 10,
                ),
              ),
              style: FortuneItemStyle(
                  color: Color(0xFFF15A5A),
                  borderWidth: 3,
                  borderColor: Colors.white)),
          FortuneItem(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: AutoSizeText(
                  '   2단계',
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  maxLines: 1,
                  minFontSize: 10,
                ),
              ),
              style: FortuneItemStyle(
                  color: Color(0xFFF0C419),
                  borderWidth: 3,
                  borderColor: Colors.white)),
          FortuneItem(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: AutoSizeText(
                  '   2단계',
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  maxLines: 1,
                  minFontSize: 10,
                ),
              ),
              style: FortuneItemStyle(
                  color: Color(0xFF4EBA6F),
                  borderWidth: 3,
                  borderColor: Colors.white)),
          FortuneItem(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: AutoSizeText(
                  '   2단계',
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  maxLines: 1,
                  minFontSize: 10,
                ),
              ),
              style: FortuneItemStyle(
                  color: Color(0xFF2D95BF),
                  borderWidth: 3,
                  borderColor: Colors.white)),
          FortuneItem(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: AutoSizeText(
                  '   2단계',
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  maxLines: 1,
                  minFontSize: 10,
                ),
              ),
              style: FortuneItemStyle(
                  color: Color(0xFF955BA5),
                  borderWidth: 3,
                  borderColor: Colors.white)),
        ],
      ),
    );
  }
}
