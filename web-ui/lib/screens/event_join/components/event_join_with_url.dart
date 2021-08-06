import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hashchecker_web/api.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/models/event.dart';
import 'package:hashchecker_web/models/reward.dart';
import 'package:hashchecker_web/screens/reward_get/reward_get_screen.dart';
import 'package:http/http.dart' as http;

class EventJoinWithUrl extends StatefulWidget {
  final Map<String, dynamic> data;
  final id;
  const EventJoinWithUrl({Key? key, required this.data, required this.id})
      : super(key: key);

  @override
  _EventJoinWithUrlState createState() => _EventJoinWithUrlState();
}

class _EventJoinWithUrlState extends State<EventJoinWithUrl> {
  final _urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('이벤트 참여하기',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        SizedBox(height: kDefaultPadding),
        TextField(
          controller: _urlController,
          style: TextStyle(fontSize: 14),
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.link),
              hintText: '인스타그램 게시글 URL을 붙여넣기 해주세요!',
              contentPadding: const EdgeInsets.all(8),
              isDense: true),
        ),
        SizedBox(height: kDefaultPadding / 3),
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: ElevatedButton(
                onPressed: () {
                  if (isValidUrl())
                    sendUrlToGetReward();
                  else {
                    final snackBar = SnackBar(
                      content: Text('올바른 인스타그램 게시글 URL이 아닙니다.'),
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(milliseconds: 2500),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Text('URL 업로드하고 이벤트 참여하기'))),
        SizedBox(height: kDefaultPadding),
        Row(
          children: [
            Icon(
              Icons.help_outline,
              color: Colors.black54,
              size: 16,
            ),
            Text(' 참여 방법',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black54)),
          ],
        ),
        SizedBox(height: kDefaultPadding / 3),
        RichText(
            text: TextSpan(children: [
          TextSpan(text: '1. 조건에 맞춰 인스타그램에 게시글을 작성\n'),
          TextSpan(text: '2. 작성한 '),
          TextSpan(
              text: '게시글의 링크', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '를 복사-붙여넣기하여 업로드\n'),
          TextSpan(text: '3. 조건 달성률에 따라 이벤트 상품 즉시 지급!')
        ], style: TextStyle(color: Colors.black54, fontSize: 13))),
      ],
    );
  }

  Future<void> sendUrlToGetReward() async {
    final response = await http.post(
        Uri.parse(getApi(API.GET_REWARD, parameter: widget.id)),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods":
              "POST, GET, OPTIONS, PUT, DELETE, HEAD",
        },
        body: {
          'url': _urlController.value.text.trim()
        });

    if (response.statusCode == 200) {
      Reward reward = Reward.fromJson(jsonDecode(response.body));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RewardGetScreen(
              eventTitle: widget.data['event'].title,
              rewardName: reward.name,
              rewardImage: reward.imgPath),
        ),
      );
    }
  }

  bool isValidUrl() {
    final String url = _urlController.value.text.trim();
    if (url == "") return false;
    if (url.length <= instagramPostUrlPrefix.length ||
        url.substring(0, instagramPostUrlPrefix.length) !=
            instagramPostUrlPrefix) return false;
    return true;
  }
}
