# 게시물 점수 계산 - 해시태그
def calculate_post_hashtags(post_hashtags, event_hashtags) -> float:
    hashtag_count = 0
    for event_hashtag in event_hashtags:
        if event_hashtag in post_hashtags:
            hashtag_count += 1
    return min(hashtag_count / len(event_hashtags) * 100, 100)
