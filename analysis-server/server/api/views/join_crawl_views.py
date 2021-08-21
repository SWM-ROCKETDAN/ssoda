from rest_framework.views import APIView
from django.http import JsonResponse
from server.api.join_serializers import JoinPostSerializer
from server.api.join_serializers import JoinUserSerializer
from ..modules.instagram.join.crawl.crawl_post import crawl_post
from ..modules.instagram.join.crawl.crawl_user import crawl_user
from .get_objects import get_join_post
from .get_objects import get_join_user
from ..modules.config import custom_status


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
