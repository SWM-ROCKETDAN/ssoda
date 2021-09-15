import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/screens/info/store_edit/store_edit_screen.dart';

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
              onTap: () {
                Navigator.push(context, slidePageRouting(StoreEditScreen()));
              }),
          ListTile(
            title: Text('가게 삭제',
                style: TextStyle(color: Colors.red, fontSize: 15)),
            leading: Icon(Icons.delete_rounded, color: Colors.red),
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: Center(
                        child: Text('가게 삭제',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: kDefaultFontColor),
                            textAlign: TextAlign.center),
                      ),
                      content: IntrinsicHeight(
                        child: Column(children: [
                          Text("가게 삭제 시 모든 이벤트와 정보와 마케팅",
                              style: TextStyle(
                                  fontSize: 14, color: kDefaultFontColor)),
                          Text("보고서가 삭제되며 복구할 수 없습니다.",
                              style: TextStyle(
                                  fontSize: 14, color: kDefaultFontColor)),
                          Text("그래도 삭제하시겠습니까?",
                              style: TextStyle(
                                  fontSize: 14, color: kDefaultFontColor)),
                        ]),
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                      actions: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
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
                                child:
                                    Text('아니오', style: TextStyle(fontSize: 13)),
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
          )
        ],
      ),
    ));
  }
}
