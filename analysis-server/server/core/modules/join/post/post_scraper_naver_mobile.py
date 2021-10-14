import pprint

from urllib.request import urlopen
from bs4 import BeautifulSoup
from ._scraped_post import ScrapedPost
from core.modules.static.common import Type
from core.modules.static.common import Status
from core.modules.assist.time import _get_now_date
from core.modules.assist.time import _parse_from_str_time_to_date_time


def scrap_post_naver_mobile(url: str) -> dict:
    scraped_post = ScrapedPost()
    scraped_post.type = Type.NAVERBLOG
    scraped_post.url = url

    response = urlopen(url)
    soup = BeautifulSoup(response, "html.parser")
    text_soup = str(soup)

    # sns_id 를 찾지 못하면 삭제된 게시물 간주
    try:
        _sns_id = text_soup[text_soup.find("targetBlogId") + 15:]
        _sns_id = _sns_id[:_sns_id.find(";")]
        _sns_id = _sns_id.replace("\"", "")
        _sns_id = str(_sns_id)
        scraped_post.sns_id = _sns_id
    except Exception as e:
        scraped_post.status = Status.DELETED
        return scraped_post.get_scraped_post()

    # comment_count 를 찾지 못하면 그대로 진행
    try:
        _comment_count = text_soup[text_soup.find("commentcount") + 14:]
        _comment_count = _comment_count[:_comment_count.find("\"")]
        _comment_count = int(_comment_count)
        scraped_post.comment_count = _comment_count
    except Exception as e:
        pass

    # hashtags 를 찾지 못하면 그대로 진행
    try:
        _hashtags = text_soup[text_soup.find("gsTagName") + 12:]
        _hashtags = _hashtags[:_hashtags.find(";")]
        _hashtags = _hashtags.replace("\"", "")
        _hashtags = str(_hashtags)
        scraped_post.hashtags = _hashtags
    except Exception as e:
        pass

    # upload_date 를 찾지 못하면 그대로 진행
    try:
        _upload_date = soup.find("p", "blog_date").string
        _upload_date = _parse_from_str_time_to_date_time(_upload_date)
        scraped_post.upload_date = _upload_date
    except Exception as e:
        pass

    return scraped_post.get_scraped_post()
