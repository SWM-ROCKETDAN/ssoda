from bs4 import BeautifulSoup
from urllib.request import urlopen
from server.api.modules.join import proxy
import server.api.modules.join.cal_time as cal_time
import server.secret.config as config

import json


def do_crawl_post(post_url):
    proxy_url = proxy.get_url(post_url)
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
        upload = cal_time.get_datetime(post_data['uploadDate'])
    else:
        upload = ''

    # update
    update = cal_time.get_now_time()

    # maintain
    hashtag_data = ','.join(hashtag_data)

    # post
    post = {
        'url': post_url,
        'status': status,
        'upload_date': upload,
        'private_date': None,
        'delete_data': None,
        'like_count': likes,
        'comment_count': comments,
        'hashtags': hashtag_data,
        'update_date': update,
    }

    user = {
        'sns_id': instagram_id,
        'sns_type': 'INSTAGRAM',
    }

    account_url = 'https://www.instagram.com/' + instagram_id

    return post, user
