from ..reward_calculator import RewardCalculator
from ..reward_calculator import _get_valid_rewards

LEVEL_ONE = 500
LEVEL_TWO = 1000
LEVEL_THREE = 1500
LEVEL_FOUR = 2000
LEVEL_FIVE = 2500


def _get_reward_level(follow_count: int):
    _reward_level = 1

    if follow_count < LEVEL_ONE:
        _reward_level = 1
    elif follow_count < LEVEL_TWO:
        _reward_level = 2
    elif follow_count < LEVEL_THREE:
        _reward_level = 3
    elif follow_count < LEVEL_FOUR:
        _reward_level = 4
    else:
        _reward_level = 5

    return _reward_level


def _get_reward_follow_id(follow_count: int, rewards: list):
    _rewards = _get_valid_rewards(rewards)
    _reward_level = _get_reward_level(follow_count)

    _sorted_rewards = sorted(_rewards, key=lambda x: x['level'])
    _reward_id = _sorted_rewards[0]['id']
    for _sorted_reward in _sorted_rewards:
        _reward_id = _sorted_reward['id']
        if _reward_level == _sorted_reward['level']:
            break

    return _reward_id


class RewardFollowCalculator(RewardCalculator):
    def __init__(self, follow_count: int, rewards: list):
        self._follow_count = follow_count
        self._rewards = rewards

    def get_reward_id(self):
        return _get_reward_follow_id(self._follow_count, self._rewards)
