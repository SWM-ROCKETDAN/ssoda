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

TEST_URL = 'https://www.facebook.com/155316101256398/posts/4290753117712655/'

match_dict = {'}': '{', ')': '('}


def solution(user_input):
    arr = []
    for s in user_input:
        if s == '(' or s == '{':
            arr.append(s)
        elif s == ')' or s == '}':
            if len(arr) == 0 or arr[len(arr) - 1] != match_dict[s]:
                return 0
            arr.pop()
    if len(arr) != 0:
        return 0

    return 1


def scrap_post(url):
    proxy_url = get_proxy_url(url)
    response = urlopen(proxy_url)

    # 상태 이상일 시 삭제됨 처리
    # if response.getcode() != 200:
    #     scraped_post['status'] = Status.DELETED
    #     return scraped_post

    soup = BeautifulSoup(response, "html.parser")
    tmp = soup.find_all('script', nonce="")
    for i in tmp:
        print('------------')
        t = str(i.string)
        if '{displayResources:' in t:
            tm_count = t[t.find("i18n_comment_count"):]
            tm_count = tm_count[: tm_count.find("url")]
            print(tm_count)

    # title_meta = soup.find('meta', property="og:title")
    # tmp = soup.find_all('script', nonce='')
    # # tmp = tmp[tmp.find('m.handlePayload') + 16:-4]
    # for i in tmp:
    #     print('------------')
    #     t = i.string
    #     if '1' in t:
    #         print(t)
    #     # print(i)
    # print(type(tmp))
    # check = solution(tmp)
    # print(check)
    # json_acceptable_string = tmp.replace("'", "\"")
    # post_data = json.loads(json_acceptable_string)
    # pprint.pprint(post_data)

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
