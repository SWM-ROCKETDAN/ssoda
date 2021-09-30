from ..reward_calculator import RewardCalculator
from ..reward_calculator import _get_valid_rewards
import random


def _get_rate_rewards(rewards: list) -> list:
    _rate_rewards = []
    _sum_count = sum(reward['count'] for reward in rewards)

    for reward in rewards:
        _rate = reward['count'] / _sum_count
        _rate_reward = (reward['id'], _rate)
        _rate_rewards.append(_rate_reward)

    return _rate_rewards


def _get_random_rate():
    return random.uniform(0, 1)


def _get_reward_random_id(rewards: list):
    _rewards = _get_valid_rewards(rewards)
    _rate_rewards = _get_rate_rewards(_rewards)
    _random_rate = _get_random_rate()

    _ids = [_id for _id, _rate in _rate_rewards]
    _rates = [_rate for _id, _rate in _rate_rewards]

    reward_id = random.choices(population=_ids, weights=_rates, k=1)

    return reward_id.pop()


class RewardRandomCalculator(RewardCalculator):
    """
    "event": {
                    "id": 21,
                    "rewards": [
                        {
                            "id": 28,
                            "count": 20,
                            "level": 1,
                            "used_count": 6,
                            "deleted": false
                        }
                    ],
                    "etype": "hashtag",
                    "finish_date": "2021-12-31T23:59:59",
                    "start_date": "2021-09-29T00:00:00",
                    "status": 1,
                    "title": "이벤트",
                    "deleted": false,
                    "store": 8
                }
            }
    """

    def __init__(self, rewards):
        self._rewards = rewards

    def get_reward_id(self):
        return _get_reward_random_id(self._rewards)
