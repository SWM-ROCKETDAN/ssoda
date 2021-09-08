from datetime import datetime
from datetime import timedelta
from .calculator_exposure import calculate_exposure_count
from .calculator_engagement import calculate_comment_count
from .calculator_engagement import calculate_like_count
from .calculator_expenditure import calculate_expenditure_count
from .calculator_participate import calculate_participate_count
from .calculator_post import calculate_public_post_count
from .calculator_post import calculate_private_post_count
from .calculator_post import calculate_deleted_post_count
from core.modules.assist.time import parse_from_str_time_to_date_time

def parse_from_str_date_to_datetime_date(str_date):
    return datetime.strptime(str_date, '%Y-%m-%dT%H:%M:%S').date()


def get_days_from_start_date_to_now_date(start_date):
    days = []
    start_date = parse_from_str_time_to_date_time(start_date).date()
    gap_day = (datetime.now().date() - start_date).days + 1
    for i in range(gap_day):
        day = start_date + timedelta(days=i)
        print(day)
        days.append((start_date + timedelta(days=i)))

    return days


def get_exposure_count(event_join):
    if event_join.get('join_user') is not None:
        follow_count = event_join['join_user'].get('follow_count')
    else:
        follow_count = 0
    return calculate_exposure_count(follow_count, event_join['type'])


def get_participate_count(event_join):
    return calculate_participate_count(event_join)


def get_public_post_count(event_join):
    return calculate_public_post_count(event_join['status'])


def get_private_post_count(event_join):
    return calculate_private_post_count(event_join['status'])


def get_deleted_post_count(event_join):
    return calculate_deleted_post_count(event_join['status'])


def get_like_count(event_join):
    return calculate_like_count(event_join['like_count'])


def get_comment_count(event_join):
    return calculate_comment_count(event_join['comment_count'])


def get_expenditure_count(event_join):
    return calculate_expenditure_count(event_join['reward']['price'])
