import pprint

from bs4 import BeautifulSoup
from urllib.request import urlopen
from core.modules.static.common import Type
from core.modules.static.common import Status
from ._scraped_user import ScrapedUser


def get_url(sns_id):
    return 'https://m.blog.naver.com/PostList.naver?blogId=' + sns_id


def scrap_user(sns_id):
    """
        네이버 블로그 유저 크롤링은 모바일로 우회 크롤링이 가능함을 확인하였다.
    """
    url = get_url(sns_id)

    scraped_user = ScrapedUser()
    scraped_user.sns_id = sns_id
    scraped_user.url = url
    scraped_user.type = Type.NAVERBLOG

    response = urlopen(url)

    # 상태 이상일 시 이를 단순 허용하여 준다.
    if response.getcode() != 200:
        return scraped_user.get_scraped_user()

    soup = BeautifulSoup(response, "html.parser")
    text_soup = str(soup)

    # follow_count 를 찾지 못해도 그대로 진행
    try:
        _follow_count = text_soup[text_soup.find("subscriberCount") + 17:]
        _follow_count = _follow_count[:_follow_count.find(",")]
        _follow_count = int(_follow_count)
        scraped_user.follow_count = _follow_count
    except Exception as e:
        pass

    return scraped_user.get_scraped_user()
