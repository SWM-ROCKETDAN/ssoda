const baseUrl =
    'http://ec2-3-37-85-236.ap-northeast-2.compute.amazonaws.com:8080/api/v1';

const eventJoinUrl =
    'http://ec2-13-124-246-123.ap-northeast-2.compute.amazonaws.com';

enum API { LOGIN, GET_ALL_EVENTS, CREATE_EVENT, CREATE_REWARDS }

Map<API, String> apiMap = {
  API.LOGIN: '/login',
  API.GET_ALL_EVENTS: '/events',
  API.CREATE_EVENT: '/events/hashtag/stores',
  API.CREATE_REWARDS: '/rewards/events'
};

String getApi(API apiType, {String? parameter}) {
  String api = baseUrl;
  api += apiMap[apiType]!;
  if (parameter != null) api += '/$parameter';
  return api;
}
