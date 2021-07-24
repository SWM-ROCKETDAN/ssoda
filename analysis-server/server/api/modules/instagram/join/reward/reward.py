import server.secret.config as config
from .reward_user import reward_user
from .reward_post import reward_post
from .reward_prev import reward_maintain
from .reward_prev import reward_er


class Reward:
    def __init__(self, join_post, join_user, event):
        self.join_post = join_post
        self.join_user = join_user
        self.event = event

    # 모든 점수를 합산
    def reward_point(self) -> int:
        user_point = reward_user(self.join_user['follow_count']) * config.InstagramReward.CONSTANT_USER
        post_point = reward_post(self.join_post['hashtags'], self.event['hashtags']) * config.InstagramReward.CONSTANT_POST
        maintain_point = reward_maintain(self.join_post['upload_date'], self.join_post['delete_date']) * config.InstagramReward.CONSTANT_PREV
        er_point = reward_er(self.join_post['like_count'], self.join_post['comment_count']) * config.InstagramReward.CONSTANT_PREV

        reward_point = post_point + user_point + maintain_point + er_point

        return reward_point

    def reward_level(self) -> int:
        pass

