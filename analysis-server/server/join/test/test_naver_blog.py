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
class TestJoinPostNaverBlog:
    def test_post_update_ok(self, client, origin_event):
        join_post = JoinPost.objects.create(
            event=origin_event,
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

    def test_post_is_diff_hashtag(self, client, diff_hashtag_event):
        join_post = JoinPost.objects.create(
            event=diff_hashtag_event,
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

    def test_post_is_already_calculate_reward_and_ok(self, client, origin_event):
        join_post = JoinPost.objects.create(
            event=origin_event,
            url=TEST_NAVER_BLOG_URL,
            type=2,
            status=None,
            like_count=0,
            comment_count=0,
            hashtags=None,
            create_date=datetime.now(),
            reward=origin_event.rewards.first(),
            deleted=False,
        )
        url = reverse(viewname="join_posts", args=[join_post.id, ])
        response = client.put(url)

        assert response.json()["message"] == exceptions.PostIsAlreadyCalculatedRewardAndOK.default_detail

    def test_post_is_already_rewarded(self, client, origin_event):
        join_post = JoinPost.objects.create(
            event=origin_event,
            url=TEST_NAVER_BLOG_URL,
            type=2,
            status=None,
            like_count=0,
            comment_count=0,
            hashtags=None,
            create_date=datetime.now(),
            reward=origin_event.rewards.first(),
            reward_date=datetime.now(),
            deleted=False,
        )
        url = reverse(viewname="join_posts", args=[join_post.id, ])
        response = client.put(url)

        assert response.json()["message"] == exceptions.PostIsAlreadyRewarded.default_detail

    def test_post_upload_is_faster_than_event_start(self, client, slow_event):
        join_post = JoinPost.objects.create(
            event=slow_event,
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


@pytest.mark.urls(urls="config.urls")
@pytest.mark.django_db(transaction=True)
class TestJoinUserNaverBlog:
    def test_user_is_already_rewarded(self, client, join_post):
        join_user = JoinUser.objects.create(
            sns_id=join_post.sns_id,
            type=join_post.type,
            status=0,
            create_date=datetime.now(),
        )
        url = reverse(viewname="join_users", args=[join_user.id, ])
        response = client.put(url)

        assert response.json()["message"] == exceptions.UserUpdateOk.default_detail

    def test_user_recently_update_and_ok(self, client, join_post):
        join_user = JoinUser.objects.create(
            sns_id=join_post.sns_id,
            type=join_post.type,
            status=0,
            create_date=datetime.now(),
            update_date=datetime.now(),
        )
        url = reverse(viewname="join_users", args=[join_user.id, ])
        response = client.put(url)
        assert response.json()["message"] == exceptions.UserRecentlyUpdateAndOK.default_detail


@pytest.mark.urls(urls="config.urls")
@pytest.mark.django_db(transaction=True)
class TestJoinRewardNaverBlog:
    def test_user_is_already_rewarded(self, client, join_post):
        join_user = JoinUser.objects.create(
            sns_id=join_post.sns_id,
            type=join_post.type,
            status=0,
            create_date=datetime.now(),
        )
        url = reverse(viewname="join_users", args=[join_user.id, ])
        response = client.put(url)

        assert response.json()["message"] == exceptions.UserUpdateOk.default_detail

    def test_user_recently_update_and_ok(self, client, join_post):
        join_user = JoinUser.objects.create(
            sns_id=join_post.sns_id,
            type=join_post.type,
            status=0,
            create_date=datetime.now(),
            update_date=datetime.now(),
        )
        url = reverse(viewname="join_users", args=[join_user.id, ])
        response = client.put(url)
        assert response.json()["message"] == exceptions.UserRecentlyUpdateAndOK.default_detail
