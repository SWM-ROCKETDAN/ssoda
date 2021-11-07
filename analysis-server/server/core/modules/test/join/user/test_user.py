from server.core.modules.static.common import Type
from server.core.modules.static.common import Status
from server.core.modules.assist.time import _get_now_date
import random


def get_random_int_from_start_to_end(start, end):
    return random.randrange(start, end)


def get_test_join_user(sns_id):
    test_join_user = {
        'sns_id': sns_id,
        'url': 'test_url',
        'type': Type.INSTAGRAM,
        'status': Status.PUBLIC,
        'follow_count': get_random_int_from_start_to_end(0, 1000),
        'post_count': get_random_int_from_start_to_end(0, 1000),
        'create_date': _get_now_date(),
        'update_date': _get_now_date(),
    }
    return test_join_user


class UserTester:
    def __init__(self, sns_id):
        self.sns_id = sns_id

    def get_test_join_user(self):
        test_join_user = get_test_join_user(self.sns_id)

        return test_join_user
