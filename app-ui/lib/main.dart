import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/screens/create_store/create_store_screen.dart';
import 'package:hashchecker/screens/event_list/event_list_screen.dart';
import 'package:hashchecker/screens/hall/hall_screen.dart';
import 'package:hashchecker/screens/on_boarding/on_boarding_screen.dart';
import 'package:hashchecker/screens/sign_in/sign_in_screen.dart';
import 'package:hashchecker/screens/splash/splash_screen.dart';

import 'screens/create_store/components/intro.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*return 
    FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(home: SplashScreen());
        } else {*/
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SSODA',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ko'),
        ],
        locale: const Locale('ko'),
        theme: ThemeData(
            primarySwatch: _createMaterialColor(kThemeColor),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: kScaffoldBackgroundColor,
            accentColor: kShadowColor),
        home: HallScreen());
  }
  /*
      },
    );
  }*/

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

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    await Future.delayed(Duration(milliseconds: 2500));
  }
}
