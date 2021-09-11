from core.modules.assist.time import get_now_date


class ScrapedUser:
    def __init__(self):
        self._sns_id = ''
        self._url = ''
        self._type = 0
        self._status = 0
        self._follow_count = 0
        self._post_count = 0
        self._update_date = get_now_date()

    def get_scraped_user(self):
        scraped_user = {
            'sns_id': self._sns_id,
            'url': self._url,
            'type': self._type,
            'status': self._status,
            'follow_count': self._follow_count,
            'post_count': self._post_count,
            'update_date': self._update_date,
        }
        return scraped_user

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
        return self._status

    @status.setter
    def status(self, status):
        self._status = status

    @property
    def follow_count(self):
        return self._follow_count

    @follow_count.setter
    def follow_count(self, follow_count):
        self._follow_count = follow_count

    @property
    def post_count(self):
        return self._post_count

    @post_count.setter
    def post_count(self, post_count):
        self._post_count = post_count

    @property
    def update_date(self):
        return self._update_date

    @update_date.setter
    def update_date(self, update_date):
        self._update_date = update_date
