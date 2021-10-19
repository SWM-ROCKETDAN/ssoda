from rest_framework.views import APIView
from .serializers import EventReportSerializer
from core.models import EventReport
from core.modules.rank.event_rank_calculator import EventRankCalculator
from core.exceptions import exceptions


# Reward GET 요청
class EventRankParticipate(APIView):
    def get(self, request, limit):
        try:
            event_reports = EventReport.objects.filter(
                deleted=False, event_status=1).order_by(
                "-participate_count")[:limit]
        except EventReport.DoesNotExist:
            raise exceptions.EventReportCalculateOK({'event_ranks': []})

        event_report_serializer = EventReportSerializer(event_reports, many=True)
        event_report_calculator = EventRankCalculator(event_report_serializer.data)
        event_ranks = event_report_calculator.get_event_ranks()

        raise exceptions.EventReportCalculateOK({'event_ranks': event_ranks})


class EventRankReact(APIView):
    def get(self, request, limit):
        try:
            event_reports = EventReport.objects.filter(
                deleted=False, event_status=1).extra(
                select={"react_count": "like_count + comment_count"},
                order_by=("-react_count",))[:limit]
        except EventReport.DoesNotExist:
            raise exceptions.EventRankCalculateOK({"event_ranks": []})

        event_report_serializer = EventReportSerializer(event_reports, many=True)
        event_report_calculator = EventRankCalculator(event_report_serializer.data)
        event_ranks = event_report_calculator.get_event_ranks()

        raise exceptions.EventReportCalculateOK({'event_ranks': event_ranks})


class EventRankGuestPrice(APIView):
    def get(self, request, limit):
        try:
            event_reports = EventReport.objects.filter(
                deleted=False, event_status=1, exposure_count__gt=0).extra(
                select={"guest_price": "expenditure_count / exposure_count"},
                order_by=("guest_price",))[:limit]
        except EventReport.DoesNotExist:
            raise exceptions.EventRankCalculateOK({"event_ranks": []})

        event_report_serializer = EventReportSerializer(event_reports, many=True)
        event_report_calculator = EventRankCalculator(event_report_serializer.data)
        event_ranks = event_report_calculator.get_event_ranks()

        raise exceptions.EventReportCalculateOK({'event_ranks': event_ranks})
