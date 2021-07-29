class KakaoSignIn {
  bool isLogin;
  String? authCode;
  String? accessToken;
  KakaoAccountInfo accountInfo;

  KakaoSignIn(
      {required this.isLogin,
      required this.authCode,
      required this.accessToken,
      required this.accountInfo});
}

class KakaoAccountInfo {
  String? name;
  String? email;
  KakaoAccountInfo({this.name, this.email});
}
