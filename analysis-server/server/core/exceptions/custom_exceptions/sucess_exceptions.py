from .custom_exceptions import CustomException


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


class UserRecentlyUpdateAndOK(CustomException):
    default_detail = 'User recently update and ok'
    status_code = 200
    default_code = 'OK_007'

    def __init__(self, data=None):
        super().__init__(data)


class EventRankCalculateOK(CustomException):
    default_detail = "Event rank calculate ok"
    status_code = 200
    default_code = "OK_008"

    def __init__(self, data=None):
        super().__init__(data)
