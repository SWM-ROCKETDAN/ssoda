from bs4 import BeautifulSoup
from urllib.request import urlopen
from server.core.modules.assist.proxy import get_proxy_url
from server.core.modules.assist.time import get_now_date
from server.core.modules.assist.time import parse_from_str_time_to_date_time
from server.core.modules.static.common import Type
from server.core.modules.static.common import Status
from ._scraped_post import ScrapedPost
import json


def scrap_post(url: str) -> dict:
    proxy_url = get_proxy_url(url)
    response = urlopen(proxy_url)
    scraped_post = ScrapedPost()

    # 상태 이상일 시 삭제됨 처리
    if response.getcode() != 200:
        scraped_post.type(Type.INSTAGRAM)
        scraped_post.status(Status.DELETED)
        scraped_post.delete_date(get_now_date())
        scraped_post.update_date(get_now_date())
        return scraped_post.get_scraped_post()
    else:
        delete_date = None

    soup = BeautifulSoup(response, "html.parser")

    # find data
    post_data = soup.find('script', type='application/ld+json').string
    hashtags = [item["content"] for item in soup.find_all('meta', property="instapp:hashtags")]

    # convert dictionary
    post_data = post_data[post_data.find('{'):]
    json_acceptable_string = post_data.replace("'", "\"")
    post_data = json.loads(json_acceptable_string)

    # user id
    if 'author' in post_data:
        sns_id = post_data['author']['alternateName'][1:]
    else:
        sns_id = post_data['alternateName'][1:]

    # likes
    if 'commentCount' in post_data:
        like_count = int(post_data['commentCount'])
    else:
        like_count = 0

    # comments
    if 'interactionStatistic' in post_data and 'userInteractionCount' in post_data['interactionStatistic']:
        comment_count = int(post_data['interactionStatistic']['userInteractionCount'])
    else:
        comment_count = 0

    # status
    if post_data['@type'] == 'Person':
        status = Status.PRIVATE
        private_date = get_now_date()
    else:
        status = Status.PUBLIC
        private_date = None

    # uploadDate
    if 'uploadDate' in post_data:
        upload_date = parse_from_str_time_to_date_time(post_data['uploadDate'])
    else:
        upload_date = None

    # maintain
    hashtags = ','.join(hashtags)

    scraped_post.type(Type.INSTAGRAM)
    scraped_post.sns_id(sns_id)
    scraped_post.status(status)
    scraped_post.like_count(like_count)
    scraped_post.comment_count(comment_count)
    scraped_post.hashtags(hashtags)
    scraped_post.update_date(upload_date)
    scraped_post.private_date(private_date)
    scraped_post.delete_date(delete_date)
    scraped_post.upload_date(get_now_date())

    return scraped_post.get_scraped_post()
