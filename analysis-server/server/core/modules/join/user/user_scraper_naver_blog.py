# from bs4 import BeautifulSoup
# from urllib.request import urlopen
# from core.modules.assist.proxy import get_proxy_url
from core.modules.assist.time import _get_now_date
from core.modules.assist.time import _parse_from_str_time_to_date_time
from core.modules.static.common import Type
from core.modules.static.common import Status
from ._scraped_user import ScrapedUser
import re


def get_url(sns_id):
    return 'https://blog.naver.com/' + sns_id


def scrap_user(sns_id):
    """
        네이버 블로그 유저 크롤링은 현재 불가능하므로 추후에 업데이트 필요.
        현재, 방안은 크롤링 수집 데이터를 디폴트 값으로 처리하는 것이다.
    """
    scraped_user = ScrapedUser()
    url = get_url(sns_id)

    scraped_user.sns_id = sns_id
    scraped_user.url = url
    scraped_user.type = Type.NAVERBLOG
    scraped_user.status = Status.PUBLIC
    scraped_user.follow_count = 0
    scraped_user.post_count = 0
    scraped_user.update_date = _parse_from_str_time_to_date_time(_get_now_date())

    return scraped_user.get_scraped_user()
