from urllib.request import urlopen
from bs4 import BeautifulSoup
import config
import re
import json
import crawl


class CrawlInstagram(crawl.Crawl):
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
