from rest_framework.views import APIView
from django.http import JsonResponse
from rest_framework import status
from .models import JoinPost, JoinUser, Event
from .serializers import JoinPostSerializer, JoinUserSerializer, JoinCollectionSerializer, \
    JoinPostAndJoinUserSerializer, EventTestSerializer
from .modules.instagram.join.crawl.crawl_post import crawl_post
from .modules.instagram.join.crawl.crawl_user import crawl_user
from .modules.instagram.join.reward.reward import JoinReward
from .modules.instagram.report.report import EventReport
from .modules.config.http_status import Success, ServerError


class JoinPostView(APIView):
    @staticmethod
    def get_object(pk):
        try:
            return JoinPost.objects.get(pk=pk)
        except JoinPost.DoesNotExist:
            raise status.HTTP_404_NOT_FOUND

    # GET 요청 -> post 크롤링 -> join_post 업데이트
    def put(self, request, pk):
        join_post = self.get_object(pk)
        join_post_serializer = JoinPostSerializer(join_post, crawl_post(JoinPostSerializer(join_post).data.get('url')),
                                                  partial=True)
        if join_post_serializer.is_valid():
            join_post_serializer.save()
            return JsonResponse(Success.JOIN_POST_UPDATE_OK)
        return JsonResponse(ServerError.JOIN_POST_UPDATE_ERROR)


class JoinUserView(APIView):
    @staticmethod
    def get_object(pk):
        try:
            return JoinUser.objects.get(pk=pk)
        except JoinUser.DoesNotExist:
            raise status.HTTP_404_NOT_FOUND

    # GET 요청 -> user 크롤링 -> join_user 업데이트
    def put(self, request, pk):
        join_user = self.get_object(pk)
        join_user_crawl = crawl_user(JoinUserSerializer(join_user).data.get('sns_id'))
        join_user_serializer = JoinUserSerializer(join_user, join_user_crawl, partial=True)
        if join_user_serializer.is_valid():
            join_user_serializer.save()
            return JsonResponse(Success.JOIN_USER_UPDATE_OK)
        return JsonResponse(ServerError.JOIN_USER_UPDATE_ERROR)


class JoinRewardView(APIView):
    @staticmethod
    def get_join_post_list():
        try:
            return JoinPost.objects.all()
        except JoinPost.DoesNotExist:
            raise status.HTTP_404_NOT_FOUND

    @staticmethod
    def get_join_post(pk):
        try:
            return JoinPost.objects.get(pk=pk)
        except JoinPost.DoesNotExist:
            raise status.HTTP_404_NOT_FOUND

    def get(self, request, pk):
        join_collection = self.get_join_post_list()
        join_collection_serializer = JoinCollectionSerializer(data=join_collection, many=True)
        join_collection_serializer.is_valid()
        join_reward = JoinReward(join_collection_serializer.data, pk)
        rewards_level = {'rewards_level': join_reward.get_reward_level()}
        join_post = self.get_join_post(pk)
        join_post_serializer = JoinPostSerializer(join_post, rewards_level, partial=True)

        if join_post_serializer.is_valid():
            join_post_serializer.save()

        return JsonResponse(rewards_level)


class ReportEventView(APIView):
    @staticmethod
    def get_join_post(pk):
        try:
            return JoinPost.objects.filter(event_id=pk)
        except JoinPost.DoesNotExist:
            raise status.HTTP_404_NOT_FOUND

    @staticmethod
    def get_event(pk):
        try:
            return Event.objects.get(pk=pk)
        except Event.DoesNotExist:
            raise status.HTTP_404_NOT_FOUND

    def get(self, request, pk):
        join_post = self.get_join_post(pk)
        join_post_and_join_user_serializer = JoinPostAndJoinUserSerializer(data=join_post, many=True)
        join_post_and_join_user_serializer.is_valid()

        event = self.get_event(pk=pk)
        print(event)
        event_serializer = EventTestSerializer(event)
        print(event_serializer.data)
        event_report = EventReport(join_post_and_join_user_serializer.data, event_serializer.data)
        event_report.test()
        return JsonResponse(join_post_and_join_user_serializer.data, status=status.HTTP_200_OK, safe=False)
