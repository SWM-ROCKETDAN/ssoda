import 'package:flutter/material.dart';

class StepHelp extends StatelessWidget {
  const StepHelp({Key? key, required int step})
      : _step = step,
        super(key: key);

  final int _step;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showDialog(
            context: context, builder: (context) => HelpDialog(step: _step));
      },
      child: Icon(Icons.help_outline),
    );
  }
}

class HelpDialog extends StatefulWidget {
  const HelpDialog({
    Key? key,
    required int step,
  })  : _step = step,
        super(key: key);

  final int _step;

  @override
  _HelpDialogState createState() => _HelpDialogState();
}

class _HelpDialogState extends State<HelpDialog> {
  bool _imageSwitch = false;
  final _stepFileName = [
    'title',
    'reward',
    'hashtags',
    'period',
    'image',
    'require',
    'template'
  ];

  @override
  void initState() {
    _imageSwitchTimer();
    super.initState();
  }

  void _imageSwitchTimer() async {
    await Future.delayed(Duration(milliseconds: 10));
    setState(() {
      _imageSwitch = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: AnimatedCrossFade(
          firstCurve: Curves.easeInCirc,
          firstChild: Image.asset(
            'assets/images/create-event-step-help/draft.png',
            width: MediaQuery.of(context).size.width * 0.8,
            fit: BoxFit.fitWidth,
          ),
          secondChild: Image.asset(
            'assets/images/create-event-step-help/${_stepFileName[widget._step]}.png',
            width: MediaQuery.of(context).size.width * 0.8,
            fit: BoxFit.fitWidth,
          ),
          crossFadeState: _imageSwitch
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 500)),
    ));
  }
}
