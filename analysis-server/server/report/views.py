import pprint

from django.shortcuts import get_object_or_404
from django.shortcuts import get_list_or_404
from django.http.response import Http404
from rest_framework.views import APIView
from core.models import Event
from core.models import Store
from core.models import EventReport
from .serializers import EventReportUpdateSerializer
from .serializers import EventReportSerializer
from .serializers import StoreReportSerializer
from core.modules.report.event.event_report_calculator import EventReportCalculator
from core.modules.report.store.store_report_calculator import StoreReportCalculator
from core.exceptions import exceptions


# Reward GET 요청
class ReportEvent(APIView):
    def get(self, request, pk):
        event = get_object_or_404(Event, pk=pk)
        event_report_serializer = EventReportSerializer(event)
        event_report_calculator = EventReportCalculator(event_report_serializer.data)
        event_report = event_report_calculator.get_event_report()
        total_event_report = event_report_calculator.get_event_report_obj()
        try:
            event_report_obj = get_object_or_404(EventReport, event_id=pk)
            event_report_update_serializer = EventReportUpdateSerializer(event_report_obj, total_event_report,
                                                                         partial=True)
            if event_report_update_serializer.is_valid():
                event_report_update_serializer.save()
        except Http404 as e:
            event_report_update_serializer = EventReportUpdateSerializer(data=total_event_report)
            if event_report_update_serializer.is_valid():
                event_report_update_serializer.save()

        raise exceptions.EventReportCalculateOK({'event_report': event_report})


class ReportStore(APIView):
    def get(self, request, pk):
        store = get_object_or_404(Store, pk=pk)
        store_report_serializer = StoreReportSerializer(store)
        store_report_calculator = StoreReportCalculator(store_report_serializer.data)
        store_report = store_report_calculator.get_store_report()
        raise exceptions.StoreReportCalculateOK({'store_report': store_report})
