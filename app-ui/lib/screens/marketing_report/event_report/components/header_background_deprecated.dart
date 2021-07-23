import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class HeaderBackground extends StatelessWidget {
  const HeaderBackground({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.4,
      decoration: BoxDecoration(
        color: kThemeColor,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      ),
    );
  }
}
