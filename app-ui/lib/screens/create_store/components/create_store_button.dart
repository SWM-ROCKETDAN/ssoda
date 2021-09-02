import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/address.dart';
import 'package:hashchecker/models/store_category.dart';
import 'package:hashchecker/screens/hall/hall_screen.dart';

class CreateStoreButton extends StatelessWidget {
  final String? logo;
  final List<String> imageList;
  final StoreCategory category;
  final String? name;
  final Address? address;
  const CreateStoreButton(
      {Key? key,
      required this.logo,
      required this.imageList,
      required this.category,
      required this.name,
      required this.address})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          if (_checkStoreValidation()) {
            await _showDoneDialog(context);
            Navigator.of(context).push(_routeToHallScreen());
          }
        },
        child: Text(
          '등록하기',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        style: ButtonStyle(
            shadowColor: MaterialStateProperty.all<Color>(kShadowColor),
            backgroundColor: MaterialStateProperty.all<Color>(kThemeColor),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.0)))),
      ),
    );
  }

  bool _checkStoreValidation() {
    if (logo == null) {
      return false;
    }
    if (imageList.length == 0) {
      return false;
    }
    if (name == null || name == "") {
      return false;
    }
    if (address == null) {
      return false;
    }
    return true;
  }

  Future<void> _showDoneDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Center(
              child: Text('축하합니다!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kDefaultFontColor),
                  textAlign: TextAlign.center),
            ),
            content: Text("쏘다에 우리가게를 등록했어요!\n이제 이벤트를 만들어볼까요?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('확인', style: TextStyle(fontSize: 13)),
                  style: ButtonStyle(
                      shadowColor:
                          MaterialStateProperty.all<Color>(kShadowColor),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kThemeColor)),
                ),
              )
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))));
  }

  Route _routeToHallScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const HallScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
