from .crawl_post import crawl_post
from .crawl_user import crawl_user


class Crawl:
    def __init__(self, post_url, sns_id):
        self.post_url = post_url
        self.sns_id = sns_id

    def crawl_post(self):
        crawl_post(self.post_url)

    def crawl_user(self):
        crawl_user(self.sns_id)
