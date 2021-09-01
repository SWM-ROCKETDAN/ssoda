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
                    hintText: '가게명',
                    hintStyle: TextStyle(color: kLiteFontColor)),
              ),
            )
          ],
        ),
      ],
    );
  }
}
