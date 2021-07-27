from rest_framework.views import APIView
from rest_framework.response import Response
from django.http import Http404
from rest_framework import status
from rest_framework import generics
from .models import JoinPost
from .models import JoinUser
from .models import EventRewards
from .serializers import JoinPostSerializer
from .serializers import JoinUserSerializer

from .modules.instagram.join.crawl import crawl


class JoinPostView(APIView):
    @staticmethod
    def get_object(pk):
        try:
            return JoinPost.objects.get(pk=pk)
        except JoinPost.DoesNotExist:
            raise status.HTTP_404_NOT_FOUND

    @staticmethod
    def get_all():
        try:
            return JoinPost.objects.all()
        except JoinPost.DoesNotExist:
            raise status.HTTP_404_NOT_FOUND

    # GET 요청 -> post 크롤링 -> join_post 업데이트
    def get(self, request, pk, format=None):
        join_post = self.get_object(pk)
        join_post_serializer = JoinPostSerializer(join_post)
        join_post_url = join_post_serializer.data.get('url')
        join_post_crawl = crawl.crawl_post(join_post_url)
        serializer = JoinPostSerializer(join_post, join_post_crawl, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_206_PARTIAL_CONTENT)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    # 테스트 용 post 실제는 없음.
    def post(self, request, pk, format=None):
        print(request.data)
        serializer = JoinPostSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class JoinUserView(APIView):
    @staticmethod
    def get_object(pk):
        try:
            return JoinUser.objects.get(pk=pk)
        except JoinUser.DoesNotExist:
            raise status.HTTP_404_NOT_FOUND

    @staticmethod
    def get_all():
        try:
            return JoinUser.objects.all()
        except JoinUser.DoesNotExist:
            raise status.HTTP_404_NOT_FOUND

    # GET 요청 -> user 크롤링 -> join_user 업데이트
    def get(self, request, pk, format=None):
        join_user = self.get_object(pk)
        join_user_serializer = JoinUserSerializer(join_user)
        join_user_url = join_user_serializer.data.get('sns_id')
        join_user_crawl = crawl.crawl_user(join_user_url)
        serializer = JoinUserSerializer(join_user, join_user_crawl, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_206_PARTIAL_CONTENT)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    # 테스트 용 post 실제는 없음.
    def post(self, request, pk, format=None):
        print(request.data)
        serializer = JoinUserSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class JoinRewardView(APIView):
    @staticmethod
    def get_object(pk):
        try:
            return EventRewards.objects.filter(event_id=pk)
        except EventRewards.DoesNotExist:
            raise Http404

    def get(self, request, pk_event, pk_post, pk_user, formant=None):
        tmp = EventRewards.objects.all()
        print(tmp)
        print(pk_event, pk_post, pk_user)


class ReportView(APIView):
    pass
