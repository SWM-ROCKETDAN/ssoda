from urllib.request import urlopen
from urllib.parse import urlencode
from bs4 import BeautifulSoup
import config
import re
import json
import pprint
import datetime

API = config.API_LIST[0]
TEST_ID = 'sw_maestro'


def get_url(url):
    payload = {'api_key': API, 'proxy': 'residential', 'timeout': '20000', 'url': url}
    proxy_url = 'https://api.webscraping.ai/html?' + urlencode(payload)
    return proxy_url


def get_now_time():
    now = datetime.datetime.now().strftime('%Y-%m-%dT%H:%M:%S')
    return now


def cal_time_gap(start, end):
    try:
        date_time_start = datetime.datetime.strptime(start, '%Y-%m-%dT%H:%M:%S')
        date_time_end = datetime.datetime.strptime(end, '%Y-%m-%dT%H:%M:%S')
        gap = date_time_start - date_time_end
        return str(gap.days) + '-' + str(gap.seconds)
    except:
        return ''


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
            if 'author' in post_data:
                instagram_id = post_data['author']['alternateName'][1:]
            else:
                instagram_id = post_data['alternateName'][1:]

            # likes
            if 'commentCount' in post_data:
                likes = int(post_data['commentCount'])
            else:
                likes = 0

            # comments
            if 'interactionStatistic' in post_data and 'userInteractionCount' in post_data['interactionStatistic']:
                comments = int(post_data['interactionStatistic']['userInteractionCount'])
            else:
                comments = 0

            # status
            if post_data['@type'] == 'Person':
                status = config.PostStatus.DENY
            else:
                status = config.PostStatus.ING

            # uploadDate
            if 'uploadDate' in post_data:
                upload = post_data['uploadDate']
            else:
                upload = ''

            # update
            update = get_now_time()

            # maintain
            maintain = cal_time_gap(update, upload)

            # post
            post = {
                'url': url,
                'update': update,
                'status': status,
                'type': config.SnsType.INSTAGRAM,
                'period': {
                    'upload': upload,
                    'deleted': '',
                    'maintain': maintain,
                },
                'desc': {
                    'id': instagram_id,
                    'likes': likes,
                    'comments': comments,
                    'hashtags': hashtag_data,
                },
            }

            self.info_urls.append('https://www.instagram.com/' + instagram_id)
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


def run_test():
    post_url_list = [
        # 'https://www.instagram.com/p/CH7RveenG_B/?utm_source=ig_web_copy_link',
        'https://www.instagram.com/p/CQw-yv-hQD1/?utm_source=ig_web_copy_link',
        'https://www.instagram.com/p/Bx4bj61lL-30WS9r0J4hP_nWu4DUNumqYY4Uug0/?utm_medium=copy_link',
    ]

    instagram = CrawlInstagram(post_url_list, [])
    instagram.do_crawl_posts()
    # instagram.do_crawl_infos()

    pprint.pprint(instagram.get_posts())
    pprint.pprint(instagram.get_infos())


run_test()
# get_now_time()
