import server.secret.config as config
import pprint

# 사용자 점수 계산 - 팔로워 수
def get_user_point(join: dict) -> float:
    follow_count = join['join_user']['follow_count']
    return follow_count / config.InstagramReward.FOLLOWER_NUMBER * 100
