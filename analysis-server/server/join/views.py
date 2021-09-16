from django.shortcuts import get_object_or_404
from django.shortcuts import get_list_or_404
from rest_framework.views import APIView
from core.models import JoinPost
from core.models import JoinUser
from .serializers import JoinPostSerializer
from .serializers import JoinUserSerializer
from .serializers import JoinPostScrapSerializer
from .serializers import JoinUserScrapSerializer
from .serializers import JoinRewardThisPostSerializer
from .serializers import JoinRewardOtherPostSerializer
from core.modules.join.post.post_scraper import PostScraper
from core.modules.join.user.user_scraper import UserScraper
from core.modules.join.reward.reward_calculator import RewardCalculator
from core.exceptions import exceptions
from core.modules.assist.time import parse_from_str_time_to_date_time
from join.tasks import add_queue_after_check_post
from join.tasks import task_scrap_post
from join.tasks import task_test
from join.tasks import add_queue_after_check_user
from datetime import datetime
from datetime import timedelta


# JoinPost PUT 요청
class JoinPostsView(APIView):
    def put(self, request, pk):
        # Join Post 가져오기
        join_post = get_object_or_404(JoinPost, pk=pk)
        join_post_update_serializer = JoinPostScrapSerializer(join_post)
        post_scraper = PostScraper(join_post_update_serializer.data)
        scraped_post = post_scraper.get_scraped_post()
        join_post_serializer = JoinPostSerializer(join_post, scraped_post, partial=True)
        if join_post_serializer.is_valid():
            join_post_serializer.save()
            create_date = parse_from_str_time_to_date_time(join_post_serializer.data['create_date'])
            task_scrap_post.apply_async((pk, 2, 1), countdown=120)
            raise exceptions.PostUpdateOk()
        raise exceptions.PostUpdateFailed()


# JoinUser PUT 요청
class JoinUsersView(APIView):
    def put(self, request, pk):
        # Join User 가져오기
        join_user = get_object_or_404(JoinUser, pk=pk)
        join_user_update_serializer = JoinUserScrapSerializer(join_user)
        user_scraper = UserScraper(join_user_update_serializer.data)
        scraped_user = user_scraper.get_scraped_user()
        join_user_serializer = JoinUserSerializer(join_user, scraped_user, partial=True)
        if join_user_serializer.is_valid():
            join_user_serializer.save()
            raise exceptions.UserUpdateOk()
        raise exceptions.UserUpdateFailed()


# Reward GET 요청
class JoinRewardsView(APIView):
    def get(self, request, pk):
        join_post = get_object_or_404(JoinPost, pk=pk)
        join_reward_this_post_serializer = JoinRewardThisPostSerializer(join_post)
        join_posts = get_list_or_404(JoinPost)
        join_reward_other_post_serializer = JoinRewardOtherPostSerializer(data=join_posts, many=True)
        join_reward_other_post_serializer.is_valid()
        this_join = join_reward_this_post_serializer.data
        other_joins = join_reward_other_post_serializer.data
        reward_calculator = RewardCalculator(this_join, other_joins)
        this_reward_id = reward_calculator.get_this_reward_id()
        join_post_serializer = JoinPostSerializer(join_post, {'reward': this_reward_id}, partial=True)
        if join_post_serializer.is_valid():
            join_post_serializer.save()
        raise exceptions.RewardCalculateOK({'reward_id': this_reward_id})
