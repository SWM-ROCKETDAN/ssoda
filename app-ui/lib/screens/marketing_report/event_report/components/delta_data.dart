import 'package:flutter/material.dart';
import 'package:hashchecker/widgets/number_slider/number_slide_animation_widget.dart';

class DeltaData extends StatelessWidget {
  const DeltaData(
      {Key? key, required this.value, required this.icon, required this.color})
      : super(key: key);

  final int value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(
        icon,
        color: color,
        size: 32,
      ),
      NumberSlideAnimation(
          number: value.toString(),
          duration: const Duration(seconds: 3),
          curve: Curves.easeOut,
          textStyle: TextStyle(color: color, fontSize: 18),
          format: NumberFormatMode.comma)
    ]);
  }
}
