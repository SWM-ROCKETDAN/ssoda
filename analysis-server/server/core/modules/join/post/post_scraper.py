from server.core.modules.static.common import Type
from server.core.modules.static.common import Status
from server.core.modules.static.scrap import Scrap
from server.core.exceptions import exceptions
from . import post_scraper_instagram
from . import post_scraper_facebook
from server.core.modules.assist.time import get_interval_day_from_now_time_to_target_time

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
        if self.check_needed_scrap_post() is False:
            raise exceptions.PostUpdateDontButOK()

        post_type = self.join_post['type']
        if post_type in module_handlers:
            try:
                self.scraped_post = module_handlers[post_type].scrap_post(self.join_post['url'])
                self.check_scraped_post()
            except Exception as e:
                raise exceptions.ScrapFailed()
            return self.scraped_post

    def check_needed_scrap_post(self):
        update_date = self.join_post['update_date']
        interval_day = get_interval_day_from_now_time_to_target_time(update_date)
        if interval_day >= Scrap.USER_UPDATE_DAY:
            return True
        return False

    def check_scraped_post(self):
        # 이벤트 해시태그 일치 안하면 PostIsDiffHashtag 에러 발생
        if False:
            raise exceptions.PostIsDiffHashtag()

        # 비공개 게시물이면 PostIsPrivate 에러 발생
        if self.scraped_post['status'] == Status.PRIVATE:
            raise exceptions.PostIsPrivate()

        # 삭제되거나 없는 게시물이면 PostIsDeleted 에러 발생
        if self.scraped_post['status'] == Status.DELETED:
            raise exceptions.PostIsDeleted()
