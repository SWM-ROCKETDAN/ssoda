import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class StoreOptionsModal extends StatelessWidget {
  const StoreOptionsModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
              title: Text('가게 정보 수정',
                  style: TextStyle(
                      color: kDefaultFontColor.withOpacity(0.8), fontSize: 15)),
              leading: Icon(Icons.edit_rounded,
                  color: kDefaultFontColor.withOpacity(0.8)),
              onTap: () {}),
          ListTile(
            title: Text('가게 삭제',
                style: TextStyle(color: Colors.red, fontSize: 15)),
            leading: Icon(Icons.delete_rounded, color: Colors.red),
            onTap: () {},
          )
        ],
      ),
    ));
  }
}
