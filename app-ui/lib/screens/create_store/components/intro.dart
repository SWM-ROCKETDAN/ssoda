import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/screens/create_store/create_store_screen.dart';

class CreateStoreIntro extends StatelessWidget {
  const CreateStoreIntro({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/create_store/add_store.png'),
                      Text('가게 등록',
                          style:
                              TextStyle(fontSize: 12.0, color: kLiteFontColor)),
                      SizedBox(height: kDefaultPadding / 2),
                      AutoSizeText('사장님 가게를 등록해볼까요?',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          minFontSize: 18),
                    ]),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(_routeToInputStoreInfoScreen());
                  },
                  child: Text(
                    '우리가게 등록하기',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                      shadowColor:
                          MaterialStateProperty.all<Color>(kShadowColor),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kThemeColor),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(27.0)))),
                ),
              )
            ]));
  }
}

Route _routeToInputStoreInfoScreen() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const CreateStoreScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
