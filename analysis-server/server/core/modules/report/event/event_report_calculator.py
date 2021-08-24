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
from server.core.exceptions import exceptions

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


# 계산을 빠르게 하기 위한 딕셔너리 form
def get_report_dict(_event, _event_joins):
    event = _event
    event_joins = _event_joins

    days = get_days_from_start_date_to_now_date(event['start_date'])
    report_dict = {
        'day': {},
        'week': {},
        'month': {},
    }

    for term in report_dict.keys():
        if term == 'day':
            for day in days:
                report_dict[term][day] = {}
        elif term == 'week':
            for day in days:
                week = (day.isocalendar()[0], day.isocalendar()[1])
                report_dict[term][week] = {}
        elif term == 'month':
            for day in days:
                month = day.month
                report_dict[term][month] = {}
        else:
            pass

    # day_report_dict 채워넣기
    for event_join in event_joins:
        upload_date = parse_from_str_date_to_datetime_date(event_join['upload_date'])
        upload_day = upload_date
        upload_week = (upload_date.isocalendar()[0], upload_date.isocalendar()[1])
        upload_month = upload_date.month
        if upload_date in report_dict['day']:
            for key, calculator in calculator_handlers.items():
                if report_dict['day'][upload_day].get(key) is None:
                    report_dict['day'][upload_day][key] = calculator(event_join)
                else:
                    report_dict['day'][upload_day][key] += calculator(event_join)
        if upload_week in report_dict['week']:
            for key, calculator in calculator_handlers.items():
                if report_dict['week'][upload_week].get(key) is None:
                    report_dict['week'][upload_week][key] = calculator(event_join)
                else:
                    report_dict['week'][upload_week][key] += calculator(event_join)
        if upload_month in report_dict['month']:
            for key, calculator in calculator_handlers.items():
                if report_dict['month'][upload_month].get(key) is None:
                    report_dict['month'][upload_month][key] = calculator(event_join)
                else:
                    report_dict['month'][upload_month][key] += calculator(event_join)

    return report_dict


def parse_from_report_dict_to_event_report(_report_dict):
    report_dict = _report_dict
    event_report = {
        'day': {},
        'week': {},
        'month': {},
    }
    for term in event_report.keys():
        for key in calculator_handlers.keys():
            event_report[term][key] = []

    for term in report_dict.keys():
        for term_date in report_dict[term].keys():
            for key in calculator_handlers.keys():
                if report_dict[term][term_date].get(key) is None:
                    event_report[term][key].append(0)
                else:
                    event_report[term][key].append(report_dict[term][term_date][key])

    return event_report


def get_event_report(event, join_posts):
    report_dict = get_report_dict(event, join_posts)
    event_report = parse_from_report_dict_to_event_report(report_dict)
    return event_report


class EventReportCalculator:
    def __init__(self, event):
        self.event = event

    def get_event_report(self):
        try:
            event_report = get_event_report(self.event, self.event['join_posts'])
        except Exception as e:
            raise exceptions.EventReportCalculateFailed

        return event_report
