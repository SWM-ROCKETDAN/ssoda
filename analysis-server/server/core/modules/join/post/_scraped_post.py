from core.modules.assist.time import _get_now_date


class ScrapedPost:
    def __init__(self):
        self._sns_id = ''
        self._url = ''
        self._type = 0
        self._status = 0
        self._like_count = 0
        self._comment_count = 0
        self._hashtags = ''
        self._upload_date = None
        self._private_date = None
        self._delete_date = None
        self._update_date = _get_now_date()

    def get_scraped_post(self):
        scraped_post = {
            'sns_id': self._sns_id,
            'url': self._url,
            'type': self._type,
            'status': self._status,
            'like_count': self._like_count,
            'comment_count': self._comment_count,
            'hashtags': self._hashtags,
            'upload_date': self._update_date,
            'delete_date': self._delete_date,
            'update_date': self._update_date,
        }
        return scraped_post

    @property
    def sns_id(self):
        return self._sns_id

    @sns_id.setter
    def sns_id(self, sns_id):
        self._sns_id = sns_id

    @property
    def url(self):
        return self._url

    @url.setter
    def url(self, url):
        self._url = url

    @property
    def type(self):
        return self._type

    @type.setter
    def type(self, type):
        self._type = type

    @property
    def status(self):
        return self.status

    @status.setter
    def status(self, status):
        self._status = status

    @property
    def like_count(self):
        return self.like_count

    @like_count.setter
    def like_count(self, like_count):
        self._like_count = like_count

    @property
    def comment_count(self):
        return self._comment_count

    @comment_count.setter
    def comment_count(self, comment_count):
        self._comment_count = comment_count

    @property
    def hashtags(self):
        return self._hashtags

    @hashtags.setter
    def hashtags(self, hashtags):
        self._hashtags = hashtags

    @property
    def upload_date(self):
        return self._upload_date

    @upload_date.setter
    def upload_date(self, upload_date):
        self._upload_date = upload_date

    @property
    def private_date(self):
        return self._private_date

    @private_date.setter
    def private_date(self, private_date):
        self._private_date = private_date

    @property
    def delete_date(self):
        return self._delete_date

    @delete_date.setter
    def delete_date(self, delete_date):
        self._delete_date = delete_date

    @property
    def update_date(self):
        return self._update_date

    @update_date.setter
    def update_date(self, update_date):
        self._update_date = update_date
