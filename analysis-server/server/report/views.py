from django.http import JsonResponse, HttpResponse
from django.shortcuts import get_object_or_404
from django.shortcuts import get_list_or_404
from rest_framework.views import APIView
from core.models import JoinPost
from core.models import Event
from .serializers import ThisJoinSerializer
from .serializers import EventSerializer
from core.modules.report.event.event_report_calculator import EventReportCalculator


# Reward GET 요청
class ReportEvent(APIView):
    def get(self, request, pk):
        join_posts = get_list_or_404(JoinPost, event_id=pk)
        this_join_serializer = ThisJoinSerializer(data=join_posts, many=True)
        this_join_serializer.is_valid()
        event = get_object_or_404(Event, pk=pk)
        event_serializer = EventSerializer(event)
        event_report_calculator = EventReportCalculator(event_serializer.data, this_join_serializer.data)
        event_report = event_report_calculator.get_event_report()
        return JsonResponse(event_report)


class ReportStore(APIView):
    def get(self, request, pk):
        pass
