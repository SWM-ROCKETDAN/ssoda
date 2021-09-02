from server.core.modules.assist.time import get_now_date
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
        'upload_date': get_now_date(),
        'private_date': None,
        'delete_data': None,
        'update_date': get_now_date(),
    }

    return copy.deepcopy(post)

