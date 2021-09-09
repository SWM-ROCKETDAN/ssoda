import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class AppInfo extends StatefulWidget {
  const AppInfo({Key? key}) : super(key: key);

  @override
  _AppInfoState createState() => _AppInfoState();
}

class _AppInfoState extends State<AppInfo> {
  bool _pushNotiEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kScaffoldBackgroundColor,
          iconTheme: IconThemeData(color: kDefaultFontColor),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text('앱 설정', style: TextStyle(color: kDefaultFontColor)),
          centerTitle: true,
          elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          SwitchListTile(
            activeColor: kThemeColor,
            value: _pushNotiEnabled,
            title: Text('이벤트 참여 푸시 알림'),
            subtitle: Text(
              '고객이 이벤트에 참여 시 알림을 보내드려요',
              style: TextStyle(fontSize: 12),
            ),
            onChanged: (value) {
              setState(() {
                _pushNotiEnabled = value;
              });
            },
          ),
          ListTile(
            title: Text('오픈소스 라이센스'),
            onTap: () {},
            trailing: Icon(Icons.navigate_next_rounded),
          ),
          ListTile(title: Text('현재 버전 1.0.0'), onTap: () {})
        ],
      ),
    );
  }
}
