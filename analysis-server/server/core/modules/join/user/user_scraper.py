from server.core.modules.static.common import Type
from server.core.modules.static.scrap import Scrap
from server.core.exceptions import exceptions
from . import user_scraper_instagram
from . import user_scraper_facebook
from server.core.modules.assist.time import get_interval_day_from_now_time_to_target_time

module_handlers = {
    Type.INSTAGRAM: user_scraper_instagram,
    Type.FACEBOOK: user_scraper_facebook,
}


class UserScraper:
    join_user = {}
    scraped_user = {}

    def __init__(self, join_user):
        self.join_user = join_user

    def get_scraped_user(self):
        if self.check_needed_scrap_user() is False:
            raise exceptions.UserUpdateDontButOK()

        post_type = self.join_user['type']
        if post_type in module_handlers:
            try:
                self.scraped_user = module_handlers[post_type].scrap_user(self.join_user['sns_id'])
            except Exception as e:
                raise exceptions.ScrapFailed()
            return self.scraped_user

    def check_needed_scrap_user(self):
        update_date = self.join_user['update_date']
        interval_day = get_interval_day_from_now_time_to_target_time(update_date)
        if interval_day >= Scrap.USER_UPDATE_DAY:
            return True
        return False
