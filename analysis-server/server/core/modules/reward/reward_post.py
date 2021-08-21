# 게시물 점수 계산 - 해시태그
def get_post_point(join, event) -> float:
    post_hashtag_list = join['hashtags']
    event_hashtag_list = []

    for hashtag in event['hashtag']['hashtag_hashtags']:
        event_hashtag_list.append(hashtag['hashtags'])

    # 둘 중 하나라도 None 값이면 0 리턴
    if not post_hashtag_list or not event_hashtag_list:
        return 0

    cnt = 0
    for hashtag in event_hashtag_list:
        if hashtag in post_hashtag_list:
            cnt += 1

    return cnt / len(event_hashtag_list) * 100
