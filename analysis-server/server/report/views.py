from django.shortcuts import get_object_or_404
from rest_framework.views import APIView
from core.models import Event
from core.models import Store
from core.models import EventReport
from .serializers import EventReportUpdateSerializer
from .serializers import ReportEventSerializer
from .serializers import ReportStoreSerializer
from core.modules.report.event.event_report_calculator import ReportEventCalculator
from core.modules.report.store.store_report_calculator import StoreReportCalculator
from core.exceptions import exceptions


# Report Event GET 요청
class ReportEvent(APIView):
    def get(self, request, pk):
        event = get_object_or_404(Event, pk=pk)
        report_event_serializer = ReportEventSerializer(event)
        report_event_calculator = ReportEventCalculator(report_event_serializer.data)
        report_event = report_event_calculator.get_report_event()

        _event_report = report_event_calculator.get_event_report()
        _event_report["event"] = report_event_serializer.data["id"]
        _event_report["event_status"] = report_event_serializer.data["status"]
        try:
            event_report = EventReport.objects.get(event_id=pk)
            event_report_update_serializer = EventReportUpdateSerializer(event_report, _event_report, partial=True)
        except EventReport.DoesNotExist:
            event_report_update_serializer = EventReportUpdateSerializer(data=_event_report)
        if event_report_update_serializer.is_valid():
            event_report_update_serializer.save()

        raise exceptions.EventReportCalculateOK({"event_report": report_event})


# Report Store GET 요청
class ReportStore(APIView):
    def get(self, request, pk):
        store = get_object_or_404(Store, pk=pk)
        store_report_serializer = ReportStoreSerializer(store)
        store_report_calculator = StoreReportCalculator(store_report_serializer.data)
        store_report = store_report_calculator.get_store_report()

        raise exceptions.StoreReportCalculateOK({"store_report": store_report})
