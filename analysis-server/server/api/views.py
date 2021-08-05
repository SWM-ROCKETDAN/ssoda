from rest_framework.views import APIView
from rest_framework.response import Response
from django.http import JsonResponse
from rest_framework import status
from .models import JoinPost, JoinUser
from .serializers import JoinPostSerializer, JoinUserSerializer, JoinCollectionSerializer
from .modules.instagram.join.crawl.crawl_post import crawl_post
from .modules.instagram.join.crawl.crawl_user import crawl_user
from .modules.instagram.join.reward.reward import JoinReward
from .modules.instagram.report.report import EventReport

error = {
    "message": "INVALID_JWT_TOKEN.",
    "status": 401,
    "code": "AUTH003"
}

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
        join_post_serializer = JoinPostSerializer(join_post, crawl_post(JoinPostSerializer(join_post).data.get('url')), partial=True)
        if join_post_serializer.is_valid():
            join_post_serializer.save()
            return JsonResponse(error, status=status.HTTP_200_OK)
        return JsonResponse(error, status=status.HTTP_400_BAD_REQUEST)


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
            return JsonResponse(error, status=status.HTTP_200_OK)
        return JsonResponse(error, status=status.HTTP_400_BAD_REQUEST)


class JoinRewardView(APIView):
    @staticmethod
    def get_object():
        try:
            return JoinPost.objects.all()
        except JoinPost.DoesNotExist:
            raise status.HTTP_404_NOT_FOUND

    def get(self, request, pk):
        join_collection = self.get_object()
        join_collection_serializer = JoinCollectionSerializer(data=join_collection, many=True)
        join_collection_serializer.is_valid()
        join_reward = JoinReward(join_collection_serializer.data, pk)
        reward_level = join_reward.get_reward_level()
        return JsonResponse(error, status=status.HTTP_200_OK)


class ReportEventView(APIView):
    @staticmethod
    def get_object(pk):
        try:
            return JoinPost.objects.filter(event_id=pk)
        except JoinPost.DoesNotExist:
            raise status.HTTP_404_NOT_FOUND

    def get(self, request, pk):
        join_collection = self.get_object(pk)
        join_collection_serializer = JoinCollectionSerializer(data=join_collection, many=True)
        join_collection_serializer.is_valid()
        event_report = EventReport(join_collection_serializer.data, pk)
        event_report.test()
        return JsonResponse(status=status.HTTP_200_OK)
