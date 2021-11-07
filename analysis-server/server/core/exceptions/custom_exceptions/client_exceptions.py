from .custom_exceptions import CustomException


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


class PostUploadIsFasterThanEventStart(CustomException):
    default_detail = 'Post upload is faster than event start'
    status_code = 406
    default_code = 'CLIENT_ERROR_007'

    def __init__(self, data=None):
        super().__init__(data)


class PostEventRewardIsNotOK(CustomException):
    default_detail = 'Post event reward is not ok'
    status_code = 406
    default_code = 'CLIENT_ERROR_008'

    def __init__(self, data=None):
        super().__init__(data)
