from .calculator_post import calculate_post_hashtags
from .calculator_user import calculate_user_follow
from .calculator_prev import calculate_prev_maintain
from .calculator_prev import calculate_prev_engagement
from core.modules.static.reward import InstagramReward
from core.modules.assist.time import _get_now_date


def get_reward_point(join):
    user_follow_point = get_user_follow_point(join)
    reward_point = user_follow_point
    return reward_point


def get_user_follow_point(join):
    follow_count = join['follow_count']
    user_follow_point = calculate_user_follow(follow_count)
    return user_follow_point


def get_post_hashtag_point(join):
    pass


def get_prev_maintain_point(join):
    pass


def get_prev_engagement_point(join):
    pass
