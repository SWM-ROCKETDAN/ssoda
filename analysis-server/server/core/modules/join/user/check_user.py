from server.core.modules.assist.time import get_interval_day_from_now_to_target_date_time
from server.core.modules.static.scrap import Scrap
from server.core.modules.static.common import Status


# 유저 업데이트 날짜 체크
def check_user_is_recently_scraped(update_date):
    if update_date is None:
        return False

    interval_day = get_interval_day_from_now_to_target_date_time(update_date)
    if interval_day > Scrap.USER_SCRAP_NEED_DAY:
        return False
    return True


# 유저 상태가 PUBLIC 인지 체크
def check_user_status_is_public(user_status):
    if user_status is None:
        return False

    if user_status == Status.PUBLIC:
        return True
    return False


# 유저 상태가 PRIVATE 인지 체크
def check_user_status_is_private(user_status):
    if user_status is None:
        return False

    if user_status == Status.PRIVATE:
        return True
    return False


# 유저 상태가 DELETED 인지 체크
def check_user_status_is_deleted(user_status):
    if user_status is None:
        return False

    if user_status == Status.DELETED:
        return True
    return False
