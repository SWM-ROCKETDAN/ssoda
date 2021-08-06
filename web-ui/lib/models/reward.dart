import 'reward_category.dart';

class Reward {
  final String name;
  final String imgPath;
  final int price;
  final int count;
  final int level;
  final RewardCategory category;

  String get getImgPath => imgPath;
  Reward(
      {required this.name,
      required this.imgPath,
      required this.price,
      required this.count,
      required this.level,
      required this.category});

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
        name: json['name'],
        imgPath: json['image'],
        category: RewardCategory.values[json['category']],
        price: json['price'],
        count: json['count'],
        level: json['level']);
  }
}
