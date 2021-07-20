from rest_framework.views import APIView
from rest_framework.response import Response
from .serializers import JoinSerializer
from .modules.instagram.join.crawl import crawl_instagram
from .models import JoinPost
from .models import JoinUser
from .modules.instagram.module_instagram import ModuleInstagram
import pprint


# 이벤트 참여, 보상
class JoinView(APIView):
    # 이벤트 참여자 URL & 이벤트 정보 -> 보상
    @staticmethod
    def post(request):
        join_serializer = JoinSerializer(data=request.data)
        if join_serializer.is_valid():
            event_id = join_serializer.data['event_id']
            post_url = join_serializer.data['url']
            instagram = ModuleInstagram()
            instagram.crawl_all(post_url)

            model_join_user = JoinUser(**instagram.get_user())
            model_join_user.save()
            model_join_post = JoinPost(event_id=event_id, user_id= model_join_user.id, **instagram.get_post())
            model_join_post.save()

        return Response("ok", status=200)


# 이벤트 결과, 분석
class EventReportView(APIView):
    pass
