from datetime import datetime

import pytest
from rest_framework.reverse import reverse

from core.models import JoinPost
from core.models import Event
from core.models import Reward
from core.models import Hashtag
from core.models import HashtagHashtags

from core.exceptions import exceptions

TEST_NAVER_BLOG_URL = "https://m.blog.naver.com/PostView.naver?blogId=tears1124&logNo=222536498996&proxyReferer="


def create_event_data(hashtags: list, start_date: datetime = datetime(2021, 9, 23)):
    establish = datetime.now()
    event_data = Event.objects.create(
        etype=0,
        finish_date=datetime(2023, 11, 23),
        start_date=start_date,
        status=0,
        title="테스트 이벤트",
        store=None,
        deleted=False,
        reward_policy="RANDOM",
    )

    reward_coke_data = Reward.objects.create(
        category=1,
        count=100,
        name="콜라",
        price=500,
        level=1,
        used_count=0,
        event=event_data,
        image_path="test/path/coke",
        deleted=False

    )

    reward_sandwich_data = Reward.objects.create(
        category=1,
        count=100,
        name="샌드위치",
        price=2000,
        level=2,
        used_count=0,
        event=event_data,
        image_path="test/path/sandwich",
        deleted=False
    )

    hashtag_data = Hashtag.objects.create(
        template=0,
        id=event_data
    )
    for hashtag in hashtags:
        hashtag_hashtags = HashtagHashtags.objects.create(
            hashtag=hashtag_data,
            hashtags=hashtag
        )
    return event_data


@pytest.mark.urls(urls="config.urls")
@pytest.mark.django_db(transaction=True)
def test_post_update_ok(rf, client):
    event = create_event_data(["제주성산맛집"])
    join_post = JoinPost.objects.create(
        event=event,
        url=TEST_NAVER_BLOG_URL,
        type=2,
        status=None,
        like_count=0,
        comment_count=0,
        hashtags=None,
        create_date=datetime.now(),
        deleted=False,
    )
    url = reverse(viewname="join_posts", args=[join_post.id, ])
    response = client.put(url)

    assert response.json()["message"] == exceptions.PostUpdateOk.default_detail


@pytest.mark.urls(urls="config.urls")
@pytest.mark.django_db(transaction=True)
def test_post_is_diff_hashtag(rf, client):
    event = create_event_data(["DIFF_HASHTAG"])
    join_post = JoinPost.objects.create(
        event=event,
        url=TEST_NAVER_BLOG_URL,
        type=2,
        status=None,
        like_count=0,
        comment_count=0,
        hashtags=None,
        create_date=datetime.now(),
        deleted=False,
    )
    url = reverse(viewname="join_posts", args=[join_post.id, ])
    response = client.put(url)

    assert response.json()["message"] == exceptions.PostIsDiffHashtag.default_detail


@pytest.mark.urls(urls="config.urls")
@pytest.mark.django_db(transaction=True)
def test_post_is_already_calculate_reward_and_ok(rf, client):
    event = create_event_data(["제주성산맛집"])
    join_post = JoinPost.objects.create(
        event=event,
        url=TEST_NAVER_BLOG_URL,
        type=2,
        status=None,
        like_count=0,
        comment_count=0,
        hashtags=None,
        create_date=datetime.now(),
        reward=event.rewards.first(),
        deleted=False,
    )
    url = reverse(viewname="join_posts", args=[join_post.id, ])
    response = client.put(url)

    assert response.json()["message"] == exceptions.PostIsAlreadyCalculatedRewardAndOK.default_detail


@pytest.mark.urls(urls="config.urls")
@pytest.mark.django_db(transaction=True)
def test_post_is_already_rewarded(rf, client):
    event = create_event_data(["제주성산맛집"])
    join_post = JoinPost.objects.create(
        event=event,
        url=TEST_NAVER_BLOG_URL,
        type=2,
        status=None,
        like_count=0,
        comment_count=0,
        hashtags=None,
        create_date=datetime.now(),
        reward=event.rewards.first(),
        reward_date=datetime.now(),
        deleted=False,
    )
    url = reverse(viewname="join_posts", args=[join_post.id, ])
    response = client.put(url)

    assert response.json()["message"] == exceptions.PostIsAlreadyRewarded.default_detail


@pytest.mark.urls(urls="config.urls")
@pytest.mark.django_db(transaction=True)
def test_post_upload_is_faster_than_event_start(rf, client):
    event = create_event_data(["제주성산맛집"], datetime(2022, 11, 18))
    join_post = JoinPost.objects.create(
        event=event,
        url=TEST_NAVER_BLOG_URL,
        type=2,
        status=None,
        like_count=0,
        comment_count=0,
        hashtags=None,
        create_date=datetime.now(),
        deleted=False,
    )
    url = reverse(viewname="join_posts", args=[join_post.id, ])
    response = client.put(url)

    assert response.json()["message"] == exceptions.PostUploadIsFasterThanEventStart.default_detail
