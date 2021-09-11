from server.core.modules.static.common import Status
from server.core.modules.static.common import Type
from core.modules.assist.time import parse_from_str_time_to_date_time


# url 로 sns 타입 체크
def get_post_type_from_url(post_url) -> bool:
    if 'instagram' in post_url:
        return Type.INSTAGRAM
    elif 'facebook' in post_url:
        return Type.FACEBOOK
    else:
        return Type.INSTAGRAM


# 게시물의 이벤트가 정상인지 체크
def check_post_event_is_ok(post_event_delete_flag) -> bool:
    if post_event_delete_flag is True:
        return False
    return True


# 게시물의 이벤트 리워드가 정상인지 체크
def check_post_event_reward_is_ok(post_event_rewards: list) -> bool:
    if not post_event_rewards:
        return False

    reward_count = 0
    for post_event_reward in post_event_rewards:
        if 'deleted' in post_event_reward and post_event_reward['deleted']:
            reward_count += 1

    if reward_count:
        return False
    return True


# 게시물의 리워드가 정상인지 체크
def check_post_reward_is_ok(post_reward_delete_flag) -> bool:
    if post_reward_delete_flag is True:
        return False
    return True


# 게시물이 이미 리워드를 받았는지 체크
def check_post_is_already_rewarded(post_reward_date) -> bool:
    if post_reward_date is None:
        return False
    return True


# 게시물 해시태그와 이벤트 해시태그가 일치하는지 체크
def check_match_post_hashtags_with_event_hashtags(post_hashtags, event_hashtags) -> bool:
    match_count = 0
    for i in range(len(post_hashtags)):
        post_hashtags[i] = post_hashtags[i].upper()

    for i in range(len(event_hashtags)):
        event_hashtags[i] = event_hashtags[i].upper()

    for event_hashtag in event_hashtags:
        if event_hashtag in post_hashtags:
            match_count += 1

    if match_count == 0:
        return False
    return True


# 게시물 상태가 PUBLIC 인지 체크
def check_post_status_is_public(post_status) -> bool:
    if post_status != Status.PUBLIC:
        return False
    return True


# 게시물 상태가 PRIVATE 인지 체크
def check_post_status_is_private(post_status) -> bool:
    if post_status != Status.PRIVATE:
        return False
    return True


# 게시물 상태가 DELETED 인지 체크
def check_post_status_is_deleted(post_status) -> bool:
    if post_status != Status.DELETED:
        return False
    return True


# 게시물이 이벤트 시작 후에 올라왔는지 체크
def check_post_upload_date_is_ok_from_event_start_date(post_upload_date, event_start_date) -> bool:
    if post_upload_date is None or event_start_date is None:
        return False
    post_upload_date = parse_from_str_time_to_date_time(post_upload_date)
    event_start_date = parse_from_str_time_to_date_time(event_start_date)
    if post_upload_date.date() < event_start_date.date():
        return False
    return True
