import pprint

from bs4 import BeautifulSoup
from urllib.request import urlopen
from ..proxy import get_proxy_url
from ..time import get_now_time
from ..time import parse_from_str_time_to_date_time
from server.core.modules.static.common import Type
from server.core.modules.static.common import Status
from ._post import get_default_post
import json
import yaml
import re
import demjson

TEST_URL = 'https://www.facebook.com/155316101256398/posts/4290753117712655/'

match_dict = {'}': '{', ')': '('}


def get_post_id_from_facebook_url(url):
    post_id = ''
    split_urls = url.split("/")
    while split_urls:
        split_url = split_urls.pop()
        if split_url != '':
            post_id = split_url
            break
    return post_id


def scrap_post(dummy_url):
    proxy_url = get_proxy_url(dummy_url)
    response = urlopen(proxy_url)
    post_id = get_post_id_from_facebook_url(dummy_url)

    # 상태 이상일 시 삭제됨 처리
    # if response.getcode() != 200:
    #     scraped_post['status'] = Status.DELETED
    #     return scraped_post

    soup = BeautifulSoup(response, "html.parser")
    soup_scripts = soup.find_all('script', nonce="")
    dummies = []
    for soup_script in soup_scripts:
        soup_script = soup_script.string
        try:
            soup_script = soup_script[soup_script.find("{displayResources"):-6]
            soup_script = demjson.decode(soup_script)
            dummies.append(soup_script)
        except Exception as e:
            pass

    for dummy in dummies:
        try:
            pprint.pprint(
                dummy['jsmods']['pre_display_requires'][0][3][1]['__bbox']['result']['data']['feedback']['url'])
            dummy_url = dummy['jsmods']['pre_display_requires'][0][3][1]['__bbox']['result']['data']['feedback']['url']
            dummy_post_id = get_post_id_from_facebook_url(dummy_url)
            if post_id == dummy_post_id:
                pprint.pprint(dummy['jsmods']['pre_display_requires'][0][3][1]['__bbox'])
        except Exception as e:
            pass
    # post = {
    #     'sns_id': sns_id,
    #     'url': url,
    #     'type': Type.INSTAGRAM,
    #     'status': status,
    #     'like_count': likes,
    #     'comment_count': comments,
    #     'hashtags': hashtags,
    #     'upload_date': upload,
    #     'private_date': None,
    #     'delete_data': None,
    #     'update_date': get_now_time(),
    # }

    # return post

# scrap_post(TEST_URL)
