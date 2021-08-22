from server.core.modules.static.common import Type
from server.core.modules.static.common import Status
from .reward_calculator_instagram import get_reward_point as get_reward_point_instagram
from .reward_calculator_facebook import get_reward_point as get_reward_point_facebook

get_reward_point_handlers = {
    Type.INSTAGRAM: get_reward_point_instagram,
    Type.FACEBOOK: get_reward_point_facebook,
}


class RewardCalculator:
    def __init__(self, this_join, prev_joins, other_joins, this_event):
        self.this_join = this_join
        self.prev_joins = prev_joins
        self.other_joins = other_joins
        self.this_event = this_event
        self.this_reward_point = 0
        self.other_reward_points = []

    def save_reward_point(self):
        this_join = self.this_join
        this_join_type = this_join['type']
        if this_join_type in get_reward_point_handlers:
            this_reward_point = get_reward_point_handlers[this_join_type](this_join)
            self.this_reward_point = this_reward_point

        other_joins = self.other_joins
        for other_join in other_joins:
            other_join_type = other_join['type']
            if other_join_type in get_reward_point_handlers:
                other_reward_point = get_reward_point_handlers[this_join_type](other_join)
                self.other_reward_point.append(other_reward_point)

    def get_rank_this_reward_point(self):
        this_reward_point = self.this_reward_point
        other_reward_points = self.other_reward_points
        other_reward_points.append(this_reward_point)
        other_reward_points.sort()

        rank_index = other_reward_points.index(this_reward_point)
        rank = rank_index / len(other_reward_points) * 100

        return max(min(rank, 100), 0)

    def get_rank_event_rewards(self):
        this_event = self.this_event

        pass
