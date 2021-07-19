import 'package:flutter/material.dart';

class StepProgressbar extends StatelessWidget {
  const StepProgressbar({
    Key? key,
    required this.maxStep,
    required int step,
    required this.context,
  })  : _step = step,
        super(key: key);

  final int maxStep;
  final int _step;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      color: Theme.of(context).primaryColor,
      width: MediaQuery.of(context).size.width / maxStep * (_step + 1),
    );
  }
}
