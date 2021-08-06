const baseUrl =
    'http://ec2-3-37-85-236.ap-northeast-2.compute.amazonaws.com:8080/api/v1/';

const s3Url = 'https://hashchecker-bucket.s3.ap-northeast-2.amazonaws.com/';

const instagramPostUrlPrefix = 'https://www.instagram.com/p/';

enum API { GET_EVENT, GET_REWARD }

Map<API, String> apiMap = {
  API.GET_EVENT: '/events',
  API.GET_REWARD: '/join/events'
};

String getApi(API apiType, {String? parameter}) {
  String api = baseUrl;
  api += apiMap[apiType]!;
  if (parameter != null) api += '/$parameter';
  return api;
}
