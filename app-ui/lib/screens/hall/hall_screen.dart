import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/screens/create_event/create_event_step/create_event_step_screen.dart';
import 'package:hashchecker/screens/marketing_report/store_report/store_report_screen.dart';
import 'package:hashchecker/widgets/pandabar/pandabar.dart';

class HallScreen extends StatefulWidget {
  const HallScreen({Key? key}) : super(key: key);

  @override
  _HallScreenState createState() => _HallScreenState();
}

class _HallScreenState extends State<HallScreen> {
  String page = 'event';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: kScaffoldBackgroundColor,
        shadowColor: kShadowColor,
        elevation: 1,
        title: Text('SSODA',
            style: TextStyle(color: kThemeColor, fontWeight: FontWeight.bold)),
      ),
      bottomNavigationBar: PandaBar(
        backgroundColor: Colors.white,
        buttonData: [
          PandaBarButtonData(
            id: 'event',
            icon: Icons.grid_view_rounded,
            title: '이벤트',
          ),
          PandaBarButtonData(
              id: 'Green', icon: Icons.store_rounded, title: '스토어'),
          PandaBarButtonData(
              id: 'report', icon: Icons.description_rounded, title: '레포트'),
          PandaBarButtonData(
              id: 'more', icon: Icons.more_horiz_rounded, title: '더보기'),
        ],
        onChange: (id) {
          setState(() {
            page = id;
          });
        },
        onFabButtonPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateEventStepScreen(),
            ),
          );
        },
      ),
      body: Builder(
        builder: (context) {
          switch (page) {
            case 'report':
              return StoreReportScreen();
            default:
              return Container();
          }
        },
      ),
    );
  }
}
