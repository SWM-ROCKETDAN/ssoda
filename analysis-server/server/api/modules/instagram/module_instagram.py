from .join.crawl import crawl_instagram

class ModuleInstagram:
    # 게시물과 유저를 동시에 크롤링 한다.
    def __init__(self):
        self.post_url = None
        self.post_status = None
        self.post_upload_date = None
        self.post_private_date = None
        self.post_delete_date = None
        self.post_like_count = None
        self.post_comment_count = None
        self.post_hashtags = None
        self.post_update_date = None

        self.user_sns_id = None
        self.user_sns_type = None
        self.user_sns_status = None
        self.user_follow_count = None
        self.user_post_count = None
        self.user_update_date = None

    def crawl_all(self, post_url):
        data_post = crawl_instagram.crawl_post(post_url)
        data_user = crawl_instagram.crawl_user(data_post[''])
        self.post_url = data_post['url']
        self.post_status = data_post['']
        pass

