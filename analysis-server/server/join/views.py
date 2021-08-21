from django.http import JsonResponse
from django.shortcuts import get_object_or_404, get_list_or_404
from rest_framework.views import APIView
from core.models import JoinPost
from core.models import JoinUser
from core.models import Event
from .serializers import JoinPostSerializer
from .serializers import JoinUserSerializer
from .serializers import JoinSerializer
from .serializers import EventSerializer
from core.modules.join.post.post_scraper import PostScraper
from core.modules.join.user.user_scraper import UserScraper
from core.exceptions import exceptions
from core.exceptions.exception_parser import parse_exception


# JoinPost PUT 요청
class JoinPostView(APIView):
    def put(self, request, pk):
        # Join Post 가져오기
        join_post = get_object_or_404(JoinPost, pk=pk)
        post_scraper = PostScraper(JoinPostSerializer(join_post).data)
        scraped_post = post_scraper.get_scraped_post()
        join_post_serializer = JoinPostSerializer(join_post, scraped_post, partial=True)
        if join_post_serializer.is_valid():
            join_post_serializer.save()
            raise exceptions.PostUpdateOk
        raise exceptions.PostUpdateFailed


# JoinUser PUT 요청
class JoinUserView(APIView):
    def put(self, request, pk):
        # Join User 가져오기
        join_user = get_object_or_404(JoinUser, pk=pk)
        user_scraper = UserScraper(JoinUserSerializer(join_user).data)
        scraped_user = user_scraper.get_scraped_user()
        join_user_serializer = JoinUserSerializer(join_user, scraped_user, partial=True)
        if join_user_serializer.is_valid():
            join_user_serializer.save()
            raise exceptions.UserUpdateOk
        raise exceptions.UserUpdateFailed

# # Reward GET 요청
# class JoinRewardView(APIView):
#     def get(self, request, pk):
#         # Join List 가져오기
#         try:
#             join_post_list = get_list_or_404(JoinPost)
#             join_list_serializer = JoinSerializer(data=join_post_list, many=True)
#             join_list_serializer.is_valid()
#             join_post = get_object_or_404(pk=pk)
#             join_serializer = JoinSerializer(join_post)
#             event_id = join_serializer.data.get('event')
#             event = get_object_or_404(Event, pk=event_id)
#             event_serializer = EventSerializer(event)
#             join_reward = JoinReward(join_list_serializer.data, join_serializer.data, event_serializer.data)
#             reward = join_reward.get_reward()
#         except Exception as e:
#             print(e)
#             return JsonResponse(custom_status.ServerError.JOIN_REWARD_ERROR)
#
#         # Join Post 의 reward_id 값 업데이트
#         join_post_serializer = JoinPostSerializer(join_post, {'reward': reward[0]}, partial=True)
#         if join_post_serializer.is_valid():
#             join_post_serializer.save()
#         # test
#         return JsonResponse({'reward_id': reward[0]})
