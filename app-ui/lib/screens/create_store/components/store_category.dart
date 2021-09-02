import 'package:flutter/material.dart';
import 'package:hashchecker/constants.dart';
import 'package:hashchecker/models/store_category.dart';

class StoreCate extends StatelessWidget {
  final setCategory;
  final category;
  const StoreCate({Key? key, required this.setCategory, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(Icons.local_offer_rounded, color: kLiteFontColor),
      SizedBox(width: kDefaultPadding),
      Row(
          children: List.generate(
              storeCategoryList.length,
              (index) => Container(
                  margin: const EdgeInsets.only(right: 7),
                  child: GestureDetector(
                    onTap: () {
                      setCategory(storeCategoryList[index].category);
                    },
                    child: Chip(
                        label: Text(
                          storeCategoryList[index].name,
                          style: TextStyle(
                              color:
                                  storeCategoryList[index].category == category
                                      ? kDefaultFontColor.withOpacity(0.85)
                                      : kLiteFontColor),
                        ),
                        avatar: CircleAvatar(
                            radius: 14,
                            child: Icon(
                              storeCategoryList[index].icon,
                              color: Colors.white,
                              size: 14,
                            ),
                            backgroundColor:
                                storeCategoryList[index].category == category
                                    ? kDefaultFontColor.withOpacity(0.85)
                                    : kLiteFontColor),
                        backgroundColor: kScaffoldBackgroundColor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: storeCategoryList[index].category ==
                                        category
                                    ? kDefaultFontColor.withOpacity(0.85)
                                    : kLiteFontColor),
                            borderRadius: BorderRadius.circular(24))),
                  ))))
    ]);
  }
}
