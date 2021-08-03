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

  Map<String, dynamic> toJson() => {
        'category': category.index,
        'name': name,
        'image': imgPath,
        'price': price,
        'count': count,
      };

  Reward.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        imgPath = json['image'],
        category = RewardCategory.values[json['category']],
        price = json['price'],
        count = json['count'];
}
