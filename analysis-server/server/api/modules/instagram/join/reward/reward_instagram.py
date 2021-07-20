import server.secret.config as config
import server.api.modules.instagram.join.reward.reward_instagram_user as reward_instagram_user
import server.api.modules.instagram.join.reward.reward_instagram_post as reward_instagram_post
import server.api.modules.instagram.join.reward.reward_instagram_prev as reward_instagram_prev


# 모든 점수를 합산
def cal_reward() -> int:
    post_point = reward_instagram_post.calculate_post() * config.Reward.INSTAGRAM_REWARD_POST
    user_point = reward_instagram_user.calculate_user() * config.Reward.INSTAGRAM_REWARD_USER
    prev_point = reward_instagram_prev.calculate_prev() * config.Reward.INSTAGRAM_REWARD_PREV

    reward_point = post_point + user_point + prev_point

    return reward_point
