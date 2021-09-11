import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/store.dart';
import 'package:hashchecker/models/store_list_item.dart';
import 'package:hashchecker/screens/event_list/event_list_screen.dart';
import 'package:hashchecker/screens/info/info_screen.dart';
import 'package:hashchecker/screens/marketing_report/store_report/store_report_screen.dart';
import 'package:hashchecker/widgets/pandabar/pandabar.dart';

enum TabPage { EVENT, REPORT, RANKING, INFO }

class HallScreen extends StatefulWidget {
  const HallScreen({Key? key}) : super(key: key);

  @override
  _HallScreenState createState() => _HallScreenState();
}

class _HallScreenState extends State<HallScreen> {
  late Future<List<StoreListItem>> storeList;
  TabPage currentPage = TabPage.EVENT;

  final pageMap = {
    TabPage.EVENT: EventListScreen(),
    TabPage.REPORT: StoreReportScreen(),
    TabPage.RANKING: Container(
        color: kScaffoldBackgroundColor, child: Center(child: Text('랭킹'))),
    TabPage.INFO: InfoScreen(),
  };

  @override
  void initState() {
    super.initState();
    storeList = _fetchStoreListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
        actions: [
          FutureBuilder<List<StoreListItem>>(
              future: storeList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                      height: kToolbarHeight * 0.6,
                      width: kToolbarHeight * 0.6,
                      decoration: BoxDecoration(
                          color: kShadowColor,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  '$s3Url${snapshot.data!.last.logo}'),
                              fit: BoxFit.contain)));
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return Container(
                    height: kToolbarHeight * 0.6,
                    width: kToolbarHeight * 0.6,
                    decoration: BoxDecoration(
                      color: kShadowColor,
                      shape: BoxShape.circle,
                    ));
              }),
          Icon(Icons.arrow_drop_down_rounded, color: kDefaultFontColor),
          SizedBox(width: kDefaultPadding / 2)
        ],
      ),
      bottomNavigationBar: PandaBar(
        backgroundColor: Colors.white,
        buttonData: [
          PandaBarButtonData(
              id: TabPage.EVENT, icon: Icons.grid_view_rounded, title: '이벤트'),
          PandaBarButtonData(
              id: TabPage.REPORT,
              icon: Icons.description_rounded,
              title: '보고서'),
          PandaBarButtonData(
              id: TabPage.RANKING, icon: Icons.star_rounded, title: '랭킹'),
          PandaBarButtonData(
              id: TabPage.INFO,
              icon: Icons.account_circle_rounded,
              title: '내정보'),
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

  Future<List<StoreListItem>> _fetchStoreListData() async {
    var dio = await authDio();

    final getStoreListResponse = await dio.get(getApi(API.GET_USER_STORES));

    final fetchedStoreList = getStoreListResponse.data;

    print(fetchedStoreList);

    List<StoreListItem> storeList = List.generate(fetchedStoreList.length,
        (index) => StoreListItem.fromJson(fetchedStoreList[index]));

    return storeList;
  }
}
