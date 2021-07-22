import server.secret.config as config


# 사용자 점수 계산 - 팔로워 수
def reward_user(follower_count) -> float:
    return follower_count / config.Reward.INSTAGRAM_REWARD_FOLLOWER * 100
