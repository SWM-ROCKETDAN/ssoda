from report.serializers import EventReportUpdateSerializer
from report.serializers import ReportEventSerializer
from report.serializers import ReportStoreSerializer

import pytest


@pytest.mark.urls(urls="config.urls")
@pytest.mark.django_db(transaction=True)
class TestReportSerializers:
    def test_event_report_update_serializer(self, event_report_origin):
        event_report_update_serializer = EventReportUpdateSerializer(event_report_origin)

        assert event_report_update_serializer.data is not None

    def test_report_event_serializer(self, event_origin):
        report_event_serializer = ReportEventSerializer(event_origin)

        assert report_event_serializer.data is not None

    def test_report_store_serializer(self, store_origin):
        report_store_serializer = ReportStoreSerializer(store_origin)

        assert report_store_serializer.data is not None

