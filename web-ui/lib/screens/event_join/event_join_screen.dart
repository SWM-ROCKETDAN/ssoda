import 'package:flutter/material.dart';
import 'package:hashchecker_web/models/event.dart';
import 'components/body.dart';

class EventJoinScreen extends StatefulWidget {
  final Event event;
  const EventJoinScreen({Key? key, required this.event}) : super(key: key);

  @override
  _EventJoinScreenState createState() => _EventJoinScreenState();
}

class _EventJoinScreenState extends State<EventJoinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Body(event: widget.event));
  }
}
