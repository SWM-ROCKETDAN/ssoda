import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/screens/create_store/components/intro.dart';
import 'package:hashchecker/screens/hall/hall_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'components/kakao_sign_in_button.dart';
import 'components/naver_sign_in_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/sign_in/hello.png'),
                        Text('시작하기',
                            style: TextStyle(
                                fontSize: 12.0, color: kLiteFontColor)),
                        SizedBox(height: kDefaultPadding / 2),
                        Text('안녕하세요, 사장님',
                            style: TextStyle(
                                fontSize: 26.0, fontWeight: FontWeight.bold)),
                      ]),
                ),
                Container(
                  child: Column(
                    children: [
                      NaverSignInButton(
                        size: size,
                        signIn: naverLoginPressed,
                      ),
                      SizedBox(height: kDefaultPadding / 3 * 2),
                      KakaoSignInButton(
                        size: size,
                        signIn: kakaoLoginPressed,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            var dio = await authDio();

                            print('get auth dio complete');

                            final getUserInfoResponse =
                                await dio.get(getApi(API.GET_USER_INFO));

                            print(getUserInfoResponse.data);
                          },
                          child: Text('getUser 요청')),
                      SizedBox(height: kDefaultPadding / 3 * 2),
                      Text('로그인 할 플랫폼을 선택해주세요!',
                          style:
                              TextStyle(fontSize: 12.0, color: kLiteFontColor)),
                    ],
                  ),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                ),
              ])),
    );
  }

  void naverLoginPressed() {
    signIn(getApi(API.NAVER_LOGIN));
  }

  void kakaoLoginPressed() {
    signIn(getApi(API.KAKAO_LOGIN));
  }

  Future<void> signIn(String api) async {
    final storage = new FlutterSecureStorage();
    try {
      // open login page & redirect auth code to back-end
      final url = Uri.parse('$api?redirect_uri=$kAppUrlScheme');

      // get callback data from back-end
      final result = await FlutterWebAuth.authenticate(
          url: url.toString(), callbackUrlScheme: kAppUrlScheme);

      // parsing accessToken & refreshToken from callback data
      final accessToken = Uri.parse(result).queryParameters['access-token'];
      final refreshToken = Uri.parse(result).queryParameters['refresh-token'];

      // save tokens on secure storage
      await storage.write(key: 'ACCESS_TOKEN', value: accessToken);
      await storage.write(key: 'REFRESH_TOKEN', value: refreshToken);
    } catch (e) {
      showLoginFailDialog(e.toString());
    }

    var dio = await authDio();

    print('get auth dio complete');

    Navigator.of(context).push(_routeToCreateStoreScreen());
  }

  Future<void> createStore() async {
    var dio = await authDio();

    print('get auth dio complete');

    final getUserInfoResponse = await dio.get(getApi(API.GET_USER_INFO));

    print('get user info complete');

    final id = getUserInfoResponse.data['id'];

    dio.options.contentType = 'multipart/form-data';

    final ImagePicker _imagePicker = ImagePicker();
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    var storeData = FormData.fromMap({
      'name': 'yjyoon_store',
      'category': 1,
      'city': '서울',
      'country': '광진구',
      'town': '광장동',
      'roadCode': '000000000000',
      'road': '아차산로 549',
      'zipCode': '04983',
      'description': '상세 설명',
      'logoImage': await MultipartFile.fromFile(image!.path),
      'images': [
        await MultipartFile.fromFile(image.path),
      ]
    });

    final createStoreResponse = await dio
        .post(getApi(API.CREATE_STORE, suffix: '/$id'), data: storeData);

    print('save store complete');

    print(createStoreResponse.data);
  }

  void showLoginFailDialog(String errMsg) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Center(
                child: Text(
              "로그인 오류",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )),
            content: IntrinsicHeight(
              child: Column(children: [
                Text("로그인 도중 오류가 발생하였습니다.", style: TextStyle(fontSize: 14)),
                SizedBox(height: kDefaultPadding / 5),
                Text(errMsg, style: TextStyle(fontSize: 14)),
              ]),
            ),
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            actions: [
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('확인')),
              )
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))));
  }
}

Route _routeToCreateStoreScreen() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const CreateStoreIntroScreen(),
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
