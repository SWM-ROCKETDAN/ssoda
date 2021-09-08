import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class StoreName extends StatelessWidget {
  final setName;
  const StoreName({Key? key, required this.setName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.store_rounded, color: kLiteFontColor),
        SizedBox(width: kDefaultPadding),
        Expanded(
          child: TextField(
            style: TextStyle(fontSize: 14, color: kDefaultFontColor),
            cursorColor: kThemeColor,
            keyboardType: TextInputType.text,
            onChanged: (string) {
              setName(string);
            },
            decoration: InputDecoration(
                counterText: "",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kThemeColor, width: 1.2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kLiteFontColor, width: 1),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                hintText: '가게명',
                hintStyle: TextStyle(color: kLiteFontColor)),
            maxLength: 20,
          ),
        )
      ],
    );
  }
}
