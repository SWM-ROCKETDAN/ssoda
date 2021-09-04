from django.shortcuts import get_object_or_404
from rest_framework.views import APIView
from core.exceptions import exceptions


class TaskPost(APIView):
    def put(self, request):

        pass
# class TestJoinPostView(APIView):
#     def get(self, request):
#         join_posts = get_list_or_404(JoinPost)
#         join_post_serializer = JoinPostSerializer(data=join_posts, many=True)
#         join_post_serializer.is_valid()
#         post_tasker = PostTasker(Task.TASK_TIME_SECOND, Task.TASK_DAY_DELTA, join_post_serializer.data)
#         post_tasker.do_task()