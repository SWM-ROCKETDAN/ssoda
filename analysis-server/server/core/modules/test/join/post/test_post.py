import pprint

from server.core.modules.static.common import Type
from server.core.modules.static.common import Status
from server.core.modules.assist.time import get_now_date
from server.core.modules.assist.time import get_days_from_now_date_by_day_delta
import random
from datetime import datetime


def get_random_time_from_date_time(date_time):
    random_hour = random.randrange(8, 20)
    random_minute = random.randrange(0, 59)
    random_second = random.randrange(0, 59)
    date_time = date_time.replace(hour=random_hour, minute=random_minute, second=random_second)

    return date_time


def get_test_join_post(date_time):
    test_join_post = {
        'event': 53,
        'reward': None,
        'sns_id': 'test',
        'url': 'test-url',
        'type': Type.INSTAGRAM,
        'status': Status.PUBLIC,
        'like_count': 100,
        'comment_count': 100,
        'hashtags': 'test, hashtag',
        'create_date': get_now_date(),
        'upload_date': get_now_date(),
        'delete_date': None,
        'reward_date': get_random_time_from_date_time(date_time),
    }
    return test_join_post


def get_test_join_posts(day_delta, try_count):
    days = get_days_from_now_date_by_day_delta(day_delta)
    test_join_posts = []
    for day in days:
        for i in range(try_count):
            test_join_posts.append(get_test_join_post(day))

    return test_join_posts


# get_test_join_posts(2, 10)
