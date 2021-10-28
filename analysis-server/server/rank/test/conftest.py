from core.models import Store
from core.models import Event
from core.models import Reward
from core.models import Hashtag
from core.models import HashtagHashtags
from core.models import JoinPost
from core.models import JoinUser

from config.settings.base import get_secret
from datetime import datetime
import pytest

TEST_NAVER_BLOG_URL = get_secret("TEST_NAVER_BLOG_URL")
TEST_NAVER_BLOG_SNS_ID = get_secret("TEST_NAVER_BLOG_SNS_ID")


@pytest.fixture()
def store1_for_rank_api():
    store = Store.objects.create(
        building_code="test",
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
def event1_for_rank_api(store1_for_rank_api):
    event = Event.objects.create(
        etype=0,
        finish_date=datetime(2023, 11, 23),
        start_date=datetime(2021, 9, 23),
        status=0,
        title="테스트 이벤트",
        store=store1_for_rank_api,
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
