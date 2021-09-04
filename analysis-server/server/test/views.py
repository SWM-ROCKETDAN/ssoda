from django.shortcuts import get_object_or_404
from django.shortcuts import get_list_or_404
from rest_framework.views import APIView
from django.http import JsonResponse
from core.models import JoinPost
from core.models import JoinUser
from .serializers import JoinPostSerializer
from .serializers import JoinUserSerializer
from core.modules.test.join.post.test_post import PostTester
from core.modules.test.join.user.test_user import UserTester

from server.core.exceptions import exceptions

TEST_SNS_ID = 'test03'


# JoinPost PUT 요청
class TestJoinPostView(APIView):
    def get(self, request):
        join_posts = get_list_or_404(JoinPost)
        join_post_serializer = JoinPostSerializer(data=join_posts, many=True)
        join_post_serializer.is_valid()

        return JsonResponse({'join_posts': join_post_serializer.data})

    def post(self, request):
        post_tester = PostTester(4, 2, 53, None, TEST_SNS_ID)
        test_join_posts = post_tester.get_test_join_posts()
        join_post_serializer = JoinPostSerializer(data=test_join_posts, many=True)
        if join_post_serializer.is_valid():
            join_post_serializer.save()
            raise exceptions.PostUpdateOk(join_post_serializer.data)
        raise exceptions.PostUpdateFailed()

    def delete(self, request):
        join_posts = JoinPost.objects.all()
        join_posts.delete()

        return JsonResponse({"test": 'join post delete all!'})


class TestJoinUserView(APIView):
    def get(self, request):
        join_users = get_list_or_404(JoinUser)
        join_user_serializer = JoinUserSerializer(data=join_users, many=True)
        join_user_serializer.is_valid()

        return JsonResponse({'join_users': join_user_serializer.data})

    def post(self, request):
        user_tester = UserTester(TEST_SNS_ID)
        test_join_user = user_tester.get_test_join_user()
        join_user_serializer = JoinUserSerializer(data=test_join_user)
        if join_user_serializer.is_valid():
            join_user_serializer.save()
            raise exceptions.UserUpdateOk({'join_user': join_user_serializer.data})
        raise exceptions.UserUpdateFailed()

    def delete(self, request):
        join_users = JoinUser.objects.all()
        join_users.delete()

        return JsonResponse({"test": 'join user delete all!'})
