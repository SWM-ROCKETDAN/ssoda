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
from core._modules.crawler.crawl_post import crawl_post
from core._modules.crawler.crawl_user import crawl_user


# JoinPost PUT 요청
class JoinPostView(APIView):
    def put(self, request, pk):
        # Join Post 가져오기
        try:
            join_post = get_object_or_404(JoinPost, pk=pk)
            join_post_serializer = JoinPostSerializer(join_post)
            # 크롤링
            join_crawl_post = crawl_post(join_post_serializer.data['url'])
            # Join Post 업데이트
            join_post_serializer = JoinPostSerializer(join_post, join_crawl_post, partial=True)
            if join_post_serializer.is_valid():
                join_post_serializer.save()
                return JsonResponse({'test': 'JoinPostOk'})
            return JsonResponse({'test': 'JoinPostError1'})
        except Exception as e:
            print(e)
            return JsonResponse({'test': 'JoinPostError2'})


# JoinUser PUT 요청
class JoinUserView(APIView):
    def put(self, request, pk):
        # Join User 가져오기
        try:
            join_user = get_object_or_404(JoinUser, pk=pk)
            join_user_serializer = JoinUserSerializer(join_user)
            sns_id = join_user_serializer.data['sns_id']
            join_crawl_user = crawl_user(sns_id)
            # Join User 업데이트
            join_user_serializer = JoinUserSerializer(join_user, join_crawl_user, partial=True)
            if join_user_serializer.is_valid():
                join_user_serializer.save()
                return JsonResponse({'test': 'JoinPostOk'})
            return JsonResponse({'test': 'JoinPostError'})
        except Exception as e:
            print(e)
            return JsonResponse({'test': 'JoinUserError1'})


# Reward GET 요청
class JoinRewardView(APIView):
    def get(self, request, pk):
        # Join List 가져오기
        try:
            join_post_list = get_list_or_404(JoinPost)
            join_list_serializer = JoinSerializer(data=join_post_list, many=True)
            join_list_serializer.is_valid()
            join_post = get_object_or_404(pk=pk)
            join_serializer = JoinSerializer(join_post)
            event_id = join_serializer.data.get('event')
            event = get_object_or_404(Event, pk=event_id)
            event_serializer = EventSerializer(event)
            join_reward = JoinReward(join_list_serializer.data, join_serializer.data, event_serializer.data)
            reward = join_reward.get_reward()
        except Exception as e:
            print(e)
            return JsonResponse(custom_status.ServerError.JOIN_REWARD_ERROR)

        # Join Post 의 reward_id 값 업데이트
        join_post_serializer = JoinPostSerializer(join_post, {'reward': reward[0]}, partial=True)
        if join_post_serializer.is_valid():
            join_post_serializer.save()
        # test
        return JsonResponse({'reward_id': reward[0]})
