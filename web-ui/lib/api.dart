const baseUrl = 'https://api.ssoda.io';

const s3Url = 'https://image.ssoda.io/';

const instagramPostUrlPrefix = 'https://www.instagram.com/p/';

enum API {
  GET_EVENT,
  GET_REWARD,
  GET_STORE,
  GET_EVENTS_OF_STORE,
  GET_REWARD_OF_EVENT,
  JOIN_EVENT_COMPLETE
}

Map<API, String> apiMap = {
  API.GET_EVENT: '/api/v1/events',
  API.GET_REWARD: '/join/events',
  API.GET_STORE: '/api/v1/stores', // '/{store_id}'
  API.GET_EVENTS_OF_STORE: '/api/v1/stores',
  API.GET_REWARD_OF_EVENT:
      '/api/v1/events', // '/{id}/rewards'// '/{store_id}/events'
  API.JOIN_EVENT_COMPLETE: '/api/v1/join/posts' // '/{post_id}
};

String getApi(API apiType, {String? suffix}) {
  String api = baseUrl;
  api += apiMap[apiType]!;
  if (suffix != null) api += '$suffix';
  return api;
}
