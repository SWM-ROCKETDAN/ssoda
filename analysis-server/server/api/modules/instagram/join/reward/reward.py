import server.secret.config as config
from .reward_user import reward_user
from .reward_post import reward_post
from .reward_prev import reward_maintain
from .reward_prev import reward_er


class JoinReward:
    def __init__(self, join_list, event, pk):
        self.join_list = join_list
        self.event = event
        self.pk = pk

    # 리워드 점수 계산
    def get_reward_point(self, join) -> int:
        # 유저 점수 - 팔로워 수
        user_point = reward_user(join['join_user']['follow_count']) * config.InstagramReward.CONSTANT_USER

        # 게시물 점수 - 해시태그 일치 비율
        hashtag_list = []
        for hashtag_hashtag in self.event['hashtag']['hashtag_hashtags']:
            hashtag_list.append(hashtag_hashtag['hashtags'])
        post_point = reward_post(join['hashtags'], hashtag_list)

        # 데이터 점수 01 - 게시물 유지 기간
        maintain_point = reward_maintain(join['upload_date'],
                                         join['delete_date']) * config.InstagramReward.CONSTANT_PREV
        # 데이터 점수 02 - 게시물 좋아요 및 댓글 수
        er_point = reward_er(join['like_count'], join['comment_count']) * config.InstagramReward.CONSTANT_PREV

        # 리워드 점수 합산
        reward_point = post_point + user_point + maintain_point + er_point

        return reward_point

    # 전체 리워드 점수 딕셔너리
    def get_reward_point_dict(self) -> dict:
        reward_point_dict = {}
        for join in self.join_list:
            reward_point_dict[join['id']] = self.get_reward_point(join)
        return reward_point_dict

    # 단계별 보상 비율 리스트
    def get_reward_rate_list(self):
        reward_rate_list = []
        reward_count_sum = 0
        for join in self.join_list:
            if join['id'] == self.pk:
                for reward in self.event['rewards']:
                    reward_rate_list.append(reward['count'])
                    reward_count_sum += reward['count']

        for key, val in enumerate(reward_rate_list):
            reward_rate_list[key] = val / reward_count_sum

        return reward_rate_list

    # 리워드 점수 비율
    def get_reward_point_rate(self):
        reward_point_dict = self.get_reward_point_dict()
        reward_point_list = []

        for key, val in reward_point_dict.items():
            reward_point_list.append(val)

        reward_point_list.sort()
        reward_point_rate = 0
        cnt = 0
        for key, val in reward_point_dict.items():
            cnt += 1
            if key == self.pk:
                reward_point_rate = 1 - (reward_point_list.index(val) + 1) / len(reward_point_dict)
        print(reward_point_dict)
        return reward_point_rate

    # 리워드 레벨
    def get_reward_level(self) -> int:
        reward_rate_list = self.get_reward_rate_list()
        reward_point_rate = self.get_reward_point_rate()

        # 리워드 점수 비율을 리워드 비율 리스트와 비교
        reward_level = 1
        for key, val in enumerate(reward_rate_list):
            if val > reward_point_rate:
                reward_level = key + 1

        print(reward_rate_list)
        print(reward_point_rate)
        print(reward_level)

        return reward_level



