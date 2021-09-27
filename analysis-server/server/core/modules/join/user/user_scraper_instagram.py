from bs4 import BeautifulSoup
from urllib.request import urlopen
from core.modules.assist.proxy import get_proxy_url
from core.modules.assist.time import get_now_date
from core.modules.static.common import Type
from core.modules.static.common import Status
from ._scraped_user import ScrapedUser
import re


def get_url(sns_id):
    return 'https://www.instagram.com/' + sns_id


def scrap_user(sns_id):
    url = get_url(sns_id)
    proxy_url = get_proxy_url(url)
    scraped_user = ScrapedUser()

    response = urlopen(proxy_url)

    # 상태 이상일 시 삭제됨 처리
    if response.getcode() != 200:
        scraped_user.sns_id = sns_id
        scraped_user.url = url
        scraped_user.type = Type.INSTAGRAM
        scraped_user.status = Status.DELETED
        scraped_user.update_date = get_now_date()
        return scraped_user.get_scraped_user()
    else:
        delete_date = None

    soup = BeautifulSoup(response, "html.parser")
    user_meta = str(soup.find('meta', property="og:description"))

    # preprocessing
    for c in "., ":
        user_meta = user_meta.replace(c, "")

    user_nums = re.findall("\d+", user_meta)

    scraped_user.sns_id = sns_id
    scraped_user.url = url
    scraped_user.type = Type.INSTAGRAM
    scraped_user.status = Status.PUBLIC
    scraped_user.follow_count = user_nums[0]
    scraped_user.post_count = user_nums[2]
    scraped_user.update_date = get_now_date()

    return scraped_user.get_scraped_user()
