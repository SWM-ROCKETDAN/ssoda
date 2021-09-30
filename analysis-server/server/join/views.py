from django.shortcuts import get_object_or_404
from django.shortcuts import get_list_or_404
from rest_framework.views import APIView
from core.models import JoinPost
from core.models import JoinUser
from .serializers import JoinPostSerializer
from .serializers import JoinUserSerializer
from .serializers import JoinPostScrapSerializer
from .serializers import JoinUserScrapSerializer
from .serializers import JoinRewardFollowCalculatorSerializer
from .serializers import JoinRewardRandomCalculatorSerializer
from core.modules.join.post.post_scraper import PostScraper
from core.modules.join.user.user_scraper import UserScraper
from core.modules.join.reward import RewardFollowCalculator
from core.modules.join.reward import RewardRandomCalculator
from core.exceptions import exceptions
from join.tasks import task_scrap_post


# JoinPost PUT 요청
class JoinPostsView(APIView):
    def put(self, request, pk):
        join_post = get_object_or_404(JoinPost, pk=pk)
        join_post_scrap_serializer = JoinPostScrapSerializer(join_post)
        post_scraper = PostScraper(join_post_scrap_serializer.data)
        scraped_post = post_scraper.get_scraped_post()
        join_post_serializer = JoinPostSerializer(join_post, scraped_post, partial=True)
        if join_post_serializer.is_valid():
            join_post_serializer.save()
            task_scrap_post.apply_async((pk,), countdown=3600 * 24)
            raise exceptions.PostUpdateOk()
        raise exceptions.PostUpdateFailed()


# JoinUser PUT 요청
class JoinUsersView(APIView):
    def put(self, request, pk):
        join_user = get_object_or_404(JoinUser, pk=pk)
        join_user_scrap_serializer = JoinUserScrapSerializer(join_user)
        user_scraper = UserScraper(join_user_scrap_serializer.data)
        scraped_user = user_scraper.get_scraped_user()
        join_user_serializer = JoinUserSerializer(join_user, scraped_user, partial=True)
        if join_user_serializer.is_valid():
            join_user_serializer.save()
            raise exceptions.UserUpdateOk()
        raise exceptions.UserUpdateFailed()


class JoinRewardFollowView(APIView):
    def get(self, request, pk):
        join_post = get_object_or_404(JoinPost, pk=pk)
        reward_follow_serializer = JoinRewardFollowCalculatorSerializer(join_post)
        follow_count = reward_follow_serializer.data['follow_count']
        rewards = reward_follow_serializer.data['event']['rewards']
        follow_calculator = RewardFollowCalculator(follow_count, rewards)
        reward_id = follow_calculator.get_reward_id()
        join_post_serializer = JoinPostSerializer(join_post, {'reward': reward_id}, partial=True)
        if join_post_serializer.is_valid():
            join_post_serializer.save()
        raise exceptions.RewardCalculateOK({'reward_id': reward_id})


class JoinRewardRandomView(APIView):
    def get(self, request, pk):
        join_post = get_object_or_404(JoinPost, pk=pk)
        reward_random_serializer = JoinRewardRandomCalculatorSerializer(join_post)
        random_calculator = RewardRandomCalculator(reward_random_serializer.data['event']['rewards'])
        reward_id = random_calculator.get_reward_id()
        join_post_serializer = JoinPostSerializer(join_post, {'reward': reward_id}, partial=True)
        if join_post_serializer.is_valid():
            join_post_serializer.save()
        raise exceptions.RewardCalculateOK({'reward_id': reward_id})
