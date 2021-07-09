import 'package:flutter/material.dart';
import 'components/body.dart';
import '../../../models/category.dart';

class SelectRewardCategoryScreen extends StatefulWidget {
  const SelectRewardCategoryScreen({Key? key}) : super(key: key);

  @override
  _SelectRewardCategoryScreenState createState() =>
      _SelectRewardCategoryScreenState();
}

class _SelectRewardCategoryScreenState
    extends State<SelectRewardCategoryScreen> {
  List<RewardCategoryTile> _categoryList = categoryTileList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(), body: Body(categoryList: _categoryList));
  }

  AppBar buildAppBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '보상 카테고리 선택',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true);
  }
}
