# 게시물 점수 계산 - 해시태그
def calculate_post(post_hashtag_list, event_hashtag_list) -> float:
    cnt = 0

    for hashtag in event_hashtag_list:
        if hashtag in post_hashtag_list:
            cnt += 1

    return cnt / len(event_hashtag_list) * 100
