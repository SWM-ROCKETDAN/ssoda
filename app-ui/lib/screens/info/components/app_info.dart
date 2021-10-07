import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
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
                onTap: () {},
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
