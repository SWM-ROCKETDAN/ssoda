import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker_web/constants.dart';

class DoneButton extends StatelessWidget {
  const DoneButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline, size: 16, color: Colors.black45),
              AutoSizeText(
                ' 가게 사장님께 본 화면을 보여드리고 상품을 받아가세요!',
                style: TextStyle(color: Colors.black45, fontSize: 12),
                minFontSize: 4,
                maxLines: 1,
              )
            ],
          ),
          SizedBox(height: kDefaultPadding),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: TextButton(
              child: Text(
                '닫기',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kThemeColor),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27.0)))),
            ),
          ),
        ],
      ),
    );
  }
}
