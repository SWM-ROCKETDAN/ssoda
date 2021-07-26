from rest_framework.views import APIView
from rest_framework.response import Response
from django.http import Http404
from rest_framework import status
from rest_framework import generics
from .models import JoinPost
from .models import JoinUser
from .models import EventRewards
from .serializers import JoinPostSerializer
from .modules.instagram.join.crawl.crawl_post import crawl_post


class JoinPostView(APIView):
    @staticmethod
    def get_object(pk):
        try:
            return JoinPost.objects.get(pk=pk)
        except JoinPost.DoesNotExist:
            raise Http404

    def get(self, request, pk, format=None):
        join_post = self.get_object(pk)
        serializer = JoinPostSerializer(join_post)
        return Response(serializer.data)

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
            raise Http404

    def get(self, request, pk, format=None):
        join_user = self.get_object(pk)
        serializer = JoinPostSerializer(join_user)
        return Response(serializer.data)

    # JoinUser 크롤링 후 업데이트
    def put(self, request, pk, format=None):
        join_user = self.get_object(pk)
        serializer = JoinPostSerializer(join_user, crawl_post(join_user.sns_id), partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
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
