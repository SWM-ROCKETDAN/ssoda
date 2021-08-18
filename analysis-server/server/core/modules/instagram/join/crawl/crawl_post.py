from bs4 import BeautifulSoup
from urllib.request import urlopen
from server.api.modules.assist import proxy
from server.api.modules.assist import cal_time
import server.secret.config as config

import json


def crawl_post(url):
    proxy_url = proxy.get_url(url)
    response = urlopen(proxy_url)
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
        status = config.Status.PRIVATE
    else:
        status = config.Status.PUBLIC

    # uploadDate
    if 'uploadDate' in post_data:
        upload = cal_time.get_datetime(post_data['uploadDate'])
    else:
        upload = ''

    # update
    update = cal_time.get_now_time()

    # maintain
    hashtags = ','.join(hashtags)

    post = {
        'sns_id': sns_id,
        'url': url,
        'type': config.Type.INSTAGRAM,
        'status': status,
        'like_count': likes,
        'comment_count': comments,
        'hashtags': hashtags,
        'upload_date': upload,
        'private_date': None,
        'delete_data': None,
        'update_date': update,
    }

    return post
