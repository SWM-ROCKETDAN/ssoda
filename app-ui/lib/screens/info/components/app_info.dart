import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/user.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Material(
          color: Colors.white.withOpacity(0),
          child: InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('오픈소스 라이센스'),
                contentPadding: const EdgeInsets.all(5),
                onTap: () async {
                  var dio = await authDio(context);

                  final getUserResponse =
                      await dio.get(getApi(API.GET_USER_INFO));

                  final User fetchedUser = User.fromJson(getUserResponse.data);

                  final pushResponse = await dio.post(
                      'http://192.168.0.103:8080/api/v1/push/users/${fetchedUser.id}',
                      data: {
                        'title': 'test title',
                        'body': 'test message',
                        'image': 'iamge.jpeg',
                        'data': {'test': 'test'}
                      });
                },
                trailing:
                    Icon(Icons.navigate_next_rounded, color: kLiteFontColor),
              ))),
      Material(
          color: Colors.white.withOpacity(0),
          child: InkWell(
              onTap: () {},
              onLongPress: () {},
              child: ListTile(
                title: Text('개발자 정보'),
                contentPadding: const EdgeInsets.all(5),
                onTap: () {},
                trailing:
                    Icon(Icons.navigate_next_rounded, color: kLiteFontColor),
              ))),
      Material(
          color: Colors.white.withOpacity(0),
          child: InkWell(
              onTap: () {},
              child: ListTile(
                  title: Text('현재 버전 1.5.0'),
                  contentPadding: const EdgeInsets.all(5),
                  onTap: () async => await canLaunch(
                          kGooglePlayStoreDownloadUrl)
                      ? await launch(kGooglePlayStoreDownloadUrl)
                      : throw 'Could not launch $kGooglePlayStoreDownloadUrl')))
    ]);
  }
}
