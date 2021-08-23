from datetime import datetime
from datetime import timedelta
from .calculator_exposure import calculate_exposure_count
from .calculator_engagement import calculate_comment_count
from .calculator_engagement import calculate_like_count
from .calculator_expenditure import calculate_expenditure_count
from .calculator_participate import calculate_participate_count
from .calculator_post import calculate_post_count
from server.core.modules.static.common import Status


def parse_from_str_date_to_datetime_date(str_date):
    return datetime.strptime(str_date, '%Y-%m-%dT%H:%M:%S').date()


def get_days_from_start_date_to_now_date(start_date):
    days = []
    start_date = parse_from_str_date_to_datetime_date(start_date)
    gap_day = (datetime.now().date() - start_date).days + 1
    for i in range(gap_day):
        days.append((start_date + timedelta(days=i)))

    return days


def get_exposure_count(event_join):
    return calculate_exposure_count(event_join['join_user']['follow_count'])


def get_participate_count(event_join):
    return calculate_participate_count(event_join)


def get_public_post_count(event_join):
    return calculate_post_count(event_join['status'], Status.PUBLIC)


def get_private_post_count(event_join):
    return calculate_post_count(event_join['status'], Status.PRIVATE)


def get_deleted_post_count(event_join):
    return calculate_post_count(event_join['status'], Status.DELETED)


def get_like_count(event_join):
    return calculate_like_count(event_join['like_count'])


def get_comment_count(event_join):
    return calculate_comment_count(event_join['comment_count'])


def get_expenditure_count(event_join):
    return calculate_expenditure_count(event_join['reward']['price'])
