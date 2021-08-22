from .calculator_post import calculate_post_hashtags
from .calculator_user import calculate_user_follow
from .calculator_prev import calculate_prev_maintain
from .calculator_prev import calculate_prev_engagement
from server.core.modules.static.reward import InstagramReward
from ..time import get_now_time


def get_reward_point(join):
    post_hashtag_point = get_post_hashtag_point(join) * InstagramReward.CONSTANT_POST
    user_follow_point = get_user_follow_point(join) * InstagramReward.CONSTANT_USER
    prev_maintain_point = get_prev_maintain_point(join) * InstagramReward.CONSTANT_PREV
    prev_engagement_point = get_prev_engagement_point(join) * InstagramReward.CONSTANT_PREV

    reward_point = post_hashtag_point + user_follow_point + prev_maintain_point + prev_engagement_point
    return reward_point


def get_post_hashtag_point(join):
    event_hashtags = join['event']['hashtag']
    post_hashtags = join['hashtags'].split(',')

    post_hashtag_point = calculate_post_hashtags(post_hashtags, event_hashtags)
    return post_hashtag_point


def get_user_follow_point(join):
    follow_count = join['join_user']['follow_count']

    user_follow_point = calculate_user_follow(follow_count, InstagramReward.FOLLOWER_NUMBER)
    return user_follow_point


def get_prev_maintain_point(join):
    upload_date = join['upload_date']

    if join['delete_date'] is None:
        delete_date = get_now_time()
    else:
        delete_date = join['delete_date']

    prev_maintain_point = calculate_prev_maintain(upload_date, delete_date, InstagramReward.MAINTAIN_DAY)
    return prev_maintain_point


def get_prev_engagement_point(join):
    like_count = join['like_count']
    comment_count = join['comment_count']

    prev_engagement_point = calculate_prev_engagement(like_count, comment_count, InstagramReward.ER_NUMBER)
    return prev_engagement_point
