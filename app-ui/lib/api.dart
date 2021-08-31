import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as fss;

const baseUrl =
    'http://ec2-3-37-85-236.ap-northeast-2.compute.amazonaws.com:8080';

const eventJoinUrl =
    'http://ec2-13-124-246-123.ap-northeast-2.compute.amazonaws.com';

enum API {
  NAVER_LOGIN,
  KAKAO_LOGIN,
  LOGOUT,
  REFRESH,
  GET_USER_INFO,
  GET_USER_STORE,
  GET_ALL_EVENTS,
  CREATE_STORE,
  CREATE_EVENT,
  CREATE_REWARDS
}

Map<API, String> apiMap = {
  API.NAVER_LOGIN: '/oauth2/authorization/naver',
  API.KAKAO_LOGIN: '/oauth2/authorization/kakao',
  API.LOGOUT: '/logout',
  API.REFRESH: '/api/v1/auth/refresh',
  API.GET_USER_INFO: '/api/v1/users/me',
  API.GET_USER_STORE: '/api/v1/users/me/stores',
  API.GET_ALL_EVENTS: '/api/v1/events',
  API.CREATE_STORE: '/api/v1/stores/users',
  API.CREATE_EVENT: '/api/v1/events/hashtag/stores',
  API.CREATE_REWARDS: '/api/v1/rewards/events'
};

String getApi(API apiType, {String? suffix}) {
  String api = baseUrl;
  api += apiMap[apiType]!;
  if (suffix != null) api += '$suffix';
  return api;
}

Future<Dio> authDio() async {
  var dio = Dio();

  final storage = new fss.FlutterSecureStorage();
  final accessToken = await storage.read(key: 'ACCESS_TOKEN');

  dio.interceptors.clear();
  dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
    // request with accessToken
    options.headers['Authorization'] = 'Bearer $accessToken';
    return handler.next(options);
  }, onError: (error, handler) async {
    // when accessToken expired
    if (error.response?.statusCode == 401) {
      // request refreshing with refreshToken
      final refreshToken = await storage.read(key: 'REFRESH_TOKEN');

      var refreshDio = Dio();
      // var cookieJar = CookieJar();

      // setting refreshDio options
      // refreshDio.interceptors.add(CookieManager(cookieJar));
      refreshDio.options.headers['Authorization'] = 'Bearer $accessToken';
      refreshDio.options.headers['refresh_token'] = '$refreshToken';

      // get refreshToken
      final refreshResponse = await refreshDio.get(getApi(API.REFRESH));

      // parsing tokens
      final newAccessToken = refreshResponse.headers['token']![0];
      final newRefreshToken = refreshResponse.headers['refresh_token']![0];

      // update dio request headers token
      error.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

      // udpate secure storage token data
      await storage.write(key: 'ACCESS_TOKEN', value: newAccessToken);
      await storage.write(key: 'REFRESH_TOKEN', value: newRefreshToken);

      // create clonedRequest to request again
      final clonedRequest = await dio.request(error.requestOptions.path,
          options: Options(
              method: error.requestOptions.method,
              headers: error.requestOptions.headers),
          data: error.requestOptions.data,
          queryParameters: error.requestOptions.queryParameters);

      return handler.resolve(clonedRequest);
    }
    return handler.next(error);
  }));
  return dio;
}
