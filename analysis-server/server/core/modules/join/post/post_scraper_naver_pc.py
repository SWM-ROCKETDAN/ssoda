import pprint
from urllib.request import urlopen
from bs4 import BeautifulSoup
from ._scraped_post import ScrapedPost
from core.modules.static.common import Type
from core.modules.static.common import Status
from core.modules.assist.time import _get_now_date
from core.modules.assist.time import _parse_from_str_time_to_date_time


def scrap_post_naver_pc(url: str) -> dict:
    scraped_post = ScrapedPost()
    scraped_post.type = Type.NAVERBLOG
    scraped_post.url = url

    response = urlopen(url)
    soup = BeautifulSoup(response, "html.parser")
    xml_url = soup.find(type="application/rss+xml")["href"]

    # sns_id 를 찾지 못하면 삭제된 게시물 간주
    try:
        _sns_id = xml_url.split("/")[-1].replace(".xml", "")
        scraped_post.sns_id = _sns_id
    except Exception as e:
        scraped_post.status = Status.DELETED
        scraped_post.delete_date = _parse_from_str_time_to_date_time(_get_now_date())
        return scraped_post.get_scraped_post()

    # xml_url 열기
    xml_response = urlopen(xml_url)
    xml_soup = BeautifulSoup(xml_response, "html.parser")
    try:
        urls = [guid.string for guid in xml_soup.find_all("guid")]
        pub_dates = [pub_date.string for pub_date in xml_soup.find_all("pubdate")]
        tags = [tag.string for tag in xml_soup.find_all("tag")]
        xml_index = urls.index(url)

        scraped_post.hashtags = tags[xml_index]
        scraped_post.upload_date = _parse_from_str_time_to_date_time(pub_dates[xml_index])
    except Exception as e:
        pass

    return scraped_post.get_scraped_post()
