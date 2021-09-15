from datetime import datetime
from datetime import timedelta
from .calculator_exposure import calculate_exposure_count
from .calculator_engagement import calculate_comment_count
from .calculator_engagement import calculate_like_count
from .calculator_expenditure import calculate_expenditure_count
from .calculator_expenditure import calculate_level_expenditure
from .calculator_participate import calculate_participate_count
from .calculator_post import calculate_public_post_count
from .calculator_post import calculate_private_post_count
from .calculator_post import calculate_deleted_post_count
from core.modules.assist.time import parse_from_str_time_to_date_time


def get_days_from_start_date_to_now_date(start_date) -> list:
    if not start_date:
        start_date = datetime.now().date()
    days = []
    start_date = parse_from_str_time_to_date_time(start_date).date()
    gap_day = (datetime.now().date() - start_date).days + 1
    for i in range(gap_day):
        day = start_date + timedelta(days=i)
        days.append(day)

    return days


def get_exposure_count(join_post) -> int:
    if 'join_user' in join_post and join_post['join_user'] and 'type' in join_post:
        if 'follow_count' in join_post['join_user']:
            return calculate_exposure_count(join_post['join_user']['follow_count'], join_post['type'])
    return 0


def get_participate_count(join_post) -> int:
    if join_post:
        return calculate_participate_count(join_post)
    return 0


def get_public_post_count(join_post) -> int:
    if 'status' in join_post:
        return calculate_public_post_count(join_post['status'])
    return 0


def get_private_post_count(join_post) -> int:
    if 'status' in join_post:
        return calculate_private_post_count(join_post['status'])
    return 0


def get_deleted_post_count(join_post) -> int:
    if 'status' in join_post:
        return calculate_deleted_post_count(join_post['status'])
    return 0


def get_like_count(join_post) -> int:
    if 'like_count' in join_post:
        return calculate_like_count(join_post['like_count'])
    return 0


def get_comment_count(join_post) -> int:
    if 'comment_count' in join_post:
        return calculate_comment_count(join_post['comment_count'])
    return 0


def get_expenditure_count(join_post) -> int:
    if 'reward' in join_post and join_post['reward']:
        if 'price' in join_post['reward']:
            return calculate_expenditure_count(join_post['reward']['price'])
    return 0


def get_level_expenditure(join_post: dict) -> list:
    if 'reward' in join_post and join_post['reward']:
        if 'level' in join_post['reward'] and 'price' in join_post['reward']:
            return calculate_level_expenditure(join_post['reward']['level'], join_post['reward']['price'])
    return [0, 0, 0, 0, 0]
