import pprint

from .calculator_report import get_exposure_count
from .calculator_report import get_participate_count
from .calculator_report import get_public_post_count
from .calculator_report import get_private_post_count
from .calculator_report import get_deleted_post_count
from .calculator_report import get_like_count
from .calculator_report import get_comment_count
from .calculator_report import get_expenditure_count
from .calculator_report import parse_from_str_date_to_datetime_date
from .calculator_report import get_days_from_start_date_to_now_date

calculator_handlers = {
    'exposure_count': get_exposure_count,
    'participate_count': get_participate_count,
    'public_post_count': get_public_post_count,
    'private_post_count': get_private_post_count,
    'deleted_post_count': get_deleted_post_count,
    'like_count': get_like_count,
    'comment_count': get_comment_count,
    'expenditure_count': get_expenditure_count,
}


class EventReportCalculator:
    def __init__(self, event, event_joins):
        self.event = event
        self.event_joins = event_joins

    def get_day_report_dict(self):
        event = self.event
        event_joins = self.event_joins

        days = get_days_from_start_date_to_now_date(event['start_date'])
        day_report_dict = {}
        for day in days:
            day_report_dict[day] = {}

        # day_report_dict 채워넣기
        for event_join in event_joins:
            upload_date = parse_from_str_date_to_datetime_date(event_join['upload_date'])
            if upload_date not in day_report_dict:
                continue

            for key, calculator in calculator_handlers.items():
                day_report_dict[upload_date][key] = calculator(event_join)

        return day_report_dict

    def get_event_report(self):
        day_report_dict = self.get_day_report_dict()
        pprint.pprint(day_report_dict)
