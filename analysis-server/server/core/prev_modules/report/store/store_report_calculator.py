from ..event.event_report_calculator import get_event_report
from server.core.exceptions import exceptions

key_handlers = [
    'exposure_count',
    'participate_count',
    'public_post_count',
    'private_post_count',
    'deleted_post_count',
    'like_count',
    'comment_count',
    'expenditure_count',
]


def _get_store_report(store):
    events = store['events']
    store_report = {}
    for key in key_handlers:
        store_report[key] = 0
    for event in events:
        event_report = get_event_report(event, event['join_posts'])['day']
        for key in key_handlers:
            store_report[key] += sum(event_report[key])

    return store_report


class StoreReportCalculator:
    def __init__(self, store):
        self.store = store

    def get_store_report(self):
        try:
            store_report = _get_store_report(self.store)
        except Exception as e:
            raise exceptions.StoreReportCalculateFailed()

        return store_report
