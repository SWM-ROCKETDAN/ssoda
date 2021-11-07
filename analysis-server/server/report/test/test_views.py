from rest_framework.reverse import reverse
from core.models import JoinPost
from core.models import JoinUser
from core.exceptions import exceptions
from config.settings.base import get_secret
from datetime import datetime
import pytest

TEST_NAVER_BLOG_URL = get_secret("TEST_NAVER_BLOG_URL")


@pytest.mark.urls(urls="config.urls")
@pytest.mark.django_db(transaction=True)
class TestReportEvent:
    def test_report_events_event_report_calculate_ok(self, client, event_origin):
        url = reverse(viewname="report_events", args=[event_origin.id, ])
        response = client.get(url)

        assert response.json()["message"] == exceptions.EventReportCalculateOK.default_detail


@pytest.mark.urls(urls="config.urls")
@pytest.mark.django_db(transaction=True)
class TestReportStore:
    def test_report_stores_store_report_calculate_ok(self, client, store_origin):
        url = reverse(viewname="report_stores", args=[store_origin.id, ])
        response = client.get(url)

        assert response.json()["message"] == exceptions.StoreReportCalculateOK.default_detail
