import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flash/flash.dart';
import 'package:hashchecker_web/api.dart';
import 'package:hashchecker_web/constants.dart';
import 'package:hashchecker_web/models/join_result.dart';
import 'package:hashchecker_web/models/reward.dart';
import 'package:hashchecker_web/screens/reward_get/reward_get_screen.dart';

class EventJoinWithUrl extends StatefulWidget {
  final event;
  final eventId;
  final loading;
  const EventJoinWithUrl(
      {Key? key,
      required this.event,
      required this.eventId,
      required this.loading})
      : super(key: key);

  @override
  _EventJoinWithUrlState createState() => _EventJoinWithUrlState();
}

class _EventJoinWithUrlState extends State<EventJoinWithUrl> {
  final _urlController = TextEditingController();
  bool _urlEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('이벤트 참여하기',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        SizedBox(height: kDefaultPadding),
        TextField(
          enabled: _urlEnabled,
          controller: _urlController,
          textInputAction: TextInputAction.go,
          onSubmitted: (_) {
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
                onPressed: _urlEnabled
                    ? () {
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
                      }
                    : null,
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
    setState(() {
      _urlEnabled = false;
    });

    widget.loading(true);

    Map<String, dynamic> urlJson = {'url': _urlController.value.text.trim()};

    var dio = Dio();

    dio.options.contentType = 'application/json';
    dio.options.headers['Access-Control-Allow-Origin'] = '*';

    dio.interceptors.add(InterceptorsWrapper(onError: (error, handler) async {
      if (error.response?.statusCode == 406) {
        final String errMsg = error.response?.data['message'];
        if (errMsg == "It's different from the previous event.")
          _showValidationErrorFlashBar(context, '이전에 참여한 이벤트와 다른 이벤트입니다.');
        else if (errMsg == "Post is private")
          _showValidationErrorFlashBar(context, '참여한 인스타그램 계정이 비공개 계정입니다.');
        else if (errMsg == "Post is deleted")
          _showValidationErrorFlashBar(context, '참여한 인스타그램 포스트가 삭제되었습니다.');
        else if (errMsg == "Post is different hashtag")
          _showValidationErrorFlashBar(context, '작성한 포스트의 해시태그가 일치하지 않습니다.');
        else
          _showValidationErrorFlashBar(context, '알 수 없는 오류가 발생하였습니다. [406]');
      } else {
        _showValidationErrorFlashBar(context, '알 수 없는 오류가 발생하였습니다. [500]');
      }
    }));

    final response = await dio.post(
        getApi(API.GET_REWARD, suffix: '/${widget.eventId}'),
        data: urlJson);

    widget.loading(false);

    if (response.statusCode == 200) {
      JoinResult result = JoinResult.fromJson(response.data);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => RewardGetScreen(
                  eventTitle: widget.event.title,
                  rewardName: result.reward.name,
                  rewardImage: result.reward.imgPath,
                  url: _urlController.value.text.trim(),
                  postId: result.postId)));
    }
  }

  void _showValidationErrorFlashBar(BuildContext context, String message) {
    context.showFlashBar(
        barType: FlashBarType.error,
        icon: const Icon(Icons.error_outline_rounded),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.white,
        content: Text(message,
            style: TextStyle(fontSize: 14, color: kDefaultFontColor)));
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
