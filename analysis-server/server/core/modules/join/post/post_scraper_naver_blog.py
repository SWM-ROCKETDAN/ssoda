import pprint

from urllib.request import urlopen
from bs4 import BeautifulSoup
from ._scraped_post import ScrapedPost
from core.modules.static.common import Type
from core.modules.static.common import Status
from core.modules.assist.time import _get_now_date
from core.modules.assist.time import _parse_from_str_time_to_date_time


def scrap_post(url: str) -> dict:
    scraped_post = ScrapedPost()
    try:
        response = urlopen(url)
        soup = BeautifulSoup(response, "html.parser")
        xml_url = soup.find(type="application/rss+xml")["href"]
        response = urlopen(xml_url)
        sns_id = xml_url.split("/")[-1].replace(".xml", "")

        soup = BeautifulSoup(response, "html.parser")
        urls = [guid.string for guid in soup.find_all("guid")]
        pub_dates = [pub_date.string for pub_date in soup.find_all("pubdate")]
        tags = [tag.string for tag in soup.find_all("tag")]

        xml_index = urls.index(url)
    except Exception as e:
        scraped_post.type = Type.INSTAGRAM
        scraped_post.status = Status.DELETED
        scraped_post.delete_date = _parse_from_str_time_to_date_time(_get_now_date())
        scraped_post.update_date = _parse_from_str_time_to_date_time(_get_now_date())
        return scraped_post.get_scraped_post()
    else:
        hashtags = tags[xml_index]
        scraped_post.type = Type.NAVERBLOG
        scraped_post.sns_id = sns_id
        scraped_post.url = url
        scraped_post.status = Status.PUBLIC
        scraped_post.like_count = 0
        scraped_post.comment_count = 0
        scraped_post.hashtags = hashtags
        scraped_post.upload_date = _parse_from_str_time_to_date_time(pub_dates[xml_index])
        scraped_post.private_date = None
        scraped_post.delete_date = None
        scraped_post.update_date = _parse_from_str_time_to_date_time(_get_now_date())
        return scraped_post.get_scraped_post()
