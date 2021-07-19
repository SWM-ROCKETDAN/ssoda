import 'reward_category.dart';

class Reward {
  final String name;
  final String imgPath;
  final int price;
  final int count;
  final RewardCategory category;

  String get getImgPath => imgPath;
  Reward(
      {required this.name,
      required this.imgPath,
      required this.price,
      required this.count,
      required this.category});
}
