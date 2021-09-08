from server.core.modules.static.common import Type
from server.core.exceptions import exceptions
from . import post_scraper_instagram
from . import post_scraper_facebook
from .check_post import check_post_event_is_ok
from .check_post import check_post_reward_is_ok
from .check_post import check_post_status_is_private
from .check_post import check_post_status_is_deleted
from .check_post import check_match_post_hashtags_with_event_hashtags
from .check_post import check_post_is_already_rewarded
from .check_post import check_post_upload_date_is_ok_from_event_start_date
from .check_post import get_post_type_from_url

scrap_handlers = {
    Type.INSTAGRAM: post_scraper_instagram.scrap_post,
    Type.FACEBOOK: post_scraper_facebook.scrap_post,
}


class PostScraper:
    join_post = {}
    scraped_post = {}

    def __init__(self, join_post):
        self.join_post = join_post

    # 스크랩 된 게시물 가져오기
    def get_scraped_post(self):
        self.check_post_before_scrap_post()
        post_type = get_post_type_from_url(self.join_post['url'])
        if post_type in scrap_handlers:
            try:
                self.scraped_post = scrap_handlers[post_type](self.join_post['url'])
            except Exception as e:
                raise exceptions.ScrapFailed()
            else:
                self.check_post_after_scrap_post()
            return self.scraped_post

    # 스크랩 하기 전 게시물 검사
    def check_post_before_scrap_post(self):
        """
            에러 리스트
            1. Client-Error 이벤트가 정상적이지 않다.
            2. Client-Error 이벤트가 정상적이다. AND 리워드를 이미 받았다.
            3. OK 이벤트가 정상적이다. AND 리워드를 받지 않았다. AND 리워드가 정상적이다.
        """
        # 이벤트가 삭제되었다면 PostEventIsNotOK 에러
        join_post_event_deleted = self.join_post['event']['deleted']
        if not check_post_event_is_ok(join_post_event_deleted):
            raise exceptions.PostEventIsNotOK()

        # 리워드를 이미 받았다면 PostIsAlreadyRewarded 에러
        join_post_reward_date = self.join_post['reward_date']
        if check_post_is_already_rewarded(join_post_reward_date):
            raise exceptions.PostIsAlreadyRewarded()

        # 리워드를 받지 않았고 리워드가 정상적인 상태라면 PostIsAlreadyCalculatedRewardAndOK 에러
        if self.join_post['reward'] is None:
            return True
        elif check_post_reward_is_ok(self.join_post['reward']['deleted']):
            raise exceptions.PostIsAlreadyCalculatedRewardAndOK()
        else:
            return True

    def check_post_after_scrap_post(self):
        """
            에러 리스트
            1. Client-Error 게시물이 비공개다.
            2. Client-Error 게시물이 비공개가 아니다. AND 게시물이 삭제되었다.
            3. Client-Error 게시물이 비공개가 아니다. AND 게시물이 삭제되지 않았다. AND 게시물 해시태그가 일치하지 않는다.
            4. Client-Error 게시물의 업로드 날짜가 이벤트 시작 날짜 전이다.
        """

        # 게시물이 비공개면 PostIsPrivate 에러
        join_post_status = self.join_post['status']
        if check_post_status_is_private(join_post_status):
            raise exceptions.PostIsPrivate()

        # 게시물이 삭제되었으면 PostIsDeleted 에러
        join_post_status = self.join_post['status']
        if check_post_status_is_deleted(join_post_status):
            raise exceptions.PostIsDeleted()

        # 게시물 해시태그가 일치하지 않으면 PostIsDiffHashtag 에러
        join_post_hashtags = self.join_post['hashtags']
        join_post_event_hashtags = self.join_post['event_hashtags']
        if not check_match_post_hashtags_with_event_hashtags(join_post_hashtags, join_post_event_hashtags):
            raise exceptions.PostIsDiffHashtag()

        # 게시물 업로드 날짜가 이벤트 시작 날짜보다 빠를때 PostUploadIsFastThanEventStart 에러
        join_post_upload_date = self.join_post['upload_date']
        join_post_event_start_date = self.join_post['event']['start_date']
        if not check_post_upload_date_is_ok_from_event_start_date(join_post_upload_date, join_post_event_start_date):
            raise exceptions.PostUploadIsFastThanEventStart()

        # 게시물은 문제가 없다.
        return True
