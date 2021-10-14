import pprint

from urllib.request import urlopen
from bs4 import BeautifulSoup
from ._scraped_post import ScrapedPost
from core.modules.static.common import Type
from core.modules.static.common import Status
from core.modules.assist.time import _get_now_date
from core.modules.assist.time import _parse_from_str_time_to_date_time
from .post_scraper_naver_mobile import scrap_post_naver_mobile
from .post_scraper_naver_pc import scrap_post_naver_pc


def scrap_post(url: str) -> dict:
    if "m.blog.naver.com" in url:
        return scrap_post_naver_mobile(url)
    elif "blog.naver.com" in url:
        return scrap_post_naver_mobile(url)
