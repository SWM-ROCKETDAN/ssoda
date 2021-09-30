def _get_valid_rewards(rewards: list) -> list:
    _valid_rewards = []
    for reward in rewards:
        if not reward['deleted'] and reward['used_count'] < reward['count']:
            _valid_rewards.append(reward)

    return _valid_rewards


class RewardCalculator:
    def get_reward_id(self):
        pass
