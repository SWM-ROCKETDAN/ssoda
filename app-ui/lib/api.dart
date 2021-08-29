const baseUrl =
    'http://ec2-3-37-85-236.ap-northeast-2.compute.amazonaws.com:8080';

const eventJoinUrl =
    'http://ec2-13-124-246-123.ap-northeast-2.compute.amazonaws.com';

enum API {
  NAVER_LOGIN,
  KAKAO_LOGIN,
  GET_ALL_EVENTS,
  CREATE_EVENT,
  CREATE_REWARDS
}

Map<API, String> apiMap = {
  API.NAVER_LOGIN: '/oauth2/authorization/naver',
  API.KAKAO_LOGIN: '/oauth2/authorization/kakao',
  API.GET_ALL_EVENTS: '/api/v1/events',
  API.CREATE_EVENT: '/api/v1/events/hashtag/stores',
  API.CREATE_REWARDS: '/api/v1/rewards/events'
};

String getApi(API apiType, {String? parameter}) {
  String api = baseUrl;
  api += apiMap[apiType]!;
  if (parameter != null) api += '/$parameter';
  return api;
}
