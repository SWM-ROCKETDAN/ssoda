import config


class RewardInstagram:
    def __init__(self, follower, hashtags):
        self.event_hashtags = []
        self.prev_maintain = 0
        self.prev_er = 0
        self.follower = follower
        self.hashtags = hashtags
        self.point = 0

    def cal_account(self):
        return self.follower / config.RewardConstant.INSTAGRAM_CONSTANT_FOLLOWER * 100

    def cal_post(self):
        cnt = 0

        for hashtag in self.event_hashtags:
            if hashtag in self.hashtags:
                cnt += 1

        return cnt / len(self.event_hashtags) * 100

    def cal_prev(self):
        return self.prev_maintain + self.prev_er

    def cal_point(self):
        account_point = self.cal_account() * config.RewardConstant.INSTAGRAM_CONSTANT_INFLUENCE
        post_point = self.cal_post() * config.RewardConstant.INSTAGRAM_CONSTANT_POST
        prev_point = self.cal_prev() * config.RewardConstant.INSTAGRAM_CONSTANT_MAINTAIN

        return account_point + post_point + prev_point
