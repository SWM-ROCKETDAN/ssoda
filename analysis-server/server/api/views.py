from django.http import HttpResponse, HttpRequest, JsonResponse
from django.shortcuts import render
from rest_framework import generics
import sys
from rest_framework.views import APIView
from django.views.generic import View
from rest_framework.response import Response
from .serializers import JoinUserSerializer
from .modules.join.instagram import crawl_instagram
from .models import JoinPost

# 이벤트 참여, 보상
class JoinView(APIView):
    # 이벤트 참여자 URL & 이벤트 정보 -> 보상
    def post(self, request):
        user_serializer = JoinUserSerializer(data=request.data)
        if user_serializer.is_valid():
            # crawl_instagram.crawl_post_and_user(user_serializer.data['url'])
            print("hello")
            JoinPost.objects.create(user_id=12)
        return Response("ok", status=200)


# 이벤트 결과, 분석
class EventReportView(APIView):
    pass
