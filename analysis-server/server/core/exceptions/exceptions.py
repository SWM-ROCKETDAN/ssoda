from rest_framework.exceptions import APIException


class CustomException(APIException):
    def __init__(self, data=None):
        super().__init__()
        if data is None:
            data = {}
        self.data = data


# 성공
class PostUpdateOk(CustomException):
    default_detail = 'Post update ok'
    status_code = 200
    default_code = 'OK_001'

    def __init__(self, data=None):
        super().__init__(data)


class UserUpdateOk(CustomException):
    default_detail = 'User update ok'
    status_code = 200
    default_code = 'OK_002'

    def __init__(self, data=None):
        super().__init__(data)


class RewardCalculateOK(CustomException):
    default_detail = 'Reward calculate ok'
    status_code = 200
    default_code = 'OK_003'

    def __init__(self, data=None):
        super().__init__(data)


class EventReportCalculateOK(CustomException):
    default_detail = 'Event report calculate ok'
    status_code = 200
    default_code = 'OK_004'

    def __init__(self, data=None):
        super().__init__(data)


class StoreReportCalculateOK(CustomException):
    default_detail = 'Store report calculate ok'
    status_code = 200
    default_code = 'OK_005'

    def __init__(self, data=None):
        super().__init__(data)


class PostIsAlreadyCalculatedRewardAndOK(CustomException):
    default_detail = 'Post is already calculated reward and ok'
    status_code = 200
    default_code = 'OK_006'

    def __init__(self, data=None):
        super().__init__(data)


class UserUpdateDontButOK(CustomException):
    default_detail = 'User update dont but ok'
    status_code = 200
    default_code = 'OK_007'

    def __init__(self, data=None):
        super().__init__(data)


# 클라이언트 에러
class Http404(CustomException):
    default_detail = 'Not found'
    status_code = 404
    default_code = 'CLIENT_ERROR_001'

    def __init__(self, data=None):
        super().__init__(data)


class PostIsPrivate(CustomException):
    default_detail = 'Post is private'
    status_code = 406
    default_code = 'CLIENT_ERROR_002'

    def __init__(self, data=None):
        super().__init__(data)


class PostIsDeleted(CustomException):
    default_detail = 'Post is deleted'
    status_code = 406
    default_code = 'CLIENT_ERROR_003'

    def __init__(self, data=None):
        super().__init__(data)


class PostIsDiffHashtag(CustomException):
    default_detail = 'Post is different hashtag'
    status_code = 406
    default_code = 'CLIENT_ERROR_004'

    def __init__(self, data=None):
        super().__init__(data)


class PostIsAlreadyRewarded(CustomException):
    default_detail = 'Post is already rewarded'
    status_code = 406
    default_code = 'CLIENT_ERROR_005'

    def __init__(self, data=None):
        super().__init__(data)


class PostEventIsNotOK(CustomException):
    default_detail = 'Post event is not ok'
    status_code = 406
    default_code = 'CLIENT_ERROR_006'

    def __init__(self, data=None):
        super().__init__(data)


# 서버 에러
class ProxyFailed(CustomException):
    default_detail = 'Proxy is failed'
    status_code = 500
    default_code = 'SERVER_ERROR_001'

    def __init__(self, data=None):
        super().__init__(data)


class ScrapFailed(CustomException):
    default_detail = 'Scrap is failed'
    status_code = 500
    default_code = 'SERVER_ERROR_002'

    def __init__(self, data=None):
        super().__init__(data)


class PostUpdateFailed(CustomException):
    default_detail = 'Post update failed'
    status_code = 500
    default_code = 'SERVER_ERROR_003'

    def __init__(self, data=None):
        super().__init__(data)


class UserUpdateFailed(CustomException):
    default_detail = 'User update failed'
    status_code = 500
    default_code = 'SERVER_ERROR_004'

    def __init__(self, data=None):
        super().__init__(data)


class RewardCalculateFailed(CustomException):
    default_detail = 'Reward calculate failed'
    status_code = 500
    default_code = 'SERVER_ERROR_005'

    def __init__(self, data=None):
        super().__init__(data)


class EventReportCalculateFailed(CustomException):
    default_detail = 'Event Report calculate failed'
    status_code = 500
    default_code = 'SERVER_ERROR_006'

    def __init__(self, data=None):
        super().__init__(data)


class StoreReportCalculateFailed(CustomException):
    default_detail = 'Store Report calculate failed'
    status_code = 500
    default_code = 'SERVER_ERROR_007'

    def __init__(self, data=None):
        super().__init__(data)
