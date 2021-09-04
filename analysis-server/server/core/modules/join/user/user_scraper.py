from server.core.modules.static.common import Type
from server.core.exceptions import exceptions
from . import user_scraper_instagram
from . import user_scraper_facebook
from .check_user import check_user_is_recently_scraped

scrap_handlers = {
    Type.INSTAGRAM: user_scraper_instagram.scrap_user,
    Type.FACEBOOK: user_scraper_facebook.scrap_user,
}


class UserScraper:
    join_user = {}
    scraped_user = {}

    def __init__(self, join_user):
        self.join_user = join_user

    def get_scraped_user(self):
        self.check_user_before_scrap_user()
        post_type = self.join_user['type']
        if post_type in scrap_handlers:
            try:
                self.scraped_user = scrap_handlers[post_type](self.join_user['sns_id'])
            except Exception as e:
                raise exceptions.ScrapFailed()
            return self.scraped_user

    def check_user_before_scrap_user(self):
        # 유저 업데이트가 최근에 업데이트 되었다면, UserRecentlyUpdateAndOK 에러
        update_date = self.join_user.get('update_date')
        if check_user_is_recently_scraped(update_date):
            raise exceptions.UserRecentlyUpdateAndOK

        return True
