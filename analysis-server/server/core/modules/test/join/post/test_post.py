from server.core.modules.static.common import Type
from server.core.modules.static.common import Status
from server.core.modules.assist.time import _get_now_date
from server.core.modules.assist.time import _get_days_from_now_date_by_day_delta
import random


def get_random_time_from_date_time(date_time):
    random_hour = random.randrange(8, 20)
    random_minute = random.randrange(0, 59)
    random_second = random.randrange(0, 59)
    date_time = date_time.replace(hour=random_hour, minute=random_minute, second=random_second)

    return date_time


def get_random_int_from_start_to_end(start, end):
    return random.randrange(start, end)


def get_test_join_post(date_time, event_id, reward_id, sns_id):
    test_join_post = {
        'event': event_id,
        'reward': reward_id,
        'sns_id': sns_id,
        'url': 'test-url',
        'type': Type.INSTAGRAM,
        'status': Status.PUBLIC,
        'like_count': get_random_int_from_start_to_end(0, 100),
        'comment_count': get_random_int_from_start_to_end(0, 100),
        'hashtags': 'test, hashtag',
        'create_date': _get_now_date(),
        'upload_date': _get_now_date(),
        'delete_date': None,
        'reward_date': get_random_time_from_date_time(date_time),
    }
    return test_join_post


class PostTester:
    def __init__(self, day_delta, try_count, event_id, reward_id, sns_id):
        self.day_delta = day_delta
        self.try_count = try_count
        self.event_id = event_id
        self.reward_id = reward_id
        self.sns_id = sns_id

    def get_test_join_posts(self):
        days = _get_days_from_now_date_by_day_delta(self.day_delta)
        test_join_posts = []
        for day in days:
            for i in range(self.try_count):
                test_join_post = get_test_join_post(day, self.event_id, self.reward_id, self.sns_id)
                test_join_posts.append(test_join_post)

        return test_join_posts
