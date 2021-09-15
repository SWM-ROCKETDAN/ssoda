import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/selected_store.dart';
import 'package:hashchecker/screens/info/components/app_info.dart';
import 'package:hashchecker/screens/sign_in/sign_in_screen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'store_options_modal.dart';

class ButtonList extends StatelessWidget {
  const ButtonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () => showMaterialModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        expand: false,
                        context: context,
                        builder: (context) => StoreOptionsModal()),
                    child: Text('내 가게',
                        style:
                            TextStyle(color: kDefaultFontColor, fontSize: 14)),
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(4),
                        overlayColor:
                            MaterialStateProperty.all<Color>(kShadowColor),
                        shadowColor:
                            MaterialStateProperty.all<Color>(kShadowColor),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            kScaffoldBackgroundColor),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)))),
                  ),
                ),
              ),
              SizedBox(width: kDefaultPadding),
              Expanded(
                child: Container(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, slidePageRouting(AppInfo()));
                    },
                    child: Text('앱 설정',
                        style:
                            TextStyle(color: kDefaultFontColor, fontSize: 14)),
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(4),
                        overlayColor:
                            MaterialStateProperty.all<Color>(kShadowColor),
                        shadowColor:
                            MaterialStateProperty.all<Color>(kShadowColor),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            kScaffoldBackgroundColor),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)))),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: kDefaultPadding),
          Container(
            height: 45,
            width: size.width,
            child: ElevatedButton(
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                        title: Center(
                          child: Text('로그아웃',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: kDefaultFontColor),
                              textAlign: TextAlign.center),
                        ),
                        content: IntrinsicHeight(
                          child: Column(children: [
                            Text("로그아웃 하시겠습니까?",
                                style: TextStyle(
                                    fontSize: 14, color: kDefaultFontColor))
                          ]),
                        ),
                        contentPadding:
                            const EdgeInsets.fromLTRB(15, 15, 15, 5),
                        actions: [
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    await _logout(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignInScreen()));
                                  },
                                  child: Text('예',
                                      style: TextStyle(
                                          color: kThemeColor, fontSize: 13)),
                                  style: ButtonStyle(
                                      overlayColor:
                                          MaterialStateProperty.all<Color>(
                                              kThemeColor.withOpacity(0.2))),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('아니오',
                                      style: TextStyle(fontSize: 13)),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              kThemeColor)),
                                ),
                              ],
                            ),
                          )
                        ],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))));
              },
              child: Text('로그아웃',
                  style: TextStyle(color: kDefaultFontColor, fontSize: 14)),
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(4),
                  overlayColor: MaterialStateProperty.all<Color>(kShadowColor),
                  shadowColor: MaterialStateProperty.all<Color>(kShadowColor),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      kScaffoldBackgroundColor),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)))),
            ),
          ),
          SizedBox(height: kDefaultPadding * 1.5),
          Container(
            height: 45,
            width: size.width,
            child: ElevatedButton(
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                        title: Center(
                          child: Text('회원 탈퇴',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: kDefaultFontColor),
                              textAlign: TextAlign.center),
                        ),
                        content: IntrinsicHeight(
                          child: Column(children: [
                            Text("탈퇴 시 모든 가게 정보와 이벤트 정보가",
                                style: TextStyle(
                                    fontSize: 14, color: kDefaultFontColor)),
                            Text("삭제되며 복구할 수 없습니다.",
                                style: TextStyle(
                                    fontSize: 14, color: kDefaultFontColor)),
                            Text("그래도 탈퇴하시겠습니까?",
                                style: TextStyle(
                                    fontSize: 14, color: kDefaultFontColor)),
                          ]),
                        ),
                        contentPadding:
                            const EdgeInsets.fromLTRB(15, 15, 15, 5),
                        actions: [
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    await _deleteUser(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignInScreen()));
                                  },
                                  child: Text('예',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 13)),
                                  style: ButtonStyle(
                                      overlayColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.red.withOpacity(0.2))),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('아니오',
                                      style: TextStyle(fontSize: 13)),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.red)),
                                ),
                              ],
                            ),
                          )
                        ],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))));
              },
              child: Text('회원 탈퇴',
                  style: TextStyle(color: Colors.red, fontSize: 14)),
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(4),
                  overlayColor: MaterialStateProperty.all<Color>(
                      Colors.red.withOpacity(0.1)),
                  shadowColor: MaterialStateProperty.all<Color>(kShadowColor),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      kScaffoldBackgroundColor),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)))),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    final storage = new FlutterSecureStorage();
    await storage.deleteAll();
  }

  Future<void> _deleteUser(BuildContext context) async {
    var dio = await authDio();

    final deleteUserResponse = await dio.delete(getApi(API.DELETE_USER));

    final storage = new FlutterSecureStorage();
    await storage.deleteAll();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('selectedStore');

    context.read<SelectedStore>().id = null;
  }
}
