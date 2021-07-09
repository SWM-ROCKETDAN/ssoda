import 'package:flutter/material.dart';
import 'package:hashchecker/models/event.dart';

class EventTitle extends StatelessWidget {
  const EventTitle({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(event.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
      ),
    );
  }
}
