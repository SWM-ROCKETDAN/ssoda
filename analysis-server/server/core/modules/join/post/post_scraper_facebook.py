import pprint

from bs4 import BeautifulSoup
from urllib.request import urlopen
from core.modules.assist.proxy import get_proxy_url
from core.modules.assist.time import _parse_from_utc_timestamp_to_date_time
from core.modules.assist.time import _get_now_date
from core.modules.static.common import Type
from core.modules.static.common import Status
import demjson


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
    print(soup)
    soup_content = ''
    try:
        soup_content = soup.find('meta', property="og:description")["content"]
    except Exception as e:
        pass

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

    sns_id = None
    url = ''
    like_count = 0
    comment_count = 0
    upload_date = None

    for dummy in dummies:
        try:
            dummy_require = dummy['jsmods']['require'][1][3][1]['t']
            publish_time_index = dummy_require.find("publish_time")
            publish_time = dummy_require[publish_time_index + 14: publish_time_index + 24]
            upload_date = _parse_from_utc_timestamp_to_date_time(publish_time)
        except Exception as e:
            pass
        try:
            dummy_feedback = dummy['jsmods']['pre_display_requires'][0][3][1]['__bbox']['result']['data']['feedback']
            dummy_url = dummy_feedback['url']

            dummy_post_id = get_post_id_from_facebook_url(dummy_url)
            if post_id == dummy_post_id:
                url = dummy_url
                sns_id = dummy_feedback['owning_profile']['id']
                like_count = dummy_feedback['reaction_count']['count']
                comment_count = dummy_feedback['comment_count']['total_count']
        except Exception as e:
            pass

    post = {
        'sns_id': sns_id,
        'url': url,
        'type': Type.FACEBOOK,
        'status': Status.PUBLIC,
        'like_count': like_count,
        'comment_count': comment_count,
        'hashtags': soup_content,
        'upload_date': upload_date,
        'private_date': None,
        'delete_date': None,
        'update_date': _get_now_date(),
    }
    pprint.pprint(post)
    # return post

# scrap_post(TEST_URL)
