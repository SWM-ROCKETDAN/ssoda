import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class StoreDescription extends StatelessWidget {
  final setDescription;
  const StoreDescription({Key? key, required this.setDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.description_rounded, color: kLiteFontColor),
        SizedBox(width: kDefaultPadding),
        Expanded(
          child: TextField(
            maxLines: 4,
            minLines: 4,
            style: TextStyle(fontSize: 14, color: kDefaultFontColor),
            cursorColor: kThemeColor,
            keyboardType: TextInputType.multiline,
            onChanged: (string) {
              setDescription(string);
            },
            decoration: InputDecoration(
                counterText: "",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kThemeColor, width: 1.2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kLiteFontColor, width: 1),
                ),
                contentPadding: const EdgeInsets.all(16),
                hintText: '가게에 대한 간단한 소개글을 입력해주세요',
                hintStyle: TextStyle(color: kLiteFontColor)),
            maxLength: 100,
          ),
        )
      ],
    );
  }
}
