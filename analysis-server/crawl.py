from urllib.request import urlopen
from urllib.parse import urlencode
from bs4 import BeautifulSoup
import config
import re

API = config.API_LIST[3]
TEST_ID = 'sw_maestro'


def get_url(url):
    payload = {'api_key': API, 'proxy': 'residential', 'timeout': '20000', 'url': url}
    proxy_url = 'https://api.webscraping.ai/html?' + urlencode(payload)
    return proxy_url


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


class CrawlInstagram(Crawl):
    def __init__(self, post_url, info_urls):
        super().__init__(post_url, info_urls)

    def do_crawl_posts(self):
        for url in self.post_urls:
            proxy_url = get_url(url)
            response = urlopen(proxy_url)
            soup = BeautifulSoup(response, "html.parser")

            # meta data
            url_meta = str(soup.find('meta', property="og:url")["content"])
            post_meta = str(soup.find('meta', property="og:description"))
            hashtag_meta = [item["content"] for item in soup.find_all('meta', property="instapp:hashtags")]

            # user id
            user_id = post_meta[post_meta.find('(@') + 2: post_meta.find(')')]

            # preprocessing
            for c in "., ":
                post_meta = post_meta.replace(c, "")

            # description
            post_nums = re.findall("\d+", post_meta)

            post = {
                'public': True,
                'description': {},
            }

            # private post check
            if user_id in url_meta:
                post['public'] = False
            else:
                post['description'] = {
                    'likes': int(post_nums[0]),
                    'comments': int(post_nums[1]),
                    'hashtags': hashtag_meta,
                }
            self.info_urls.append('https://www.instagram.com/' + user_id)
            self.posts.append(post)

    def do_crawl_infos(self):
        for url in self.info_urls:
            proxy_url = get_url(url)
            response = urlopen(proxy_url)
            soup = BeautifulSoup(response, "html.parser")
            info_meta = str(soup.find('meta', property="og:description"))

            # preprocessing
            for c in "., ":
                info_meta = info_meta.replace(c, "")

            info_nums = re.findall("\d+", info_meta)

            info = {
                'followers': int(info_nums[0]),
                'followings': int(info_nums[1]),
                'posts': int(info_nums[2]),
            }

            self.infos.append(info)


post_url_list = ['https://www.instagram.com/p/CH7RveenG_B/?utm_source=ig_web_copy_link',
                 'https://www.instagram.com/p/CQw-yv-hQD1/?utm_source=ig_web_copy_link']

instagram = CrawlInstagram(post_url_list, [])
instagram.do_crawl_posts()
instagram.do_crawl_infos()

print(instagram.get_posts())
print(instagram.get_infos())
private_url = 'https://www.instagram.com/p/Bx4bj61lL-30WS9r0J4hP_nWu4DUNumqYY4Uug0/?utm_medium=copy_link'


# instagram.do_crawl_info()
# print(instagram.get_info())
