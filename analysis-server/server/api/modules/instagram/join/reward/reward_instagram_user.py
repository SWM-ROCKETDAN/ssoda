import server.secret.config as config


# 사용자 점수 계산 - 팔로워 수
def calculate_user(self) -> float:
    return self.follower / config.Reward.INSTAGRAM_REWARD_FOLLOWER * 100
