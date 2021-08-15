import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/requires.dart';

import 'step_text.dart';

class EventRequire extends StatefulWidget {
  final event;
  const EventRequire({Key? key, required this.event}) : super(key: key);

  @override
  _EventRequireState createState() => _EventRequireState();
}

class _EventRequireState extends State<EventRequire> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [StepText(step: 5)]),
          SizedBox(height: kDefaultPadding),
          Container(
              height: 300,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: requireStringList.length,
                  itemBuilder: (context, index) => CheckboxListTile(
                      activeColor: kThemeColor,
                      title: Text(
                        requireStringList[index],
                        style: TextStyle(
                            color: widget.event.requireList[index]
                                ? kThemeColor
                                : kLiteFontColor),
                      ),
                      value: widget.event.requireList[index],
                      onChanged: (value) {
                        setState(() {
                          widget.event.requireList[index] = value!;
                        });
                      })))
        ]);
  }
}
