from rest_framework.views import APIView
from rest_framework.response import Response
from django.http import Http404
from rest_framework import status
from .models import JoinPost, JoinUser, Event, Reward
from .serializers import JoinPostSerializer, JoinUserSerializer, JoinCollectionSerializer
from .serializers import EventSerializer
from .serializers import RewardSerializer
from .modules.instagram.join.crawl import crawl
from .modules.instagram.join.reward.reward import JoinReward
from server.secret.test_url import G_SCHOOL_INSTAGRAM
from server.api.modules.assist.cal_time import get_now_time


class JoinPostView(APIView):
    @staticmethod
    def get_object(pk):
        try:
            return JoinPost.objects.get(pk=pk)
        except JoinPost.DoesNotExist:
            raise status.HTTP_404_NOT_FOUND

    # put 요청 -> post 크롤링 -> join_post 업데이트
    def put(self, request, pk, formate=None):
        join_post = self.get_object(pk)
        join_post_serializer = JoinPostSerializer(join_post)
        join_post_url = join_post_serializer.data.get('url')
        join_post_crawl = crawl.crawl_post(join_post_url)
        serializer = JoinPostSerializer(join_post, join_post_crawl, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_206_PARTIAL_CONTENT)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class JoinUserView(APIView):
    @staticmethod
    def get_object(pk):
        try:
            return JoinUser.objects.get(pk=pk)
        except JoinUser.DoesNotExist:
            raise status.HTTP_404_NOT_FOUND

    # GET 요청 -> user 크롤링 -> join_user 업데이트
    def put(self, request, pk, formate=None):
        join_user = self.get_object(pk)
        join_user_serializer = JoinUserSerializer(join_user)
        join_user_url = join_user_serializer.data.get('sns_id')
        join_user_crawl = crawl.crawl_user(join_user_url)
        serializer = JoinUserSerializer(join_user, join_user_crawl, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_206_PARTIAL_CONTENT)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class JoinRewardView(APIView):
    @staticmethod
    def get_object(pk):
        try:
            return Reward.objects.filter(pk=pk)
        except Reward.DoesNotExist:
            raise Http404

    def get(self, request, pk, formate=None):
        join_collection = JoinPost.objects.all()
        join_collection_serializer = JoinCollectionSerializer(data=join_collection, many=True)
        join_collection_serializer.is_valid()
        join_reward = JoinReward(join_collection_serializer.data, pk)
        reward_level = join_reward.get_reward_level()
        return Response({'reward_level': reward_level}, status=status.HTTP_400_BAD_REQUEST)
