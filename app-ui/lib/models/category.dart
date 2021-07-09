import 'package:flutter/material.dart';

enum RewardCategory { DRINK, FOOD, COUPON }

class RewardCategoryTile {
  String _name;
  IconData _icon;
  Color _color;
  RewardCategory _category;

  String get name => _name;
  IconData get icon => _icon;
  Color get color => _color;
  RewardCategory get category => _category;

  RewardCategoryTile(this._name, this._icon, this._color, this._category);
}

List<RewardCategoryTile> categoryTileList = [
  RewardCategoryTile("음료", Icons.local_cafe_outlined, Colors.red.shade300,
      RewardCategory.DRINK),
  RewardCategoryTile(
      "음식", Icons.lunch_dining, Colors.green.shade300, RewardCategory.FOOD),
  RewardCategoryTile("쿠폰", Icons.confirmation_num_outlined,
      Colors.blue.shade300, RewardCategory.COUPON)
];
