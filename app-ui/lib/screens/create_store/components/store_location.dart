import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';

class StoreLocation extends StatelessWidget {
  const StoreLocation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.location_on_rounded, color: kLiteFontColor),
            SizedBox(width: kDefaultPadding),
            Expanded(
              child: TextField(
                style: TextStyle(fontSize: 14, color: kDefaultFontColor),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kThemeColor, width: 1.2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kLiteFontColor, width: 1),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    hintText: '우편번호',
                    hintStyle: TextStyle(color: kLiteFontColor)),
              ),
            ),
            SizedBox(width: kDefaultPadding / 3),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                '우편번호 찾기',
                style: TextStyle(fontSize: 13),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      kDefaultFontColor.withOpacity(0.85))),
            ),
          ],
        ),
        SizedBox(height: kDefaultPadding / 3),
        Row(
          children: [
            Icon(Icons.location_on_rounded, color: kScaffoldBackgroundColor),
            SizedBox(width: kDefaultPadding),
            Expanded(
              child: TextField(
                style: TextStyle(fontSize: 14, color: kDefaultFontColor),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kThemeColor, width: 1.2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kLiteFontColor, width: 1),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    hintText: '주소',
                    hintStyle: TextStyle(color: kLiteFontColor)),
              ),
            ),
          ],
        ),
        SizedBox(height: kDefaultPadding / 3),
        Row(
          children: [
            Icon(Icons.location_on_rounded, color: kScaffoldBackgroundColor),
            SizedBox(width: kDefaultPadding),
            Expanded(
              child: TextField(
                style: TextStyle(fontSize: 14, color: kDefaultFontColor),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kThemeColor, width: 1.2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kLiteFontColor, width: 1),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    hintText: '상세주소',
                    hintStyle: TextStyle(color: kLiteFontColor)),
              ),
            ),
            SizedBox(width: kDefaultPadding / 3),
            Expanded(
              child: TextField(
                style: TextStyle(fontSize: 14, color: kDefaultFontColor),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kThemeColor, width: 1.2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kLiteFontColor, width: 1),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    hintText: '참고항목',
                    hintStyle: TextStyle(color: kLiteFontColor)),
              ),
            ),
          ],
        )
      ],
    );
  }
}
