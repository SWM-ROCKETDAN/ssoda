from rest_framework.views import APIView
from django.http import JsonResponse
from django.db.models import QuerySet
from rest_framework import status
from .models import JoinPost, JoinUser, Event
from .serializers import JoinPostSerializer, JoinUserSerializer, JoinCollectionSerializer, \
    JoinSerializer, EventSerializer
from .modules.instagram.join.crawl.crawl_post import crawl_post
from .modules.instagram.join.crawl.crawl_user import crawl_user
from .modules.instagram.join.reward.reward import JoinReward
from .modules.instagram.report.report import EventReport
from .modules.config.http_status import Success, ServerError


def get_join_post(pk: int) -> QuerySet:
    try:
        return JoinPost.objects.get(pk=pk)
    except JoinPost.DoesNotExist:
        raise status.HTTP_404_NOT_FOUND


def get_join_post_list() -> list:
    try:
        return JoinPost.objects.all()
    except JoinPost.DoesNotExist:
        raise status.HTTP_404_NOT_FOUND


def get_join_post_event(event_id) -> list:
    try:
        return JoinPost.objects.filter(event=event_id)
    except JoinPost.DoesNotExist:
        raise status.HTTP_404_NOT_FOUND


def get_join_user(pk: int) -> QuerySet:
    try:
        return JoinUser.objects.get(pk=pk)
    except JoinUser.DoesNotExist:
        raise status.HTTP_404_NOT_FOUND


def get_event(pk):
    try:
        return Event.objects.get(pk=pk)
    except Event.DoesNotExist:
        raise status.HTTP_404_NOT_FOUND


class JoinPostView(APIView):
    # GET 요청 -> post 크롤링 -> join_post 업데이트
    def put(self, request, pk):
        join_post = get_join_post(pk)
        join_post_serializer = JoinPostSerializer(join_post, crawl_post(JoinPostSerializer(join_post).data.get('url')),
                                                  partial=True)
        if join_post_serializer.is_valid():
            join_post_serializer.save()
            return JsonResponse(Success.JOIN_POST_UPDATE_OK)
        return JsonResponse(ServerError.JOIN_POST_UPDATE_ERROR)


class JoinUserView(APIView):
    # GET 요청 -> user 크롤링 -> join_user 업데이트
    def put(self, request, pk):
        join_user = get_join_user(pk)
        join_user_serializer = JoinUserSerializer(join_user,
                                                  crawl_user(JoinUserSerializer(join_user).data.get('sns_id')),
                                                  partial=True)
        if join_user_serializer.is_valid():
            join_user_serializer.save()
            return JsonResponse(Success.JOIN_USER_UPDATE_OK)
        return JsonResponse(ServerError.JOIN_USER_UPDATE_ERROR)


class JoinRewardView(APIView):
    def get(self, request, pk):
        # 리워드 id 계산을 위한 Join 직렬화
        join_serializer = JoinSerializer(data=get_join_post_list(), many=True)
        join_serializer.is_valid()

        # 이벤트 id 값을 얻기 위한 JoinPost 직렬화
        join_post = get_join_post(pk)
        join_post_serializer = JoinPostSerializer(join_post)

        # 리워드 id 계산을 위한 Event 직렬화
        event_id = join_post_serializer.data.get('event')
        event_serializer = EventSerializer(get_event(event_id))

        # 리워드 id 계산
        join_reward = JoinReward(join_serializer.data, event_serializer.data, pk)
        reward_id = {'reward_id': join_reward.get_reward_level()}

        # join_post 의 reward_id 값 업데이트를 위한 직렬화 재선언
        join_post_serializer = JoinPostSerializer(join_post, reward_id, partial=True)
        if join_post_serializer.is_valid():
            join_post_serializer.save()

        return JsonResponse(reward_id)


class ReportEventView(APIView):
    def get(self, request, pk):
        join_post = get_join_post_event(pk)
        join_serializer = JoinSerializer(data=join_post, many=True)
        join_serializer.is_valid()

        event = get_event(pk=pk)
        event_serializer = EventSerializer(event)
        event_report = EventReport(join_serializer.data, event_serializer.data)
        event_report.test()
        return JsonResponse(join_serializer.data, safe=False)
