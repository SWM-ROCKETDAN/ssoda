from rest_framework.views import APIView
from rest_framework.response import Response
from django.http import Http404
from rest_framework import status
from .models import JoinPost, JoinUser
from .models import Event
from .models import Reward
from .serializers import JoinPostSerializer, JoinUserSerializer
from .serializers import EventSerializer
from .serializers import RewardSerializer
from .serializers import JoinCollectionSerializer
from .modules.instagram.join.crawl import crawl


class JoinPostView(APIView):
    @staticmethod
    def get_object(pk):
        try:
            return JoinPost.objects.get(pk=pk)
        except JoinPost.DoesNotExist:
            raise status.HTTP_404_NOT_FOUND

    @staticmethod
    def get_all():
        try:
            return JoinPost.objects.all()
        except JoinPost.DoesNotExist:
            raise status.HTTP_404_NOT_FOUND

    # GET 요청 -> post 크롤링 -> join_post 업데이트
    def get(self, request, pk, formate=None):
        join_post = self.get_object(pk)
        join_post_serializer = JoinPostSerializer(join_post)
        join_post_url = join_post_serializer.data.get('url')
        join_post_crawl = crawl.crawl_post(join_post_url)
        serializer = JoinPostSerializer(join_post, join_post_crawl, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_206_PARTIAL_CONTENT)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    # 테스트 용 post 실제는 없음.
    def post(self, request, pk, formate=None):
        print(request.data)
        serializer = JoinPostSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class JoinUserView(APIView):
    @staticmethod
    def get_object(pk):
        try:
            return JoinUser.objects.get(pk=pk)
        except JoinUser.DoesNotExist:
            raise status.HTTP_404_NOT_FOUND

    @staticmethod
    def get_all():
        try:
            return JoinUser.objects.all()
        except JoinUser.DoesNotExist:
            raise status.HTTP_404_NOT_FOUND

    # GET 요청 -> user 크롤링 -> join_user 업데이트
    def get(self, request, pk, formate=None):
        join_user = self.get_object(pk)
        join_user_serializer = JoinUserSerializer(join_user)
        join_user_url = join_user_serializer.data.get('sns_id')
        join_user_crawl = crawl.crawl_user(join_user_url)
        serializer = JoinUserSerializer(join_user, join_user_crawl, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_206_PARTIAL_CONTENT)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    # 테스트 용 post 실제는 없음.
    def post(self, request, pk, formate=None):
        print(request.data)
        serializer = JoinUserSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
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
        return Response(join_collection_serializer.data, status=status.HTTP_400_BAD_REQUEST)


class TestView(APIView):
    def get(self, request, test, formate=None):
        test_code = test
        if test_code == 0:
            event = Event.objects.filter(pk=1)
            event_serializer = EventSerializer(data=event, many=True)
            event_serializer.is_valid()
            print(event_serializer.data)
            return Response(event_serializer.data, status=status.HTTP_400_BAD_REQUEST)
        if test_code == 1:
            join_collection = JoinPost.objects.filter(pk=1)
            join_collection_serializer = JoinCollectionSerializer(data=join_collection)
            print(join_collection_serializer)
            join_collection_serializer.is_valid()
            print(join_collection_serializer.data)
            return Response(join_collection_serializer.data, status=status.HTTP_400_BAD_REQUEST)
        if test_code == 2:
            join_collection = JoinPost.objects.all()
            join_collection_serializer = JoinCollectionSerializer(data=join_collection, many=True)
            join_collection_serializer.is_valid()
            return Response(join_collection_serializer.data, status=status.HTTP_400_BAD_REQUEST)
        elif test_code == 3:
            reward = Reward.objects.all()
            print(reward)
            reward_serializer = RewardSerializer(data=reward, many=True)
            reward_serializer.is_valid()
            return Response(reward_serializer.data, status=status.HTTP_400_BAD_REQUEST)
        elif test_code == 4:
            event = Event.objects.all()
            event_serializer = EventSerializer(data=event, many=True)
            event_serializer.is_valid()
            return Response(event_serializer.data, status=status.HTTP_200_OK)
