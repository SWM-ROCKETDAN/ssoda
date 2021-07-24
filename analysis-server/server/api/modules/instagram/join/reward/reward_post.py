# 게시물 점수 계산 - 해시태그
def reward_post(post_hashtags, event_hashtags) -> float:
    cnt = 0

    for hashtag in event_hashtags:
        if hashtag in post_hashtags:
            cnt += 1

    return cnt / len(event_hashtags) * 100
