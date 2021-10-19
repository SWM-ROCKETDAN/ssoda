from .calculator_report import get_exposure_count
from .calculator_report import get_participate_count
from .calculator_report import get_public_post_count
from .calculator_report import get_private_post_count
from .calculator_report import get_deleted_post_count
from .calculator_report import get_like_count
from .calculator_report import get_comment_count
from .calculator_report import get_expenditure_count
from .calculator_report import get_level_expenditure
from .calculator_report import get_days_from_start_date_to_now_date
from core.modules.assist.time import _parse_from_str_time_to_date_time
from core.modules.assist.time import _get_now_date
from core.exceptions import exceptions

import pprint

calculator_handlers = {
    'exposure_count': get_exposure_count,
    'participate_count': get_participate_count,
    'public_post_count': get_public_post_count,
    'private_post_count': get_private_post_count,
    'deleted_post_count': get_deleted_post_count,
    'like_count': get_like_count,
    'comment_count': get_comment_count,
    'expenditure_count': get_expenditure_count,
    'level_expenditure': get_level_expenditure,
}


def _get_calculate_report_dict_format(event: dict) -> dict:
    """
    {datetime.date(2021, 9, 27): {'comment_count': 0,
                              'deleted_post_count': 0,
                              'expenditure_count': 0,
                              'exposure_count': 0,
                              'level_expenditure': [0, 0, 0, 0, 0],
                              'like_count': 0,
                              'participate_count': 0,
                              'private_post_count': 0,
                              'public_post_count': 0},
    datetime.date(2021, 9, 28): {'comment_count': 0,
                              'deleted_post_count': 0,
                              'expenditure_count': 0,
                              'exposure_count': 0,
                              'level_expenditure': [0, 0, 0, 0, 0],
                              'like_count': 0,
                              'participate_count': 0,
                              'private_post_count': 0,
                              'public_post_count': 0}}
    """
    days = get_days_from_start_date_to_now_date(event['start_date'])
    calculate_report_dict = {}
    for day in days:
        calculate_report_dict[day] = {}
        for calculator_name in calculator_handlers.keys():
            calculate_report_dict[day][calculator_name] = 0
            if calculator_name == 'level_expenditure':
                calculate_report_dict[day][calculator_name] = [0, 0, 0, 0, 0]
    # pprint.pprint(calculate_report_dict)
    return calculate_report_dict


def _get_calculate_report_dict(event: dict, join_posts: list):
    calculate_report_dict = _get_calculate_report_dict_format(event)
    for join_post in join_posts:
        if not join_post['upload_date']:
            continue
        upload_date = _parse_from_str_time_to_date_time(join_post['upload_date']).date()
        if upload_date not in calculate_report_dict:
            continue
        for calculator_name, calculator in calculator_handlers.items():
            if calculator_name not in calculate_report_dict[upload_date]:
                continue
            if calculator_name == 'level_expenditure':
                x = calculate_report_dict[upload_date][calculator_name]
                y = calculator(join_post)
                z = [a + b for a, b in zip(x, y)]
                calculate_report_dict[upload_date][calculator_name] = z
                continue
            calculate_report_dict[upload_date][calculator_name] += calculator(join_post)
    # pprint.pprint(calculate_report_dict)
    return calculate_report_dict


def _get_report_dict_format(event: dict) -> dict:
    """
        {'day': {'comment_count': [],
                 'deleted_post_count': [],
                 'expenditure_count': [],
                 'exposure_count': [],
                 'level_expenditure': [0, 0, 0, 0, 0],
                 'like_count': [],
                 'participate_count': [],
                 'private_post_count': [],
                 'public_post_count': []},
         'month': {'comment_count': [],
                   'deleted_post_count': [],
                   'expenditure_count': [],
                   'exposure_count': [],
                   'level_expenditure': [0, 0, 0, 0, 0],
                   'like_count': [],
                   'participate_count': [],
                   'private_post_count': [],
                   'public_post_count': []},
         'week': {'comment_count': [],
                  'deleted_post_count': [],
                  'expenditure_count': [],
                  'exposure_count': [],
                  'level_expenditure': [0, 0, 0, 0, 0],
                  'like_count': [],
                  'participate_count': [],
                  'private_post_count': [],
                  'public_post_count': []}}

    """
    days = get_days_from_start_date_to_now_date(event['start_date'])
    report_dict = {
        'day': {},
        'week': {},
        'month': {},
    }

    for term in report_dict.keys():
        for calculator_name in calculator_handlers.keys():
            if calculator_name == 'level_expenditure':
                report_dict[term][calculator_name] = [0, 0, 0, 0, 0]
                continue
            report_dict[term][calculator_name] = []
    # pprint.pprint(report_dict)
    return report_dict


def _get_sum_level_expenditure(origin: list, target: list):
    x = origin
    y = target
    z = [a + b for a, b in zip(x, y)]
    return z


def _parse_calculate_report_dict_to_report_dict(calculate_report_dict: dict, report_dict: dict) -> dict:
    now_day = _get_now_date().date()
    now_week = (now_day.isocalendar()[0], now_day.isocalendar()[1])
    now_month = now_day.month
    this_day = 0
    this_week = 0
    this_month = 0
    day_index, week_index, month_index = -1, -1, -1
    for day in calculate_report_dict.keys():
        if this_day != day:
            this_day = day
            day_index += 1
        if this_week != (day.isocalendar()[0], day.isocalendar()[1]):
            this_week = (day.isocalendar()[0], day.isocalendar()[1])
            week_index += 1
        if this_month != day.month:
            this_month = day.month
            month_index += 1

        for calculator_name, calculate_result in calculate_report_dict[day].items():
            if calculator_name == 'level_expenditure':
                if this_day == now_day:
                    _sum = _get_sum_level_expenditure(report_dict['day'][calculator_name], calculate_result)
                    report_dict['day'][calculator_name] = _sum
                if this_week == now_week:
                    _sum = _get_sum_level_expenditure(report_dict['week'][calculator_name], calculate_result)
                    report_dict['week'][calculator_name] = _sum
                if this_month == now_month:
                    _sum = _get_sum_level_expenditure(report_dict['month'][calculator_name], calculate_result)
                    report_dict['month'][calculator_name] = _sum
                continue

            report_dict_day_len = len(report_dict['day'][calculator_name])
            if day_index >= report_dict_day_len or report_dict_day_len == 0:
                report_dict['day'][calculator_name].append(calculate_result)
            else:
                report_dict['day'][calculator_name][day_index] += calculate_result

            report_dict_week_len = len(report_dict['week'][calculator_name])
            if week_index >= report_dict_week_len or report_dict_week_len == 0:
                report_dict['week'][calculator_name].append(calculate_result)
            else:
                report_dict['week'][calculator_name][week_index] += calculate_result

            report_dict_month_len = len(report_dict['month'][calculator_name])
            if month_index >= report_dict_month_len or report_dict_month_len == 0:
                report_dict['month'][calculator_name].append(calculate_result)
            else:
                report_dict['month'][calculator_name][month_index] += calculate_result

    # pprint.pprint(report_dict)
    return report_dict


def _get_total_report_dict(join_posts: dict):
    total_report_dict = {}

    for calculator_name in calculator_handlers.keys():
        if calculator_name == 'level_expenditure':
            total_report_dict[calculator_name] = [0, 0, 0, 0, 0]
            continue
        total_report_dict[calculator_name] = 0

    for join_post in join_posts:
        for calculator_name, calculator in calculator_handlers.items():
            if calculator_name == 'level_expenditure':
                _sum = _get_sum_level_expenditure(total_report_dict[calculator_name], calculator(join_post))
                total_report_dict[calculator_name] = _sum
            else:
                total_report_dict[calculator_name] += calculator(join_post)

    return total_report_dict


def _get_event_report_dict(event: dict, join_posts: dict) -> dict:
    calculate_report_dict = _get_calculate_report_dict(event, join_posts)
    event_report_dict = _get_report_dict_format(event)
    event_report_dict = _parse_calculate_report_dict_to_report_dict(calculate_report_dict, event_report_dict)
    event_report_dict['total'] = _get_total_report_dict(join_posts)

    return event_report_dict


class ReportEventCalculator:
    def __init__(self, event):
        self.event = event

    def get_report_event(self):
        try:
            report_event_dict = _get_event_report_dict(self.event, self.event['join_posts'])
        except Exception as e:
            raise exceptions.EventReportCalculateFailed()
        return report_event_dict

    def get_event_report(self):
        try:
            event_report_dict = _get_total_report_dict(self.event['join_posts'])
            event_report_dict['event'] = self.event['id']
        except Exception as e:
            raise exceptions.EventReportCalculateFailed()
        return event_report_dict
