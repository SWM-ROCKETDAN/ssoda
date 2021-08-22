from django.http import JsonResponse, HttpResponse
from django.shortcuts import get_object_or_404, get_list_or_404
from rest_framework.views import APIView


# Reward GET 요청
class ReportEvent(APIView):
    def get(self, request, pk):
        pass


class ReportStore(APIView):
    def get(self, request, pk):
        pass
