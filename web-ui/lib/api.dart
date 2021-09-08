const baseUrl =
    'http://ec2-3-37-85-236.ap-northeast-2.compute.amazonaws.com:8080';

const s3Url = 'https://hashchecker-bucket.s3.ap-northeast-2.amazonaws.com/';

const instagramPostUrlPrefix = 'https://www.instagram.com/p/';

enum API {
  GET_EVENT,
  GET_REWARD,
  GET_STORE,
  GET_EVENTS_OF_STORE,
  GET_REWARD_OF_EVENT
}

Map<API, String> apiMap = {
  API.GET_EVENT: '/api/v1/events',
  API.GET_REWARD: '/join/events',
  API.GET_STORE: '/api/v1/stores', // '/{store_id}'
  API.GET_EVENTS_OF_STORE: '/api/v1/stores',
  API.GET_REWARD_OF_EVENT:
      '/api/v1/events' // '/{id}/rewards'// '/{store_id}/events'
};

String getApi(API apiType, {String? suffix}) {
  String api = baseUrl;
  api += apiMap[apiType]!;
  if (suffix != null) api += '$suffix';
  return api;
}
