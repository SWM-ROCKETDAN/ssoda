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
    def test_post_update_ok(self, client, event_origin):
        join_post = JoinPost.objects.create(
            event=event_origin,
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

    def test_post_is_diff_hashtag(self, client, event_hashtag):
        join_post = JoinPost.objects.create(
            event=event_hashtag,
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

    def test_post_is_already_calculate_reward_and_ok(self, client, event_origin):
        join_post = JoinPost.objects.create(
            event=event_origin,
            url=TEST_NAVER_BLOG_URL,
            type=2,
            status=None,
            like_count=0,
            comment_count=0,
            hashtags=None,
            create_date=datetime.now(),
            reward=event_origin.rewards.first(),
            deleted=False,
        )
        url = reverse(viewname="join_posts", args=[join_post.id, ])
        response = client.put(url)

        assert response.json()["message"] == exceptions.PostIsAlreadyCalculatedRewardAndOK.default_detail

    def test_post_is_already_rewarded(self, client, event_origin):
        join_post = JoinPost.objects.create(
            event=event_origin,
            url=TEST_NAVER_BLOG_URL,
            type=2,
            status=None,
            like_count=0,
            comment_count=0,
            hashtags=None,
            create_date=datetime.now(),
            reward=event_origin.rewards.first(),
            reward_date=datetime.now(),
            deleted=False,
        )
        url = reverse(viewname="join_posts", args=[join_post.id, ])
        response = client.put(url)

        assert response.json()["message"] == exceptions.PostIsAlreadyRewarded.default_detail

    def test_post_upload_is_faster_than_event_start(self, client, event_slow):
        join_post = JoinPost.objects.create(
            event=event_slow,
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
    def test_user_update_ok(self, client, join_post_naver_blog):
        join_user = JoinUser.objects.create(
            sns_id=join_post_naver_blog.sns_id,
            type=join_post_naver_blog.type,
            status=0,
            create_date=datetime.now(),
        )
        url = reverse(viewname="join_users", args=[join_user.id, ])
        response = client.put(url)

        assert response.json()["message"] == exceptions.UserUpdateOk.default_detail

    def test_user_recently_update_and_ok(self, client, join_post_naver_blog):
        join_user = JoinUser.objects.create(
            sns_id=join_post_naver_blog.sns_id,
            type=join_post_naver_blog.type,
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
    def test_random_reward_calculate_ok(self, client, join_post_naver_blog):
        url = reverse(viewname="join_rewards_random", args=[join_post_naver_blog.id, ])
        response = client.get(url)

        assert response.json()["message"] == exceptions.RewardCalculateOK.default_detail

    def test_follow_reward_calculate_ok(self, client, join_post_naver_blog):
        url = reverse(viewname="join_rewards_follow", args=[join_post_naver_blog.id, ])
        response = client.get(url)

        assert response.json()["message"] == exceptions.RewardCalculateOK.default_detail
