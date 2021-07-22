from rest_framework.views import APIView
from rest_framework.response import Response
from django.http import Http404
from rest_framework import status
from .models import JoinPost
from .models import JoinUser
from .serializers import JoinPostSerializer
from .modules.instagram.join.crawl.crawl_post import crawl_post


class JoinView(APIView):
    def get_object(self, pk):
        try:
            return JoinPost.objects.get(pk=pk)
        except JoinPost.DoesNotExist:
            raise Http404

    def get(self, request, pk, format=None):
        join_post = self.get_object(pk)
        serializer = JoinPostSerializer(join_post)
        return Response(serializer.data)

    # JoinPost 크롤링 후 업데이트
    def put(self, request, pk, format=None):
        join_post = self.get_object(pk)
        serializer = JoinPostSerializer(join_post, crawl_post(join_post.url), partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
