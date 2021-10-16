from core.exceptions import exceptions


class EventRankForm:
    def __init__(self):
        self._event_id = None
        self._participate_count = 0
        self._react_count = 0
        self._guest_price = 0

    @property
    def event_id(self):
        return self._event_id

    @event_id.setter
    def event_id(self, event_id):
        self._event_id = event_id

    @property
    def participate_count(self):
        return self._participate_count

    @participate_count.setter
    def participate_count(self, participate_count):
        self._participate_count = participate_count

    @property
    def react_count(self):
        return self.react_count

    @react_count.setter
    def react_count(self, react_count):
        self._react_count = react_count

    @property
    def guest_price(self):
        return self._guest_price

    @guest_price.setter
    def guest_price(self, guest_price):
        self._guest_price = guest_price

    def get_event_rank_form(self):
        event_rank_form = {
            'event_id': self._event_id,
            'participate_count': self._participate_count,
            'react_count': self._react_count,
            'guest_price': self._guest_price,
        }
        return event_rank_form


class EventRankCalculator:
    def __init__(self, event_reports):
        self._event_reports = event_reports

    def get_event_ranks(self):
        try:
            event_ranks = []
            for event_report in self._event_reports:
                event_rank = EventRankForm()
                event_rank.event_id = event_report['event']
                event_rank.participate_count = event_report['participate_count']
                event_rank.react_count = event_report['like_count'] + event_report['comment_count']
                if event_report['exposure_count'] == 0:
                    event_rank.guest_price = 0
                else:
                    event_rank.guest_price = event_report['expenditure_count'] / event_report['exposure_count']
                event_ranks.append(event_rank.get_event_rank_form())
            return event_ranks
        except Exception as e:
            raise exceptions.EventRankCalculateFailed()
