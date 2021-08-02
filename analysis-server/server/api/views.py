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
        join_reward = JoinReward(join_collection_serializer.data, pk)
        join_reward.get_reward_rate()
        # join_reward.test()
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

    def post(self, request, test):
        # G 스쿨 이벤트 8개 게시물
        if test == 0:
            for url in G_SCHOOL_INSTAGRAM:
                data = crawl.crawl_post(url)
                data['url'] = url
                data['create_date'] = get_now_time()
                data['event'] = 1
                join_post_serializer = JoinPostSerializer(data=data)
                if join_post_serializer.is_valid():
                    join_post_serializer.save()
                data = crawl.crawl_user(data['sns_id'])
                join_user_serializer = JoinUserSerializer(data=data)
                if join_user_serializer.is_valid():
                    join_user_serializer.save()
            return Response(join_post_serializer.data, status=status.HTTP_200_OK)
        if test == 1:
            join_post = JoinPost.objects.all()
            join_post_serializer = JoinPostSerializer(data=join_post, many=True)
            join_post_serializer.is_valid()
            sns_id_list = []
            for item in join_post_serializer.data:
                try:
                    join_user = JoinUser.objects.get(sns_id=item['sns_id'])
                except JoinUser.DoesNotExist:
                    data = crawl.crawl_user(item['sns_id'])
                    data['create_date'] = get_now_time()
                    print(data)
                    join_user_serializer = JoinUserSerializer(data=data)
                    if join_user_serializer.is_valid():
                        join_user_serializer.save()
                    print(join_user_serializer.data)

            return Response(status=status.HTTP_200_OK)
