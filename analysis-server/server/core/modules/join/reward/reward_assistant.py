from server.secret.config import InstagramReward
from .reward_user import get_user_point
from .reward_post import get_post_point
from .reward_prev import get_maintain_point
from .reward_prev import get_engagement_point


# 리워드 점수 계산
def get_reward_point(join, event) -> int:
    # 유저 점수 - 팔로워 수
    user_point = get_user_point(join) * InstagramReward.CONSTANT_USER

    # 게시물 점수 - 해시태그 일치 비율
    post_point = get_post_point(join, event) * InstagramReward.CONSTANT_POST

    # 데이터 점수 01 - 게시물 유지 기간
    maintain_point = get_maintain_point(join) * InstagramReward.CONSTANT_PREV
    # 데이터 점수 02 - 게시물 좋아요 및 댓글 수
    engagement_point = get_engagement_point(join) * InstagramReward.CONSTANT_PREV

    # 리워드 점수 합산
    reward_point = post_point + user_point + maintain_point + engagement_point

    return reward_point


# 전체 리워드 점수 딕셔너리
def get_reward_point_dict(join_list: list, event: dict) -> dict:
    reward_point_dict = {}
    for join in join_list:
        reward_point_dict[join['id']] = get_reward_point(join, event)
    return reward_point_dict


# 단계별 보상 비율 리스트
def get_reward_rate_list(event: dict):
    reward_rate_list = []
    reward_count_sum = 0

    for reward in event['rewards']:
        reward_rate_list.append(reward['count'])
        reward_count_sum += reward['count']

    for key, val in enumerate(reward_rate_list):
        reward_rate_list[key] = val / reward_count_sum

    return reward_rate_list


# 리워드 점수 비율
def get_reward_point_rate(join_list: list, join: dict, event: dict) -> list:
    reward_point_dict = get_reward_point_dict(join_list, event)
    reward_point_list = []

    for key, val in reward_point_dict.items():
        reward_point_list.append(val)

    reward_point_list.sort()
    reward_point_rate = 0

    for key, val in reward_point_dict.items():
        if key == join['id']:
            reward_point_rate = (reward_point_list.index(val) + 1) / len(reward_point_dict)

    return reward_point_rate


# 리워드 레벨
def get_reward(join_list, join, event) -> tuple:
    reward_rate_list = get_reward_rate_list(event)
    reward_point_rate = get_reward_point_rate(join_list, join, event)

    # 리워드 점수 비율을 리워드 비율 리스트와 비교
    reward_level = None
    for key, val in enumerate(reward_rate_list):
        if val > reward_point_rate:
            reward_level = key + 1
            break
        else:
            reward_point_rate -= val

    reward_id = None
    for key, val in enumerate(event['rewards']):
        if key == reward_level:
            reward_id = val['id']
            break

    return reward_id, reward_level
