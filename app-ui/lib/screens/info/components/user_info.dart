import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/user.dart';

class UserInfo extends StatelessWidget {
  final User user;
  const UserInfo({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                    color: kShadowColor,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(user.picture), fit: BoxFit.cover))),
            SizedBox(width: kDefaultPadding),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(user.name,
                  style: TextStyle(color: kDefaultFontColor, fontSize: 14)),
              SizedBox(height: kDefaultPadding / 5),
              Text(user.email,
                  style: TextStyle(color: kLiteFontColor, fontSize: 12))
            ])
          ],
        ),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: kShadowColor,
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(2, 2), // changes position of shadow
              ),
            ],
            color: kScaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12)));
  }
}
