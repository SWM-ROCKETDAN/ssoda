from join.serializers import JoinPostSerializer
from join.serializers import JoinUserSerializer
from join.serializers import JoinPostScrapSerializer
from join.serializers import JoinUserScrapSerializer
from join.serializers import JoinPostUpdateSerializer
from join.serializers import JoinUserUpdateSerializer
from join.serializers import JoinUserFollowSerializer
from join.serializers import JoinRewardFollowCalculatorSerializer
from join.serializers import JoinRewardRandomCalculatorSerializer
import pytest


@pytest.mark.urls(urls="config.urls")
@pytest.mark.django_db(transaction=True)
class TestJoinSerializers:
    def test_join_post_serializer(self, join_post_naver_blog):
        join_post_serializer = JoinPostSerializer(join_post_naver_blog)

        assert join_post_serializer.data is not None

    def test_join_user_serializer(self, join_user_naver_blog):
        join_user_serializer = JoinUserSerializer(join_user_naver_blog)

        assert join_user_serializer.data is not None

    def test_join_post_scrap_serializer(self, join_post_naver_blog):
        join_post_scrap_serializer = JoinPostScrapSerializer(join_post_naver_blog)

        assert join_post_scrap_serializer.data is not None
        assert type(join_post_scrap_serializer.data['event_hashtags']) is list
        assert type(join_post_scrap_serializer.data['hashtags']) is list

    def test_join_user_scrap_serializer(self, join_user_naver_blog):
        join_user_scrap_serializer = JoinUserScrapSerializer(join_user_naver_blog)

        assert join_user_scrap_serializer.data is not None

    def test_join_post_update_serializer(self, join_post_naver_blog):
        join_post_update_serializer = JoinPostUpdateSerializer(join_post_naver_blog)

        assert join_post_update_serializer.data is not None

    def test_join_user_update_serializer(self, join_user_naver_blog):
        join_user_update_serializer = JoinUserUpdateSerializer(join_user_naver_blog)

        assert join_user_update_serializer.data is not None

    def test_join_user_follow_serializer(self, join_user_naver_blog):
        join_user_follow_serializer = JoinUserFollowSerializer(join_user_naver_blog)

        assert join_user_follow_serializer.data is not None
        assert "follow_count" in join_user_follow_serializer.data

    def test_join_reward_follow_calculator_serializer(self, join_post_naver_blog):
        join_reward_follow_calculator_serializer = JoinRewardFollowCalculatorSerializer(join_post_naver_blog)

        assert join_reward_follow_calculator_serializer.data is not None
        assert "follow_count" in join_reward_follow_calculator_serializer.data

    def test_join_reward_random_calculator_serializer(self, join_post_naver_blog):
        join_reward_random_calculator_serializer = JoinRewardRandomCalculatorSerializer(join_post_naver_blog)

        assert join_reward_random_calculator_serializer.data is not None
        assert "event" in join_reward_random_calculator_serializer.data
