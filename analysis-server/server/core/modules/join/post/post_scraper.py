from server.core.modules.static.common import Type
from server.core.modules.static.common import Status
from server.core.modules.static.scrap import Scrap
from server.core.exceptions import exceptions
from server.core.modules.assist.time import get_interval_day_from_now_time_to_target_time
from . import post_scraper_instagram
from . import post_scraper_facebook
from .check_post import check_post_event_is_ok
from .check_post import check_post_reward_is_ok
from .check_post import check_post_status_is_public
from .check_post import check_post_status_is_private
from .check_post import check_post_status_is_deleted
from .check_post import check_match_post_hashtags_with_event_hashtags
from .check_post import check_post_is_already_rewarded

module_handlers = {
    Type.INSTAGRAM: post_scraper_instagram,
    Type.FACEBOOK: post_scraper_facebook,
}


class PostScraper:
    join_post = {}
    scraped_post = {}

    def __init__(self, join_post):
        self.join_post = join_post

    def get_scraped_post(self):
        # if self.check_needed_scrap_post() is False:
        #     raise exceptions.PostUpdateDontButOK()

        post_type = self.join_post['type']
        if post_type in module_handlers:
            try:
                self.scraped_post = module_handlers[post_type].scrap_post(self.join_post['url'])
                # self.check_scraped_post()
            except Exception as e:
                raise exceptions.ScrapFailed()
            return self.scraped_post

    # 스크랩 하기 전 게시물 검사
    def check_post_before_scrap_post(self):
        # 게시물 리워드 체크
        if self.join_post['reward'] is not None:
            # 이미 리워드를 받았으면 PostIsAlreadyRewarded 에러
            if check_post_is_already_rewarded(self.join_post['reward_date']):
                raise exceptions.PostIsAlreadyRewarded()
            # 이벤트가 정상적이지 않으면 PostEventIsNotOK 에러
            if not check_post_event_is_ok(self.join_post['event']['delete_flag']):
                raise exceptions.PostEventIsNotOK()
            # 리워드를 안받았고, 리워드가 정상적인 상태이면 PostIsAlreadyCalculatedRewardAndOK 에러
            if check_post_reward_is_ok(self.join_post['reward']['delete_flag']):
                raise exceptions.PostIsAlreadyCalculatedRewardAndOK()
        # 검사 통과시 True 반환
        return True

    def check_post_after_scrap_post(self):
        # 게시물 상태 체크
        if 'status' in self.join_post:
            if check_post_status_is_private(self.join_post['status']):
                raise exceptions.PostIsPrivate()
            if check_post_status_is_deleted(self.join_post['status']):
                raise exceptions.PostIsDeleted()

        # 게시물 해시태그 체크
        if '' in self.join_post:
            pass

