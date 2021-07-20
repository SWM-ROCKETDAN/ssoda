from bs4 import BeautifulSoup
from urllib.request import urlopen
from server.api.modules.join import proxy
import re


def do_crawl_user(user_url):
    proxy_url = proxy.get_url(user_url)
    response = urlopen(proxy_url)
    soup = BeautifulSoup(response, "html.parser")
    user_meta = str(soup.find('meta', property="og:description"))

    # preprocessing
    for c in "., ":
        user_meta = user_meta.replace(c, "")

    user_nums = re.findall("\d+", user_meta)

    user_data = {
        'followers': int(user_nums[0]),
        'followings': int(user_nums[1]),
        'posts': int(user_nums[2]),
    }

    return user_data
