class UserSocialAccount {
  final String name;
  final String email;
  final String image;

  UserSocialAccount(
      {required this.name, required this.email, required this.image});

  Map<String, dynamic> toJson() =>
      {'name': name, 'email': email, 'picture': image};
}
