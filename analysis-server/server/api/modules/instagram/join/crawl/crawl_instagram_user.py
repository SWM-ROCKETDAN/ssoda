from bs4 import BeautifulSoup
from urllib.request import urlopen
from server.api.modules.assist import proxy
from server.api.modules.assist import cal_time
import re
import server.secret.config as config


def crawl_user(self, user_id):
    user_url = 'https://www.instagram.com/' + user_id
    proxy_url = proxy.get_url(user_url)
    response = urlopen(proxy_url)
    soup = BeautifulSoup(response, "html.parser")
    user_meta = str(soup.find('meta', property="og:description"))
    print(user_meta)
    # preprocessing
    for c in "., ":
        user_meta = user_meta.replace(c, "")

    user_nums = re.findall("\d+", user_meta)

    self.user_sns_status = config.Status.ING
    self.user_follow_count = int(user_nums[1])
    self.user_post_count = int(user_nums[0])
    self.user_update_date = cal_time.get_now_time()

    return True
