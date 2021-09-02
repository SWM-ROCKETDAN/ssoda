import 'package:hashchecker/models/store_category.dart';

class Store {
  final String name;
  final StoreCategory category;
  final String city;
  final String country;
  final String town;
  final String roadCode;
  final String road;
  final String zipCode;
  final String description;
  final List<String> images;
  final String logoImage;

  Store(
      {required this.name,
      required this.category,
      required this.city,
      required this.country,
      required this.town,
      required this.roadCode,
      required this.road,
      required this.zipCode,
      required this.description,
      required this.images,
      required this.logoImage});
}
