from bs4 import BeautifulSoup
from urllib.request import urlopen
from ..proxy import get_proxy_url
from ..time import get_now_time
from server.core.modules.static.common import Type
from server.core.modules.static.common import Status
import re


def get_url(sns_id):
    return 'https://www.instagram.com/' + sns_id


def scrap_user(sns_id):
    user_url = get_url(sns_id)
    proxy_url = get_proxy_url(user_url)
    response = urlopen(proxy_url)
    soup = BeautifulSoup(response, "html.parser")
    user_meta = str(soup.find('meta', property="og:description"))

    # preprocessing
    for c in "., ":
        user_meta = user_meta.replace(c, "")

    user_nums = re.findall("\d+", user_meta)

    user = {
        'sns_id': sns_id,
        'url': user_url,
        'type': Type.INSTAGRAM,
        'status': Status.PUBLIC,
        'follow_count': user_nums[0],
        'post_count': user_nums[2],
        'update_date': get_now_time()
    }

    return user
