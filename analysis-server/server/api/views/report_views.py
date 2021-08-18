from rest_framework.views import APIView
from django.http import JsonResponse
from rest_framework.response import Response
from ..serializers.join_serializers import JoinSerializer
from ..serializers.event_serializers import EventSerializer
from ..modules.instagram.report.report import EventReport
from ..modules.config import custom_status
from .get_objects import get_event
from .get_objects import get_join_post_by_event
from rest_framework import exceptions
from server.core.exceptions import exceptions

# Report GET 요청
class ReportEventView(APIView):
    def get(self, request, pk):
        raise exceptions.PostIsDiffHashtag
        # Join Post 가져오기
        # try:
        #     raise ClientErrorT.JOIN_POST_FOUND_ERROR
        #     join_post = get_join_post_by_event(pk)
        #     join_serializer = JoinSerializer(data=join_post, many=True)
        #     join_serializer.is_valid()
        # except ClientErrorT.JOIN_POST_FOUND_ERROR as e:
        #     print(e)
        #     return JsonResponse({'hello': 'hello'})
        # except Exception as e:
        #     print(e)
        #     return JsonResponse(custom_status.ClientError.JOIN_POST_FOUND_ERROR)
        #
        # # Event 가져오기
        # try:
        #     event = get_event(pk=pk)
        #     event_serializer = EventSerializer(event)
        # except Exception as e:
        #     print(e)
        #     return JsonResponse(custom_status.ClientError.EVENT_FOUND_ERROR)
        #
        # # Report Dict 계산
        # try:
        #     event_report = EventReport(join_serializer.data, event_serializer.data)
        #     report_dict = event_report.get_report_dict()
        # except Exception as e:
        #     print(e)
        #     return JsonResponse(custom_status.ServerError.REPORT_ERROR)
        #
        # return JsonResponse(report_dict)
