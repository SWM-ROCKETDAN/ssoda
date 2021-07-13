class Crawl:
    """ Super Class """
    def __init__(self, post_urls, info_urls):
        self.post_urls = post_urls
        self.info_urls = info_urls
        self.posts = []
        self.infos = []

    def set_post_url(self, post_urls):
        self.post_urls = post_urls

    def set_info_urls(self, info_urls):
        self.info_urls = info_urls

    def get_post_url(self):
        return self.post_urls

    def get_info_urls(self):
        return self.info_urls

    def get_infos(self):
        return self.infos

    def get_posts(self):
        return self.posts