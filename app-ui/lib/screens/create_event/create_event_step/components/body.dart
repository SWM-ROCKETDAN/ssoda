import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/screens/create_event/create_event_step/components/next_step_button.dart';

import 'step_count.dart';
import 'step_field.dart';
import 'step_progressbar.dart';

class Body extends StatelessWidget {
  final step;
  final maxStep;
  final plusStep;
  final event;
  const Body(
      {Key? key,
      required this.step,
      required this.maxStep,
      required this.plusStep,
      required this.event})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      StepProgressbar(context: context, step: step, maxStep: maxStep),
      StepCount(step: step, maxStep: maxStep),
      Expanded(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: PageTransitionSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                    ) {
                      return SharedAxisTransition(
                        child: child,
                        fillColor: kScaffoldBackgroundColor,
                        animation: animation,
                        secondaryAnimation: secondaryAnimation,
                        transitionType: SharedAxisTransitionType.horizontal,
                      );
                    },
                    child: StepField(step: step, event: event))),
            SizedBox(height: kDefaultPadding),
            NextStepButton(
                step: step, maxStep: maxStep, plusStep: plusStep, event: event)
          ],
        ),
      ))
    ]);
  }
}
