from bs4 import BeautifulSoup
from urllib.request import urlopen
from server.api.modules.assist import proxy
from server.api.modules.assist import cal_time
from server.api.modules.assist import convert_url
import re
import server.secret.config as config


def crawl_user(sns_id):
    user_url = convert_url.get_instagram_user_url(sns_id)
    proxy_url = proxy.get_url(user_url)
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
        'status': config.Status.ING,
        'follow_count': user_nums[0],
        'post_count': user_nums[2],
        'update_date': cal_time.get_now_time()
    }

    return user
