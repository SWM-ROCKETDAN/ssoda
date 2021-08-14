import 'package:flutter/material.dart';
import 'package:hashchecker/models/requires.dart';

class EventRequire extends StatefulWidget {
  final requireList;
  final selectedRequireList;
  const EventRequire({Key? key, this.requireList, this.selectedRequireList})
      : super(key: key);

  @override
  _EventRequireState createState() => _EventRequireState();
}

class _EventRequireState extends State<EventRequire> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: widget.requireList.length,
            itemBuilder: (context, index) => CheckboxListTile(
                title: Text(
                  requireStringList[index],
                  style: TextStyle(
                      color: widget.selectedRequireList[index]
                          ? Colors.black87
                          : Colors.grey),
                ),
                value: widget.selectedRequireList[index],
                onChanged: (value) {
                  setState(() {
                    widget.selectedRequireList[index] = value!;
                  });
                })));
  }
}
