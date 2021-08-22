from server.core.modules.static.common import Type
from server.core.modules.static.common import Status
from server.core.exceptions import exceptions
from . import post_scraper_instagram
from . import post_scraper_facebook

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
        post_type = self.join_post['type']
        if post_type in module_handlers:
            try:
                self.scraped_post = module_handlers[post_type].scrap_post(self.join_post['url'])
                self.check_scraped_post()
            except Exception as e:
                raise exceptions.ScrapFailed
            return self.scraped_post

    def check_scraped_post(self):
        # 이벤트 해시태그 일치 안하면 PostIsDiffHashtag 에러 발생
        if False:
            raise exceptions.PostIsDiffHashtag

        # 비공개 게시물이면 PostIsPrivate 에러 발생
        if self.scraped_post['status'] == Status.PRIVATE:
            raise exceptions.PostIsPrivate

        # 삭제되거나 없는 게시물이면 PostIsDeleted 에러 발생
        if self.scraped_post['status'] == Status.DELETED:
            raise exceptions.PostIsDeleted
