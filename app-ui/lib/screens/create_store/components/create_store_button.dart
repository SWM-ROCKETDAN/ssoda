import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/address.dart';
import 'package:hashchecker/models/store.dart';
import 'package:hashchecker/models/store_category.dart';
import 'package:hashchecker/screens/hall/hall_screen.dart';
import 'package:flash/flash.dart';

class CreateStoreButton extends StatelessWidget {
  final String? logo;
  final List<String> imageList;
  final StoreCategory category;
  final String? name;
  final Address? address;
  final String? description;
  const CreateStoreButton(
      {Key? key,
      required this.logo,
      required this.imageList,
      required this.category,
      required this.name,
      required this.address,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          if (_checkStoreValidation(context)) {
            _createPreview();
            await _showDoneDialog(context);
            Navigator.of(context).push(_routeToHallScreen());
          }
        },
        child: Text(
          '다음',
          style: TextStyle(
              color: kThemeColor, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(12),
            overlayColor:
                MaterialStateProperty.all<Color>(kThemeColor.withOpacity(0.1)),
            shadowColor: MaterialStateProperty.all<Color>(kShadowColor),
            backgroundColor:
                MaterialStateProperty.all<Color>(kScaffoldBackgroundColor),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.0)))),
      ),
    );
  }

  void _createPreview() {
    Store store = Store(
        name: name!,
        category: category,
        address: address!,
        description: description!,
        images: imageList,
        logoImage: logo!);
  }

  bool _checkStoreValidation(BuildContext context) {
    if (logo == null) {
      context.showFlashBar(
          barType: FlashBarType.error,
          icon: const Icon(Icons.error_outline_rounded),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.white,
          content: Text('가게 로고를 등록해주세요!',
              style: TextStyle(fontSize: 14, color: kDefaultFontColor)));
      return false;
    }
    if (name == null || name == "") {
      context.showFlashBar(
          barType: FlashBarType.error,
          icon: const Icon(Icons.error_outline_rounded),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.white,
          content: Text('가게 이름을 입력해주세요!',
              style: TextStyle(fontSize: 14, color: kDefaultFontColor)));
      return false;
    }
    if (imageList.length == 0) {
      context.showFlashBar(
          barType: FlashBarType.error,
          icon: const Icon(Icons.error_outline_rounded),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.white,
          content: Text('가게 이미지를 최소 1개 등록해주세요!',
              style: TextStyle(fontSize: 14, color: kDefaultFontColor)));
      return false;
    }
    if (address == null) {
      context.showFlashBar(
          barType: FlashBarType.error,
          icon: const Icon(Icons.error_outline_rounded),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.white,
          content: Text('가게 주소를 입력해주세요!',
              style: TextStyle(fontSize: 14, color: kDefaultFontColor)));
      return false;
    }
    if (description == null) {
      context.showFlashBar(
          barType: FlashBarType.error,
          icon: const Icon(Icons.error_outline_rounded),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.white,
          content: Text('가게 소개를 입력해주세요!',
              style: TextStyle(fontSize: 14, color: kDefaultFontColor)));
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
