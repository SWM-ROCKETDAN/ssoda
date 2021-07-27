class NaverSignIn {
  bool isLogin;
  String? accessToken;
  String? expiresAt;
  String? tokenType;
  String? refreshToken;
  AccountInfo? accountInfo;
  NaverSignIn(
      {required this.isLogin,
      this.accessToken,
      this.expiresAt,
      this.tokenType,
      this.refreshToken,
      this.accountInfo});
}

class AccountInfo {
  String? name;
  String? email;
  AccountInfo({this.name, this.email});
}
