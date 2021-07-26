import server.secret.config as config
from .reward_user import reward_user
from .reward_post import reward_post
from .reward_prev import reward_maintain
from .reward_prev import reward_er


class Reward:
    def __init__(self, join_post_list, join_user_list, join_post, join_user, event):
        self.join_post_list = join_post_list
        self.join_user_list = join_user_list
        self.join_post = join_post
        self.join_user = join_user
        self.event = event

    @staticmethod
    def get_reward_point(join_post, join_user, hashtags) -> int:
        user_point = reward_user(join_user['follow_count']) * config.InstagramReward.CONSTANT_USER
        post_point = reward_post(join_post['hashtags'], hashtags['hashtags']) * config.InstagramReward.CONSTANT_POST
        maintain_point = reward_maintain(join_post['upload_date'],
                                         join_post['delete_date']) * config.InstagramReward.CONSTANT_PREV
        er_point = reward_er(join_post['like_count'], join_post['comment_count']) * config.InstagramReward.CONSTANT_PREV

        reward_point = post_point + user_point + maintain_point + er_point

        return reward_point

    def get_this_reward_point(self) -> int:
        this_reward_point = self.get_reward_point(self.join_post, self.join_post, self.event)

        return this_reward_point

    def get_prev_reward_point_list(self) -> list:
        prev_reward_point_list = []
        for i in range(0, len(self.join_user_list)):
            prev_reward_point = self.get_reward_point(self.join_post_list[i], self.join_user_list[i], self.event)
            prev_reward_point_list.append(prev_reward_point)

        return prev_reward_point_list

    def get_this_reward_point_rate(self) -> float:
        this_reward_point = self.get_this_reward_point()
        prev_reward_point_list = self.get_prev_reward_point_list()
        prev_reward_point_list.sort()

        index = 0
        for idx, val in enumerate(prev_reward_point_list):
            if this_reward_point <= val:
                index = idx
                break

        return 1 - index / len(prev_reward_point_list)

    def get_this_reward_level_rate_list(self) -> list:
        count_sum = 0
        reward_level_rate_list = []
        for reward in self.event:
            count_sum += reward['count']
            reward_level_rate_list.append(reward['count'])

        for idx, val in enumerate(reward_level_rate_list):
            if idx == 0:
                reward_level_rate_list[idx] = 1 - val / count_sum
            else:
                reward_level_rate_list[idx] = reward_level_rate_list[idx - 1] - (val / count_sum)

        return reward_level_rate_list

    def get_reward_level(self) -> int:
        this_reward_point_rate = self.get_this_reward_point_rate()
        this_reward_level_rate_list = self.get_this_reward_level_rate_list()

        for i in range(10):
            pass

        return 0
