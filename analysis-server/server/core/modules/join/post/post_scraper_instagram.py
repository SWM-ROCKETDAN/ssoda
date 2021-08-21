from bs4 import BeautifulSoup
from urllib.request import urlopen
from ..proxy import get_proxy_url
from ..time import get_now_time
from ..time import get_datetime
from server.core.modules.static.common import Type
from server.core.modules.static.common import Status
from ._post import get_default_post
import json


def scrap_post(url):
    proxy_url = get_proxy_url(url)
    response = urlopen(proxy_url)
    scraped_post = get_default_post()

    # 상태 이상일 시 삭제됨 처리
    if response.getcode() != 200:
        scraped_post['status'] = Status.DELETED
        return scraped_post

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
        status = Status.PRIVATE
    else:
        status = Status.PUBLIC

    # uploadDate
    if 'uploadDate' in post_data:
        upload = get_datetime(post_data['uploadDate'])
    else:
        upload = ''

    # maintain
    hashtags = ','.join(hashtags)

    post = {
        'sns_id': sns_id,
        'url': url,
        'type': Type.INSTAGRAM,
        'status': status,
        'like_count': likes,
        'comment_count': comments,
        'hashtags': hashtags,
        'upload_date': upload,
        'private_date': None,
        'delete_data': None,
        'update_date': get_now_time(),
    }

    return post
