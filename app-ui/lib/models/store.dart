import 'package:hashchecker/models/store_category.dart';
import 'address.dart';

class Store {
  final String name;
  final StoreCategory category;
  final Address address;
  final String description;
  final List<String> images;
  final String logoImage;

  Store(
      {required this.name,
      required this.category,
      required this.address,
      required this.description,
      required this.images,
      required this.logoImage});
}
