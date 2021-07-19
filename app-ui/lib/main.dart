import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hashchecker/screens/create_event/create_event_step/create_event_step_screen.dart';
import 'package:hashchecker/screens/marketing_report/event_report/event_report_screen.dart';

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
          primarySwatch: _createMaterialColor(Colors.indigoAccent.shade700),
          primaryColor: Colors.indigoAccent.shade700,
          accentColor: Colors.indigoAccent.shade700,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.white),
      home: EventReportScreen(),
    );
  }

  MaterialColor _createMaterialColor(Color color) {
    List<double> strengths = [.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
