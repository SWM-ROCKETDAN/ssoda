import 'package:flutter/material.dart';
import 'package:hashchecker/screens/create_event/create_event_step/create_event_step_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CreateEventStepScreen(),
    );
  }
}
