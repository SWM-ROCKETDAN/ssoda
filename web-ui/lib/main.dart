import 'package:flutter/material.dart';
import 'package:hashchecker_web/models/frouter.dart';
import 'package:hashchecker_web/screens/event_list_view/event_list_view_screen.dart';
import 'package:hashchecker_web/screens/reward_get/reward_get_screen.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  FRouter.setupRouter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '해시체커',
      onGenerateRoute: FRouter.router.generator,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.white),
      home: EventListViewScreen(),
    );
  }
}
