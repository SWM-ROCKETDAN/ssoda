import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/event.dart';
import 'package:hashchecker/screens/hall/hall_screen.dart';
import 'package:hashchecker/screens/marketing_report/event_report/event_report_screen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'event_edit_modal.dart';

class EventOptionsModal extends StatelessWidget {
  final int eventId;
  final EventStatus eventStatus;
  final bool isAlreadyInPreview;
  const EventOptionsModal(
      {Key? key,
      required this.eventId,
      required this.eventStatus,
      required this.isAlreadyInPreview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (!isAlreadyInPreview)
            ListTile(
              title: Text('이벤트 미리보기',
                  style: TextStyle(
                      color: kDefaultFontColor.withOpacity(0.8), fontSize: 15)),
              leading: Icon(Icons.description_rounded,
                  color: kDefaultFontColor.withOpacity(0.8)),
              onTap: () => Navigator.of(context).pop(),
            ),
          ListTile(
            enabled: _isEnableToEdit(),
            title: Text('이벤트 편집',
                style: TextStyle(
                    color: _isEnableToEdit()
                        ? kDefaultFontColor.withOpacity(0.8)
                        : kLiteFontColor.withOpacity(0.5),
                    fontSize: 15)),
            leading: Icon(Icons.edit_rounded,
                color: _isEnableToEdit()
                    ? kDefaultFontColor.withOpacity(0.8)
                    : kLiteFontColor.withOpacity(0.5)),
            onTap: () => showBarModalBottomSheet(
              expand: true,
              context: context,
              builder: (context) => EventEditModal(
                eventId: eventId,
              ),
            ),
          ),
          ListTile(
            title: Text('마케팅 보고서',
                style: TextStyle(
                    color: kDefaultFontColor.withOpacity(0.8), fontSize: 15)),
            leading: Icon(Icons.assessment_rounded,
                color: kDefaultFontColor.withOpacity(0.8)),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EventReportScreen(eventId: eventId))),
          ),
          ListTile(
            enabled: _isEnableToStop(),
            title: Text('이벤트 중지',
                style: TextStyle(
                    color: _isEnableToStop()
                        ? kDefaultFontColor.withOpacity(0.8)
                        : kLiteFontColor.withOpacity(0.5),
                    fontSize: 15)),
            leading: Icon(Icons.stop_rounded,
                color: _isEnableToStop()
                    ? kDefaultFontColor.withOpacity(0.8)
                    : kLiteFontColor.withOpacity(0.5)),
            onTap: () => _showEventStopDialog(context),
          ),
          ListTile(
            enabled: _isEnableToDelete(),
            title: Text('이벤트 삭제',
                style: TextStyle(
                    color: _isEnableToDelete()
                        ? Colors.red
                        : kLiteFontColor.withOpacity(0.5),
                    fontSize: 15)),
            leading: Icon(Icons.delete_rounded,
                color: _isEnableToDelete()
                    ? Colors.red
                    : kLiteFontColor.withOpacity(0.5)),
            onTap: () => _showEventDeleteDialog(context),
          )
        ],
      ),
    ));
  }

  bool _isEnableToStop() {
    return eventStatus == EventStatus.PROCEEDING;
  }

  bool _isEnableToDelete() {
    return eventStatus == EventStatus.ENDED;
  }

  bool _isEnableToEdit() {
    return eventStatus != EventStatus.ENDED;
  }

  void _showEventDeleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Center(
              child: Text('이벤트 삭제',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kDefaultFontColor),
                  textAlign: TextAlign.center),
            ),
            content: IntrinsicHeight(
              child: Column(children: [
                Text("이벤트 삭제 시 이벤트가",
                    style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
                SizedBox(height: kDefaultPadding / 5),
                Text("즉시 종료되며 복구할 수 없습니다.",
                    style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
                SizedBox(height: kDefaultPadding / 5),
                Text("그래도 삭제하시겠습니까?",
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
                        await _deleteEvent(eventId);
                        Navigator.of(context).pop();
                        await _showEventDeleteCompleteDialog(context);
                      },
                      child: Text('삭제', style: TextStyle(color: Colors.red)),
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all<Color>(
                              Colors.red.withOpacity(0.1))),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('취소'),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red)),
                    ),
                  ],
                ),
              )
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))));
  }

  Future<void> _showEventDeleteCompleteDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Center(
              child: Text('이벤트 삭제',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kDefaultFontColor),
                  textAlign: TextAlign.center),
            ),
            content: Text("이벤트 삭제가 완료되었습니다",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HallScreen(),
                      ),
                    );
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
    Navigator.pop(context);
  }

  void _showEventStopDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Center(
              child: Text('이벤트 중지',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kDefaultFontColor),
                  textAlign: TextAlign.center),
            ),
            content: IntrinsicHeight(
              child: Column(children: [
                Text("이벤트를 중지하면 고객들이 더 이상",
                    style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
                SizedBox(height: kDefaultPadding / 5),
                Text("이벤트에 참여할 수 없게 됩니다.",
                    style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
                SizedBox(height: kDefaultPadding / 5),
                Text("그래도 중지하시겠습니까?",
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
                        await _stopEvent(eventId);
                        Navigator.of(context).pop();
                        await _showEventStopCompleteDialog(context);
                      },
                      child: Text('중지',
                          style: TextStyle(color: Colors.redAccent.shade400)),
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent.shade400.withOpacity(0.1))),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('취소'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent.shade400)),
                    ),
                  ],
                ),
              )
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))));
  }

  Future<void> _stopEvent(int eventId) async {
    var dio = await authDio();
    final eventStopResponse = await dio.put(
        'http://ec2-3-37-85-236.ap-northeast-2.compute.amazonaws.com:8080/api/v1/events/$eventId/status',
        data: {'status': 2});
    print(eventStopResponse.data);
  }

  Future<void> _deleteEvent(int eventId) async {
    var dio = await authDio();
    final eventDeleteResponse =
        await dio.delete(getApi(API.DELETE_EVENT, suffix: '/$eventId'));
    print(eventDeleteResponse.data);
  }

  Future<void> _showEventStopCompleteDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Center(
              child: Text('이벤트 중지',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kDefaultFontColor),
                  textAlign: TextAlign.center),
            ),
            content: Text("이벤트가 중지되었습니다.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: kDefaultFontColor)),
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HallScreen(),
                      ),
                    );
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
    Navigator.pop(context);
  }
}
