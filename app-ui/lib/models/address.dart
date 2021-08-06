class Address {
  final String city;
  final String country;
  final String town;
  final String roadCode;
  final String road;
  final String zipCode;

  Address(
      {required this.city,
      required this.country,
      required this.town,
      required this.roadCode,
      required this.road,
      required this.zipCode});

  Map<String, dynamic> toJson() => {
        'city': city,
        'country': country,
        'town': town,
        'roadCode': roadCode,
        'road': road,
        'zipCode': zipCode
      };
}
