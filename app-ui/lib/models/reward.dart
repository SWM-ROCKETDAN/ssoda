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

  Map<String, dynamic> toJson() => {
        'category': category.index,
        'name': name,
        'image': imgPath,
        'price': price,
        'count': count,
        'level': level
      };

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
        name: json['name'],
        imgPath: json['imagePath'],
        category: RewardCategory.values[json['category']],
        price: json['price'],
        count: json['count'],
        level: json['level']);
  }
}
