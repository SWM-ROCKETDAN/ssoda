from bs4 import BeautifulSoup
from urllib.request import urlopen
from server.api.modules.join import proxy
import re
import server.secret.config as config
import server.api.modules.join.cal_time as cal_time

def do_crawl_user(user_url):
    proxy_url = proxy.get_url(user_url)
    response = urlopen(proxy_url)
    soup = BeautifulSoup(response, "html.parser")
    user_meta = str(soup.find('meta', property="og:description"))
    print(user_meta)
    # preprocessing
    for c in "., ":
        user_meta = user_meta.replace(c, "")

    user_nums = re.findall("\d+", user_meta)

    user = {
        'follow_count': int(user_nums[1]),
        'sns_status': config.PostStatus.ING,
        'post_count': int(user_nums[0]),
        'update_date': cal_time.get_now_time(),
    }

    return user
