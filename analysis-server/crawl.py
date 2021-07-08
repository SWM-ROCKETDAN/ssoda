from urllib.request import urlopen
from urllib.parse import urlencode
from bs4 import BeautifulSoup
import config
import re
import uuid
import json
import pprint

API = config.API_LIST[1]
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

            # find data
            post_data = soup.find('script', type='application/ld+json').string
            hashtag_data = [item["content"] for item in soup.find_all('meta', property="instapp:hashtags")]

            # convert dictionary
            post_data = post_data[post_data.find('{'):]
            json_acceptable_string = post_data.replace("'", "\"")
            post_data = json.loads(json_acceptable_string)

            # user id
            pprint.pprint(post_data)
            if 'author' in post_data:
                user_id = post_data['author']['alternateName'][1:]
            else:
                user_id = post_data['alternateName'][1:]

            # likes
            if 'commentCount' in post_data:
                likes = post_data['commentCount']
            else:
                likes = 0

            # comments
            if 'interactionStatistic' in post_data and 'userInteractionCount' in post_data['interactionStatistic']:
                comments = post_data['interactionStatistic']['userInteractionCount']
            else:
                comments = 0

            # status
            if post_data['@type'] == 'Person':
                status = config.PostStatus.DENY
            else:
                status = config.PostStatus.ING

            # uploadDate
            if 'uploadDate' in post_data:
                start = post_data['uploadDate']
            else:
                start = ''

            # post
            post = {
                'url': url,
                'user_id': str(uuid.uuid4()),
                'status': status,
                'type': config.SnsType.instagram,
                'period': {
                    'update': '',
                    'start': '',
                    'end': '',
                    'maintain': '',
                },
                'description': {
                    'likes': likes,
                    'comments': comments,
                    'hashtags': hashtag_data,
                },
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
                 'https://www.instagram.com/p/CQw-yv-hQD1/?utm_source=ig_web_copy_link',
                 'https://www.instagram.com/p/Bx4bj61lL-30WS9r0J4hP_nWu4DUNumqYY4Uug0/?utm_medium=copy_link', ]

instagram = CrawlInstagram([post_url_list[2], post_url_list[1]], [])
instagram.do_crawl_posts()
# instagram.do_crawl_infos()

print(instagram.get_posts())
# print(instagram.get_infos())
# private_url =

# instagram.do_crawl_info()
# print(instagram.get_info())
