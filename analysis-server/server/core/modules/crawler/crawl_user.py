from bs4 import BeautifulSoup
from urllib.request import urlopen
from .proxy import get_url
from .convert_url import get_instagram_user_url
from .cal_time import get_now_time
import re
import server.secret.config as config


def crawl_user(sns_id):
    user_url = get_instagram_user_url(sns_id)
    proxy_url = get_url(user_url)
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
        'type': config.Type.INSTAGRAM,
        'status': config.Status.PUBLIC,
        'follow_count': user_nums[0],
        'post_count': user_nums[2],
        'update_date': get_now_time()
    }

    return user
