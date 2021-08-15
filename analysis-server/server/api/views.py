from rest_framework.views import APIView
from django.http import JsonResponse
from django.db.models import QuerySet
from rest_framework import status
from .models import JoinPost
from .models import JoinUser
from .models import Event
from .serializers.join_serializers import JoinPostSerializer
from .serializers.join_serializers import JoinUserSerializer
from .serializers.join_serializers import JoinSerializer
from .serializers.event_serializers import EventSerializer
from .modules.instagram.join.crawl.crawl_post import crawl_post
from .modules.instagram.join.crawl.crawl_user import crawl_user
from .modules.instagram.join.reward.reward import JoinReward
from .modules.instagram.report.report import EventReport
from .modules.config import custom_status


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


# JoinPost PUT 요청
class JoinPostView(APIView):
    def put(self, request, pk):
        # Join Post 가져오기
        try:
            join_post = get_join_post(pk)
            join_post_serializer = JoinPostSerializer(join_post)
            url = join_post_serializer.data['url']
        except Exception as e:
            print(e)
            return JsonResponse(custom_status.ClientError.JOIN_POST_FOUND_ERROR)

        # Crawl Post 시도
        try:
            join_crawl_post = crawl_post(url)
        except Exception as e:
            print(e)
            return JsonResponse(custom_status.ServerError.JOIN_CRAWL_POST_ERROR)

        # Join Post 업데이트
        join_post_serializer = JoinPostSerializer(join_post, join_crawl_post, partial=True)
        if join_post_serializer.is_valid():
            join_post_serializer.save()
            return JsonResponse(custom_status.Success.JOIN_POST_UPDATE_OK)
        return JsonResponse(custom_status.ServerError.JOIN_POST_UPDATE_ERROR)


# JoinUser PUT 요청
class JoinUserView(APIView):
    def put(self, request, pk):
        # Join User 가져오기
        try:
            join_user = get_join_user(pk)
            join_user_serializer = JoinUserSerializer(join_user)
            sns_id = join_user_serializer.data['sns_id']
        except Exception as e:
            print(e)
            return JsonResponse(custom_status.ClientError.JOIN_USER_FOUND_ERROR)

        # Crawl User 시도
        try:
            join_crawl_user = crawl_user(sns_id)
        except Exception as e:
            print(e)
            return JsonResponse(custom_status.ServerError.JOIN_CRAWL_USER_ERROR)

        # Join User 업데이트
        join_user_serializer = JoinUserSerializer(join_user, join_crawl_user, partial=True)
        if join_user_serializer.is_valid():
            join_user_serializer.save()
            return JsonResponse(custom_status.Success.JOIN_USER_UPDATE_OK)

        return JsonResponse(custom_status.ServerError.JOIN_USER_UPDATE_ERROR)


# Reward GET 요청
class JoinRewardView(APIView):
    def get(self, request, pk):
        # Join List 가져오기
        try:
            join_post_list = get_join_post_list()
            join_list_serializer = JoinSerializer(data=join_post_list, many=True)
            join_list_serializer.is_valid()
        except Exception as e:
            print(e)
            return JsonResponse(custom_status.ClientError.JOIN_FOUND_ERROR)

        # Join 가져오기
        try:
            join_post = get_join_post(pk)
            join_serializer = JoinSerializer(join_post)
        except Exception as e:
            print(e)
            return JsonResponse(custom_status.ClientError.JOIN_FOUND_ERROR)

        # Event 가져오기
        try:
            event_id = join_serializer.data.get('event')
            event = get_event(event_id)
            event_serializer = EventSerializer(event)
        except Exception as e:
            print(e)
            return JsonResponse(custom_status.ClientError.EVENT_FOUND_ERROR)

        # 리워드 id 계산
        try:
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


# Report GET 요청
class ReportEventView(APIView):
    def get(self, request, pk):

        # Join Post 가져오기
        try:
            join_post = get_join_post_event(pk)
            join_serializer = JoinSerializer(data=join_post, many=True)
            join_serializer.is_valid()
        except Exception as e:
            print(e)
            return JsonResponse(custom_status.ClientError.JOIN_POST_FOUND_ERROR)

        # Event 가져오기
        try:
            event = get_event(pk=pk)
            event_serializer = EventSerializer(event)
        except Exception as e:
            print(e)
            return JsonResponse(custom_status.ClientError.EVENT_FOUND_ERROR)

        # Report Dict 계산
        try:
            event_report = EventReport(join_serializer.data, event_serializer.data)
            report_dict = event_report.get_report_dict()
        except Exception as e:
            print(e)
            return JsonResponse(custom_status.ServerError.REPORT_ERROR)

        return JsonResponse(report_dict)
