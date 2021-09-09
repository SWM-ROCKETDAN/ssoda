import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/address.dart';
import 'package:hashchecker/models/store.dart';
import 'package:hashchecker/models/store_category.dart';
import 'package:hashchecker/screens/hall/hall_screen.dart';
import 'package:flash/flash.dart';

class CreateButton extends StatelessWidget {
  final String? logo;
  final List<String> imageList;
  final StoreCategory category;
  final String? name;
  final Address? address;
  final String? description;
  const CreateButton(
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
            _showCreateStoreDialog(context);
          }
        },
        child: Text(
          '등록하기',
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
    if (name == null || name!.trim() == "") {
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
    if (description == null || description!.trim() == "") {
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

  Future<void> _createStore() async {
    var dio = await authDio();

    final getUserInfoResponse = await dio.get(getApi(API.GET_USER_INFO));

    final id = getUserInfoResponse.data['id'];

    dio.options.contentType = 'multipart/form-data';

    var storeData = FormData.fromMap({
      'name': name!.trim(),
      'category': category.index,
      'description': description!.trim(),
      'images': List.generate(imageList.length,
          (index) => MultipartFile.fromFileSync(imageList[index])),
      'logoImage': await MultipartFile.fromFile(logo!),
      'city': address!.city,
      'country': address!.country,
      'town': address!.town,
      'road': address!.road,
      'buildingCode': address!.building,
      'zipCode': address!.zipCode,
      'latitude': address!.latitude,
      'longitude': address!.longitude
    });

    final createStoreResponse = await dio
        .post(getApi(API.CREATE_STORE, suffix: '/$id'), data: storeData);

    print(createStoreResponse.data);
  }

  Future<void> _showCreateStoreDialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Center(
              child: Text('우리가게 등록',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kDefaultFontColor),
                  textAlign: TextAlign.center),
            ),
            content: IntrinsicHeight(
              child: Column(children: [
                Text("이대로 등록하시겠습니까?",
                    style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
                SizedBox(height: kDefaultPadding / 5),
                Text("(가게 정보는 마이페이지에서\n다시 수정할 수 있습니다)",
                    style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
              ]),
            ),
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            actions: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await _createStore();
                        Navigator.of(context).pop();
                        await _showDoneDialog(context);
                      },
                      child: Text('예',
                          style: TextStyle(color: Colors.white, fontSize: 13)),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kThemeColor)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('아니오',
                          style: TextStyle(color: Colors.white, fontSize: 13)),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kThemeColor)),
                    ),
                  ],
                ),
              )
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))));
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
            content: Text("쏘다에 우리가게가 등록되었습니다\n이제 이벤트를 만들어볼까요?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(slidePageRouting(HallScreen()));
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
}
