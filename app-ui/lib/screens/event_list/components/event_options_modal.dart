import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class EventOptionsModal extends StatelessWidget {
  const EventOptionsModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text('이벤트 미리보기',
                style: TextStyle(
                    color: kDefaultFontColor.withOpacity(0.8), fontSize: 15)),
            leading: Icon(Icons.description_rounded,
                color: kDefaultFontColor.withOpacity(0.8)),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text('이벤트 편집',
                style: TextStyle(
                    color: kDefaultFontColor.withOpacity(0.8), fontSize: 15)),
            leading: Icon(Icons.edit_rounded,
                color: kDefaultFontColor.withOpacity(0.8)),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text('마케팅 보고서',
                style: TextStyle(
                    color: kDefaultFontColor.withOpacity(0.8), fontSize: 15)),
            leading: Icon(Icons.assessment_rounded,
                color: kDefaultFontColor.withOpacity(0.8)),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text('이벤트 중지',
                style: TextStyle(
                    color: kDefaultFontColor.withOpacity(0.8), fontSize: 15)),
            leading: Icon(Icons.stop_rounded,
                color: kDefaultFontColor.withOpacity(0.8)),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text('이벤트 삭제',
                style: TextStyle(color: Colors.redAccent, fontSize: 15)),
            leading: Icon(Icons.delete_rounded, color: Colors.redAccent),
            onTap: () => Navigator.of(context).pop(),
          )
        ],
      ),
    ));
  }
}
