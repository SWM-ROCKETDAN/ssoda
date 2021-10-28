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
class TestRankEventsParticipate:
    def test_participate_event_rank_calculate_ok(self, client):
        url = reverse(viewname="event_rank_participate", args=[10, ])
        response = client.get(url)

        assert response.json()["message"] == exceptions.EventRankCalculateOK.default_detail


@pytest.mark.urls(urls="config.urls")
@pytest.mark.django_db(transaction=True)
class TestRankEventsReact:
    def test_react_event_rank_calculate_ok(self, client):
        url = reverse(viewname="event_rank_react", args=[10, ])
        response = client.get(url)

        assert response.json()["message"] == exceptions.EventRankCalculateOK.default_detail


@pytest.mark.urls(urls="config.urls")
@pytest.mark.django_db(transaction=True)
class TestRankEventsGuestPrice:
    def test_guest_price_event_rank_calculate_ok(self, client):
        url = reverse(viewname="event_rank_guest_price", args=[10, ])
        response = client.get(url)

        assert response.json()["message"] == exceptions.EventRankCalculateOK.default_detail
