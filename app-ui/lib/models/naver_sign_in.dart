class NaverSignIn {
  bool isLogin;
  String? accessToken;
  NaverAccountInfo accountInfo;
  NaverSignIn(
      {required this.isLogin,
      required this.accessToken,
      required this.accountInfo});
}

class NaverAccountInfo {
  String? name;
  String? email;
  NaverAccountInfo({required this.name, required this.email});
}
