import pprint
from .reward_assistant import get_reward


class RewardEstimator:
    join_list = []
    join = {}
    event = {}

    def __init__(self, join_list, join, event):
        self.join_list = join_list
        self.join = join
        self.event = event


class JoinReward:
    def __init__(self, join_list, join, event):
        self.join_list = join_list
        self.join = join
        self.event = event

    def get_reward(self):
        return get_reward(self.join_list, self.join, self.event)
