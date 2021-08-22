# 유저 팔로워 수 계산
def calculate_user_follow(follow_count, max_follower_number) -> float:
    return min(follow_count / max_follower_number * 100, 100)
