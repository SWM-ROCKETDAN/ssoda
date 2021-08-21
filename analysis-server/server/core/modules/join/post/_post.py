from ..time import get_now_time
import copy


def get_default_post():
    post = {
        'sns_id': '',
        'url': '',
        'type': 0,
        'status': 0,
        'like_count': 0,
        'comment_count': 0,
        'hashtags': '',
        'upload_date': get_now_time(),
        'private_date': None,
        'delete_data': None,
        'update_date': get_now_time(),
    }

    return copy.deepcopy(post)

