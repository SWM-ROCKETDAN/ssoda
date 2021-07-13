import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hashchecker/screens/create_event/create_event_step/create_event_step_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HashChecker',
      theme: ThemeData(
          primaryColor: Colors.indigoAccent.shade700,
          accentColor: Colors.indigoAccent.shade700,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.white),
      home: CreateEventStepScreen(),
    );
  }
}
