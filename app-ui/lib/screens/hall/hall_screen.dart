import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/screens/event_list/event_list_screen.dart';
import 'package:hashchecker/screens/marketing_report/store_report/store_report_screen.dart';
import 'package:hashchecker/widgets/pandabar/pandabar.dart';

enum TabPage { EVENT, STORE, REPORT, MORE }

class HallScreen extends StatefulWidget {
  const HallScreen({Key? key}) : super(key: key);

  @override
  _HallScreenState createState() => _HallScreenState();
}

class _HallScreenState extends State<HallScreen> {
  TabPage currentPage = TabPage.EVENT;

  final pageMap = {
    TabPage.EVENT: EventListScreen(),
    TabPage.STORE: Container(
        color: kScaffoldBackgroundColor, child: Center(child: Text('스토어'))),
    TabPage.REPORT: StoreReportScreen(),
    TabPage.MORE: Container(
        color: kScaffoldBackgroundColor, child: Center(child: Text('더보기'))),
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      /*
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kScaffoldBackgroundColor,
        shadowColor: kShadowColor,
        elevation: 1,
        title: Container(
          padding: const EdgeInsets.only(left: 5),
          child: Image.asset('assets/images/appbar_logo.png'),
          height: kToolbarHeight * 0.75,
        ),
        /* 
        // STORE LOGO ON TOPRIGHT APPBAR
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            height: kToolbarHeight * 0.75,
            width: kToolbarHeight * 0.75,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('assets/images/store_logo_sample.jpg'),
                    fit: BoxFit.cover)),
          )
        ],
        */
      ),
      */
      bottomNavigationBar: PandaBar(
        backgroundColor: Colors.white,
        buttonData: [
          PandaBarButtonData(
              id: TabPage.EVENT, icon: Icons.grid_view_rounded, title: '이벤트'),
          PandaBarButtonData(
              id: TabPage.STORE, icon: Icons.store_rounded, title: '스토어'),
          PandaBarButtonData(
              id: TabPage.REPORT,
              icon: Icons.description_rounded,
              title: '리포트'),
          PandaBarButtonData(
              id: TabPage.MORE, icon: Icons.more_horiz_rounded, title: '더보기'),
        ],
        onChange: (id) {
          setState(() {
            currentPage = id;
          });
        },
      ),
      body: SafeArea(
        child: PageTransitionSwitcher(
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: pageMap[currentPage],
        ),
      ),
    );
  }
}
