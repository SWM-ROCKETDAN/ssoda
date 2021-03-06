from core.modules.static.common import Type
from .reward_calculator_instagram import get_reward_point as get_reward_point_instagram
from .reward_calculator_facebook import get_reward_point as get_reward_point_facebook
from core.exceptions import exceptions

get_reward_point_handlers = {
    Type.INSTAGRAM: get_reward_point_instagram,
    Type.FACEBOOK: get_reward_point_facebook,
}


class RewardCalculator:
    def __init__(self, this_join, other_joins):
        self.this_join = this_join
        self.other_joins = other_joins
        self.this_reward_point = 0
        self.other_reward_points = []

    def get_this_reward_point(self):
        this_join_type = self.this_join['type']
        if self.this_join['type'] in get_reward_point_handlers:
            this_reward_point = get_reward_point_handlers[this_join_type](self.this_join)
            return this_reward_point
        return 0

    def get_other_reward_points(self):
        other_reward_points = []
        for other_join in self.other_joins:
            other_join_type = other_join['type']
            if other_join_type in get_reward_point_handlers:
                other_reward_point = get_reward_point_handlers[other_join_type](other_join)
                other_reward_points.append(other_reward_point)
        return other_reward_points

    def get_this_reward_point_rank(self):
        this_reward_point = self.get_this_reward_point()
        other_reward_points = self.get_other_reward_points()
        other_reward_points.append(this_reward_point)
        other_reward_points.sort()
        this_reward_point_rank_index = other_reward_points.index(this_reward_point)
        this_reward_point_rank = this_reward_point_rank_index / len(other_reward_points) * 100
        return max(min(this_reward_point_rank, 100), 0)

    def get_reward_ranks(self):
        # 리워드 리스트 추출 (리워드 레벨, 리워드 카운트)
        rewards = []
        reward_total_count = 0
        for reward in self.this_join['event']['rewards']:
            reward_id = reward['id']
            reward_level = reward['level']
            reward_count = reward['count'] - reward['used_count']
            reward_item = (reward_id, reward_level, reward_count)
            rewards.append(reward_item)
            reward_total_count += reward_count

        # 리워드 레벨로 오름차순 정렬
        rewards.sort(key=lambda x: x[1])
        reward_ranks = []
        for reward_id, reward_level, reward_count in rewards:
            reward_rank = reward_count / reward_total_count * 100
            reward_item = (reward_id, reward_level, reward_rank)
            reward_ranks.append(reward_item)
        return reward_ranks

    def get_this_reward_id(self):
        this_reward_point_rank = self.get_this_reward_point_rank()
        reward_ranks = self.get_reward_ranks()
        this_reward_id = None
        for reward_id, reward_level, reward_rank in reward_ranks:
            this_reward_point_rank -= reward_rank
            this_reward_id = reward_id
            if this_reward_point_rank < 0:
                break
        return this_reward_id
