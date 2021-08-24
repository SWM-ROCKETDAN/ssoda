from django.http import JsonResponse
from django.shortcuts import get_object_or_404
from rest_framework.views import APIView
from core.models import Event
from core.models import Store
from .serializers import EventReportSerializer
from .serializers import StoreReportSerializer
from core.modules.report.event.event_report_calculator import EventReportCalculator
from core.modules.report.store.store_report_calculator import StoreReportCalculator


# Reward GET 요청
class ReportEvent(APIView):
    def get(self, request, pk):
        event = get_object_or_404(Event, pk=pk)
        event_report_serializer = EventReportSerializer(event)
        event_report_calculator = EventReportCalculator(event_report_serializer.data)
        event_report = event_report_calculator.get_event_report()

        return JsonResponse(event_report)


class ReportStore(APIView):
    def get(self, request, pk):
        store = get_object_or_404(Store, pk=pk)
        store_report_serializer = StoreReportSerializer(store)
        store_report_calculator = StoreReportCalculator(store_report_serializer.data)
        store_report = store_report_calculator.get_store_report()

        return JsonResponse(store_report)
