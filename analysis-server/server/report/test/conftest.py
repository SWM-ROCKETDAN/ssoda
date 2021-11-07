from core.models import Store
from core.models import Event
from core.models import Reward
from core.models import Hashtag
from core.models import HashtagHashtags
from core.models import EventReport
from datetime import datetime
import pytest


@pytest.fixture()
def store_origin():
    store = Store.objects.create(
        building_code="test store",
        city="test city",
        latitude=None,
        longitude=None,
        road="test road",
        town="test town",
        zip_code="test",
        category=1,
        deleted=False,
        description="test description",
        logo_image_path="test logo image path",
        name="test name",
        user=None,
    )
    return store


@pytest.fixture()
def event_origin(store_origin):
    event = Event.objects.create(
        etype=0,
        finish_date=datetime(2023, 11, 23),
        start_date=datetime(2021, 9, 23),
        status=0,
        title="테스트 이벤트",
        store=store_origin,
        deleted=False,
        reward_policy="RANDOM",
    )

    reward_one = Reward.objects.create(
        category=1,
        count=100,
        name="콜라",
        price=500,
        level=1,
        used_count=0,
        event=event,
        image_path="test/path/coke",
        deleted=False

    )

    reward_two = Reward.objects.create(
        category=1,
        count=100,
        name="샌드위치",
        price=2000,
        level=2,
        used_count=0,
        event=event,
        image_path="test/path/sandwich",
        deleted=False
    )

    hashtag_data = Hashtag.objects.create(
        template=0,
        id=event
    )
    hashtag_hashtags = HashtagHashtags.objects.create(
        hashtag=hashtag_data,
        hashtags="제주성산맛집"
    )

    return event


@pytest.fixture()
def event_report_origin(event_origin):
    event_report = EventReport.objects.create(
        exposure_count=0,
        participate_count=0,
        public_post_count=0,
        private_post_count=0,
        deleted_post_count=0,
        like_count=0,
        comment_count=0,
        expenditure_count=0,
        event=event_origin,
        deleted=False,
        event_status=0,
    )

    return event_report
