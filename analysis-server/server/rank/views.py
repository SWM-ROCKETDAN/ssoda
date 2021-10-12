from django.shortcuts import get_object_or_404
from rest_framework.views import APIView
from core.models import Event
from core.exceptions import exceptions


# Reward GET 요청
class RankExposure(APIView):
    def get(self, request, pk):
        event = get_object_or_404(Event, pk=pk)
