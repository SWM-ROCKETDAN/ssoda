from .custom_exceptions import CustomException


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


class EventRankCalculateFailed(CustomException):
    default_detail = 'Event rank calculate failed'
    status_code = 500
    default_code = 'SERVER_ERROR_008'

    def __init__(self, data=None):
        super().__init__(data)
