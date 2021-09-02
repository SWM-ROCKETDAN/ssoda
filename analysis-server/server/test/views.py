from django.shortcuts import get_object_or_404
from django.shortcuts import get_list_or_404
from rest_framework.views import APIView
from django.http import JsonResponse
from core.models import JoinPost
from core.modules.task.post.tasker_post import PostTasker
from .serializers import JoinPostSerializer
from core.modules.test.join.post.test_post import get_test_join_posts
from core.exceptions import exceptions
from core.modules.static.task import Task


# JoinPost PUT 요청
class TestJoinPostView(APIView):
    def get(self, request):
        join_posts = get_list_or_404(JoinPost)
        join_post_serializer = JoinPostSerializer(data=join_posts, many=True)
        join_post_serializer.is_valid()
        post_tasker = PostTasker(Task.TASK_TIME_SECOND, Task.TASK_DAY_DELTA, join_post_serializer.data)
        post_tasker.do_task()
        raise exceptions.PostUpdateOk()

    # def post(self, request):
    #     test_join_posts = get_test_join_posts(10, 1000)
    #     print(test_join_posts)
    #     join_post_serializer = JoinPostSerializer(data=test_join_posts, many=True)
    #
    #     if join_post_serializer.is_valid():
    #         join_post_serializer.save()
    #         raise exceptions.PostUpdateOk()
    #     raise exceptions.PostUpdateFailed()

    def delete(self, request):
        join_posts = JoinPost.objects.all()
        join_posts.delete()
        return JsonResponse({"detail": 'delete all!'})
