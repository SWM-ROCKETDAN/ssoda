import 'address.dart';

class Store {
  final String name;
  final int category;
  final Address address;
  final String description;
  final List<String> images;

  Store(
      {required this.name,
      required this.category,
      required this.address,
      required this.description,
      required this.images});

  Map<String, dynamic> toJson() => {
        'name': name,
        'category': category,
        'address': address,
        'description': description,
        'images': images,
      };
}
