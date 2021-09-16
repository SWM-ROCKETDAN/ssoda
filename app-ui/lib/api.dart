import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as fss;

const baseUrl =
    'http://ec2-3-37-85-236.ap-northeast-2.compute.amazonaws.com:8080';

const eventJoinUrl =
    'http://ec2-13-124-246-123.ap-northeast-2.compute.amazonaws.com';

const s3Url = 'https://image.ssoda.io/';

enum API {
  NAVER_LOGIN,
  KAKAO_LOGIN,
  LOGOUT,
  REFRESH,
  GET_USER_INFO,
  GET_USER_STORES,
  GET_EVENT,
  GET_ALL_EVENTS,
  GET_STORE,
  GET_EVENTS_OF_STORE,
  GET_REWARD_OF_EVENT,
  GET_REPORT_OF_EVENT,
  GET_REPORT_OF_STORE,
  CREATE_STORE,
  CREATE_EVENT,
  CREATE_REWARDS,
  UPDATE_STORE,
  UPDATE_EVENT,
  UPDATE_REWARDS,
  STOP_EVENT,
  DELETE_USER,
  DELETE_STORE,
  DELETE_EVENT,
  DELETE_REWARDS,
}

Map<API, String> apiMap = {
  API.NAVER_LOGIN: '/oauth2/authorization/naver',
  API.KAKAO_LOGIN: '/oauth2/authorization/kakao',
  API.LOGOUT: '/logout',
  API.REFRESH: '/api/v1/auth/refresh',
  API.GET_USER_INFO: '/api/v1/users/me',
  API.GET_USER_STORES: '/api/v1/users/me/stores',
  API.GET_EVENT: '/api/v1/events', // '/{event_id}'
  API.GET_ALL_EVENTS: '/api/v1/events',
  API.GET_STORE: '/api/v1/stores', // '/{store_id}'
  API.GET_EVENTS_OF_STORE: '/api/v1/stores', // '/{store_id}/events'
  API.GET_REWARD_OF_EVENT: '/api/v1/events', // '/{event_id}/rewards'
  API.GET_REPORT_OF_EVENT: '/api/v1/report/events', // '/{event_id}'
  API.GET_REPORT_OF_STORE: '/api/v1/report/stores', // '/{store_id}'
  API.CREATE_STORE: '/api/v1/stores/users',
  API.CREATE_EVENT: '/api/v1/events/hashtag/stores',
  API.CREATE_REWARDS: '/api/v1/rewards/events',
  API.UPDATE_STORE: '/api/v1/stores', // '/{store_id}'
  API.UPDATE_EVENT: '/api/v1/events/hashtag', // '/{event_id}'
  API.UPDATE_REWARDS: '/api/v1/rewards',
  API.STOP_EVENT: '/api/v1/events', // '/{event_id}/status'
  API.DELETE_USER: '/api/v1/users/me',
  API.DELETE_STORE: '/api/v1/stores', // '/{store_id}'
  API.DELETE_EVENT: '/api/v1/events', // '/{event_id}'
  API.DELETE_REWARDS: '/api/v1/rewards'
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

  dio.interceptors.clear();
  dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
    final accessToken = await storage.read(key: 'ACCESS_TOKEN');
    // request with accessToken
    options.headers['Authorization'] = 'Bearer $accessToken';
    return handler.next(options);
  }, onError: (error, handler) async {
    // when accessToken expired
    if (error.response?.statusCode == 401) {
      // request refreshing with refreshToken
      final accessToken = await storage.read(key: 'ACCESS_TOKEN');
      final refreshToken = await storage.read(key: 'REFRESH_TOKEN');

      var refreshDio = Dio();
      refreshDio.interceptors.clear();
      refreshDio.interceptors
          .add(InterceptorsWrapper(onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          print('로그인이 만료되었습니다. 다시 해주세용');
        }
        return handler.next(error);
      }));

      // setting refreshDio options
      refreshDio.options.headers['Authorization'] = 'Bearer $accessToken';
      refreshDio.options.headers['refresh_token'] = 'Bearer $refreshToken';

      // get refreshToken
      final refreshResponse = await refreshDio.get(getApi(API.REFRESH));

      // parsing tokens
      final newAccessToken = refreshResponse.headers['access_token']![0];
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
