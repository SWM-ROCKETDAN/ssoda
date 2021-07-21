from rest_framework.views import APIView
from rest_framework.response import Response
from django.http import Http404
from .serializers import JoinSerializer
from .modules.instagram.join.crawl import crawl_instagram
from .models import JoinPost
from .models import JoinUser
import pprint
from .serializers import JoinPostSerializer
from rest_framework import status

class JoinPostView(APIView):
    """"
    get : join_post
    post : join_post
    """
    def get_object(self, pk):
        try:
            return JoinPost.objects.get(pk=pk)
        except JoinPost.DoesNotExist:
            raise Http404

    def get(self, request, pk, format=None):
        join_post = self.get_object(pk)
        serializer = JoinPostSerializer(join_post)
        return Response(serializer.data)

    def put(self, request, pk, format=None):
        join_post = self.get_object(pk)
        serializer = JoinPostSerializer(join_post, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


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
