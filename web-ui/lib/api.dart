const baseUrl =
    'http://ec2-3-37-85-236.ap-northeast-2.compute.amazonaws.com:8080/api/v1/';

const s3Url = 'https://hashchecker-bucket.s3.ap-northeast-2.amazonaws.com/';

enum API { GET_EVENT }

Map<API, String> apiMap = {API.GET_EVENT: '/events'};

String getApi(API apiType, {String? parameter}) {
  String api = baseUrl;
  api += apiMap[apiType]!;
  if (parameter != null) api += '/$parameter';
  return api;
}
