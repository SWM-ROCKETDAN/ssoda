import 'package:flutter/material.dart';
import 'package:hashchecker/models/category.dart';
import 'package:hashchecker/models/reward.dart';
import '../../input_reward_info/input_reward_info_screen.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    Key? key,
    required List<RewardCategoryTile> categoryList,
    required int index,
  })   : _categoryList = categoryList,
        _index = index,
        super(key: key);

  final List<RewardCategoryTile> _categoryList;
  final _index;

  _navigateAndRewardDefinition(
      BuildContext context, RewardCategory category) async {
    final Reward? result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InputRewardInfoScreen(
                  category: category,
                )));

    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          _navigateAndRewardDefinition(context, _categoryList[_index].category);
        },
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            _categoryList[_index].icon,
            size: 40,
          ),
          SizedBox(height: 15),
          Text(_categoryList[_index].name, style: TextStyle(fontSize: 18))
        ]),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(_categoryList[_index].color),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)))));
  }
}
