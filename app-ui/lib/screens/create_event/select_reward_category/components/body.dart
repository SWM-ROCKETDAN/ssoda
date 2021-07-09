import 'package:flutter/material.dart';
import '../../../../models/category.dart';
import 'category_tile.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required List<RewardCategoryTile> categoryList,
  })   : _categoryList = categoryList,
        super(key: key);

  final List<RewardCategoryTile> _categoryList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      primary: false,
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemCount: _categoryList.length,
      itemBuilder: (context, index) =>
          CategoryTile(categoryList: _categoryList, index: index),
    );
  }
}
