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


# 정상적인 이벤트
@pytest.fixture()
def event_origin():
    event = Event.objects.create(
        etype=0,
        finish_date=datetime(2023, 11, 23),
        start_date=datetime(2021, 9, 23),
        status=0,
        title="테스트 이벤트",
        store=None,
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


# 시작날이 느린 이벤트
@pytest.fixture()
def event_slow():
    event = Event.objects.create(
        etype=0,
        finish_date=datetime(2023, 11, 23),
        start_date=datetime(2023, 9, 23),
        status=0,
        title="테스트 이벤트",
        store=None,
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
def event_hashtag():
    event = Event.objects.create(
        etype=0,
        finish_date=datetime(2023, 11, 23),
        start_date=datetime(2020, 9, 23),
        status=0,
        title="테스트 이벤트",
        store=None,
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
        hashtags="맞출수없는해시태그"
    )

    return event


@pytest.fixture()
def join_post_naver_blog(event_origin):
    join_post = JoinPost.objects.create(
        event=event_origin,
        reward=None,
        sns_id=TEST_NAVER_BLOG_SNS_ID,
        url=TEST_NAVER_BLOG_URL,
        type=2,
        status=0,
        like_count=2,
        comment_count=3,
        hashtags="",
        create_date=datetime.now(),
        upload_date=datetime.now(),
        private_date=datetime.now(),
        delete_date=datetime.now(),
        update_date=datetime.now(),
        reward_date=datetime.now(),
        deleted=False,
    )
    return join_post


@pytest.fixture()
def join_user_naver_blog(join_post_naver_blog):
    join_user = JoinUser.objects.create(
        sns_id=join_post_naver_blog.sns_id,
        url=join_post_naver_blog.url,
        type=join_post_naver_blog.type,
        status=0,
        follow_count=1000,
        post_count=0,
        create_date=datetime.now(),
        update_date=datetime.now(),
        deleted=False,
    )
    return join_user
