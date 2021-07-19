from django.http import HttpResponse, HttpRequest, JsonResponse
from django.shortcuts import render
from rest_framework import generics
from .serializers import EventUserSerializer
from .serializers import EventPostSerializer
import sys
from rest_framework.views import APIView
from django.views.generic import View

# 이벤트 참여, 보상
class EventJoinView(APIView):
    # 이벤트 참여자 URL & 이벤트 정보 -> 보상
    def post(self, request):
        post_serializer = EventPostSerializer(data=request.data)
        return request

# 이벤트 결과, 분석
class EventReportView(APIView):
    pass