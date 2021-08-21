from server.core.modules.static.common import Type
from server.core.modules.static.common import Status
from server.core.exceptions import exceptions
from . import user_scraper_instagram
from . import user_scraper_facebook

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
        post_type = self.join_user['type']
        if post_type in module_handlers:
            try:
                self.scraped_user = module_handlers[post_type].scrap_user(self.join_user['sns_id'])
                self.check_scraped_user()
            except Exception as e:
                raise exceptions.ScrapFailed
            return self.scraped_user

    def check_scraped_user(self):
        pass
