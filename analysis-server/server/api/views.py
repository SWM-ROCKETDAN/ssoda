from rest_framework.views import APIView
from rest_framework.response import Response
from .serializers import JoinSerializer
from .modules.instagram.join.crawl import crawl_instagram
from .models import JoinPost
from .models import JoinUser
from api.modules import
import pprint

class JoinPostView(APIView):
    def get(self, request):



# 이벤트 참여, 보상
class JoinView(APIView):
    # 이벤트 참여자 URL & 이벤트 정보 -> 보상
    def post(self, request):
        join_serializer = JoinSerializer(data=request.data)
        if join_serializer.is_valid():
            data = crawl_instagram.crawl_all(join_serializer.data['url'])
            data_p, data_u = data[0], data[1]
            pprint.pprint(data)
            m_ju = JoinUser(**data_u)
            m_ju.save()
            m_jp = JoinPost(event_id=1, user_id=m_ju.id, **data_p)
            m_jp.save()
        return Response("ok", status=200)


# 이벤트 결과, 분석
class EventReportView(APIView):
    pass
