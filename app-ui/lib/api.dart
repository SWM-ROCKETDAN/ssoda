const baseUrl =
    'http://ec2-3-37-85-236.ap-northeast-2.compute.amazonaws.com:8080/api/v1';

enum API { LOGIN, GET_ALL_EVENTS }

Map<API, String> apiMap = {API.LOGIN: '/login', API.GET_ALL_EVENTS: '/events'};

String getApi(API apiType, {String? parameter}) {
  String api = baseUrl;
  api += apiMap[apiType]!;
  if (parameter != null) api += '/$parameter';
  return api;
}
