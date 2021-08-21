from rest_framework.exceptions import APIException


# 성공
class PostUpdateOk(APIException):
    default_detail = 'Post update ok'
    status_code = 200
    default_code = 'OK_001'


class UserUpdateOk(APIException):
    default_detail = 'User update ok'
    status_code = 200
    default_code = 'OK_002'


# 클라이언트 에러
class PostIsPrivate(APIException):
    default_detail = 'Post is private'
    status_code = 406
    default_code = 'CLIENT_ERROR_001'


class PostIsDeleted(APIException):
    default_detail = 'Post is deleted'
    status_code = 406
    default_code = 'CLIENT_ERROR_002'


class PostIsDiffHashtag(APIException):
    default_detail = 'Post is different hashtag'
    status_code = 406
    default_code = 'CLIENT_ERROR_003'


# 서버 에러
class PostUpdateFailed(APIException):
    default_detail = 'Post update failed'
    status_code = 500
    default_code = 'SERVER_ERROR_001'


class UserUpdateFailed(APIException):
    default_detail = 'User update failed'
    status_code = 500
    default_code = 'SERVER_ERROR_002'


class ProxyFailed(APIException):
    default_detail = 'Proxy is failed'
    status_code = 500
    default_code = 'SERVER_ERROR_003'


class ScrapFailed(APIException):
    default_detail = 'Scrap is failed'
    status_code = 500
    default_code = 'SERVER_ERROR_004'
