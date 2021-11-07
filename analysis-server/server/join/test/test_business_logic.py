import pprint

from core.modules.join.post import post_scraper_instagram
from core.modules.join.post import post_scraper_naver
from core.modules.join.user import user_scraper_instagram
from core.modules.join.user import user_scraper_naver_blog
from core.modules.static.common import Type
from core.modules.static.common import Status
from config.settings.base import get_secret
import pytest

TEST_NAVER_BLOG_URL = get_secret("TEST_NAVER_BLOG_URL")
TEST_NAVER_BLOG_SNS_ID = get_secret("TEST_NAVER_BLOG_SNS_ID")
TEST_INSTAGRAM_URL = get_secret("TEST_INSTAGRAM_URL")
TEST_INSTAGRAM_SNS_ID = get_secret("TEST_INSTAGRAM_SNS_ID")


class TestJoinPost:
    def test_join_post_instagram(self):
        scraped_post = post_scraper_instagram.scrap_post(TEST_INSTAGRAM_URL)

        assert scraped_post["sns_id"] == "ssoda_official"
        assert scraped_post["url"] != ""
        assert scraped_post["type"] == Type.INSTAGRAM
        assert scraped_post["status"] == Status.PUBLIC
        assert scraped_post["like_count"] >= 0
        assert scraped_post["comment_count"] >= 0
        assert "쏘다" in scraped_post["hashtags"]
        assert scraped_post["upload_date"] is not None
        assert scraped_post["private_date"] is None
        assert scraped_post["delete_date"] is None
        assert scraped_post["update_date"] is not None

    def test_join_post_scrap_naver_blog(self):
        scraped_post = post_scraper_naver.scrap_post(TEST_NAVER_BLOG_URL)

        assert scraped_post["sns_id"] != ""
        assert scraped_post["url"] != ""
        assert scraped_post["type"] == Type.NAVERBLOG
        assert scraped_post["status"] == Status.PUBLIC
        assert scraped_post["like_count"] >= 0
        assert scraped_post["comment_count"] >= 0
        assert "제주성산맛집" in scraped_post["hashtags"]
        assert scraped_post["upload_date"] is not None
        assert scraped_post["private_date"] is None
        assert scraped_post["delete_date"] is None
        assert scraped_post["update_date"] is not None


class TestJoinUser:
    def test_join_user_naver_blog(self):
        scraped_user = user_scraper_naver_blog.scrap_user(TEST_NAVER_BLOG_SNS_ID)

        assert scraped_user["sns_id"] == TEST_NAVER_BLOG_SNS_ID
        assert scraped_user["url"] != ""
        assert scraped_user["type"] == Type.NAVERBLOG
        assert scraped_user["status"] == Status.PUBLIC
        assert scraped_user["follow_count"] >= 0
        assert scraped_user["post_count"] >= 0
        assert scraped_user["update_date"] is not None

    def test_join_user_instagram(self):
        scraped_user = user_scraper_instagram.scrap_user(TEST_INSTAGRAM_SNS_ID)

        assert scraped_user == 0
        assert scraped_user["sns_id"] == TEST_INSTAGRAM_SNS_ID
        assert scraped_user["url"] != ""
        assert scraped_user["type"] == Type.INSTAGRAM
        assert scraped_user["status"] == Status.PUBLIC
        assert scraped_user["follow_count"] >= 0
        assert scraped_user["post_count"] >= 0
        assert scraped_user["update_date"] is not None
