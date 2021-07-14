class Crawl:
    """ Super Class """

    def __init__(self, post_url, user_url):
        self.post_url = post_url
        self.user_url = user_url
        self.post_data = {}
        self.account_data = {}

    def set_post_url(self, post_url):
        self.post_url = post_url

    def set_user_url(self, user_url):
        self.user_url = user_url

    def get_post_url(self):
        return self.post_url

    def get_user_url(self):
        return self.user_url

    def get_account_list(self):
        return self.user_data

    def get_post_list(self):
        return self.post_data
