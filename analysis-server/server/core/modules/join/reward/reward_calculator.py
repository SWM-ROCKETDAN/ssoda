from server.core.modules.static.common import Type
from server.core.modules.static.common import Status
from .reward_calculator_instagram import get_reward_point as get_reward_point_instagram
from .reward_calculator_facebook import get_reward_point as get_reward_point_facebook
import pprint

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

    def save_reward_point(self):
        # 참여한 JOIN
        this_join = self.this_join
        this_join_type = this_join['type']
        if this_join_type in get_reward_point_handlers:
            this_reward_point = get_reward_point_handlers[this_join_type](this_join)
            self.this_reward_point = this_reward_point

        # 다른 JOIN
        other_joins = self.other_joins
        for other_join in other_joins:
            other_join_type = other_join['type']
            if other_join_type in get_reward_point_handlers:
                other_reward_point = get_reward_point_handlers[this_join_type](other_join)
                self.other_reward_points.append(other_reward_point)

    def get_this_reward_point_rank(self):
        this_reward_point = self.this_reward_point
        other_reward_points = self.other_reward_points
        other_reward_points.append(this_reward_point)
        other_reward_points.sort()

        this_rank_index = other_reward_points.index(this_reward_point)
        this_rank = this_rank_index / len(other_reward_points) * 100

        return max(min(this_rank, 100), 0)

    def get_reward_ranks(self):
        this_join = self.this_join

        # 리워드 리스트 추출 (리워드 레벨, 리워드 카운트)
        rewards = []
        reward_total_count = 0
        for reward in this_join['event']['rewards']:
            reward_id = reward['id']
            reward_level = reward['level']
            reward_count = reward['count']
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
        # 리워드 점수 계산 후 저장
        self.save_reward_point()

        # 리워드 점수 랭킹과 리워드 랭킹 리스트 얻기
        this_reward_point_rank = self.get_this_reward_point_rank()
        reward_ranks = self.get_reward_ranks()
        # pprint.pprint(self.this_reward_point)
        # pprint.pprint(self.other_reward_points)
        # pprint.pprint(this_reward_point_rank)
        # pprint.pprint(reward_ranks)
        # 랭킹 계산 후 리워드 아이디 추출
        this_reward_id = None
        for reward_id, reward_level, reward_rank in reward_ranks:
            this_reward_point_rank -= reward_rank
            this_reward_id = reward_id
            if this_reward_point_rank < 0:
                break

        return this_reward_id
