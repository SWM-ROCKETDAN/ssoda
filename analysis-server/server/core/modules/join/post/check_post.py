from server.core.modules.static.common import Status


# 게시물의 이벤트가 정상인지 체크
def check_post_event_is_ok(post_event_delete_flag):
    if post_event_delete_flag is True:
        return False
    return True


# 게시물의 리워드가 정상인지 체크
def check_post_reward_is_ok(post_reward_delete_flag):
    if post_reward_delete_flag is True:
        return False
    return True


# 게시물이 이미 리워드를 받았는지 체크
def check_post_is_already_rewarded(post_reward_date):
    if post_reward_date is None:
        return False
    return True


# 게시물 해시태그와 이벤트 해시태그가 일치하는지 체크
def check_match_post_hashtags_with_event_hashtags(post_hashtags, event_hashtags):
    match_count = 0
    for event_hashtag in event_hashtags:
        if event_hashtag in post_hashtags:
            match_count += 1

    if match_count == 0:
        return False
    return True


# 게시물 상태가 PUBLIC 인지 체크
def check_post_status_is_public(post_status):
    if post_status != Status.PUBLIC:
        return False
    return True


# 게시물 상태가 PRIVATE 인지 체크
def check_post_status_is_private(post_status):
    if post_status != Status.PRIVATE:
        return False
    return True


# 게시물 상태가 DELETED 인지 체크
def check_post_status_is_deleted(post_status):
    if post_status != Status.DELETED:
        return False
    return True


def check_post_upload_date_is_ok_from_event_start_date(post_upload_date, event_start_date):
    if post_upload_date is None or event_start_date is None:
        return False
    if post_upload_date < event_start_date:
        return False
    return True
