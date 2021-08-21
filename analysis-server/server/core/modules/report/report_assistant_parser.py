import copy


# 계산 속도를 높이기 위한 dict 변환
def parse_to_dict(day_list: list):
    report_dict = {}
    for day in day_list:
        report_dict[day] = {
            'exposure_count': 0,
            'participate_count': 0,
            'post_count': 0,
            'private_post_count': 0,
            'deleted_post_count': 0,
            'like_count': 0,
            'comment_count': 0,
            'expenditure_count': 0,
        }

    return report_dict


# 리포트 딕셔너리 파싱 데이터 추가
def append_item_to_report_dict(report_dict: dict):
    for key, val in report_dict.items():
        report_dict[key].append(0)
    return report_dict


# 리포트 딕셔너리 파싱 데이터 덧셈
def plus_item_to_report_dict(report_dict: dict, item: dict):
    for key, val in item.items():
        report_dict[key + '_list'][-1] += item[key]
    return report_dict


# 리포트 딕셔너리 파싱
def parse_to_report_dict(report_dict: dict):
    _report_dict = {
        'exposure_count_list': [],
        'participate_count_list': [],
        'post_count_list': [],
        'private_post_count_list': [],
        'deleted_post_count_list': [],
        'like_count_list': [],
        'comment_count_list': [],
        'expenditure_count_list': [],
    }

    day_report_dict = copy.deepcopy(_report_dict)
    week_report_dict = copy.deepcopy(_report_dict)
    month_report_dict = copy.deepcopy(_report_dict)
    week_iso, month_num = None, None
    week_index, month_index = -1, -1

    for key, val in report_dict.items():
        # 일이 바뀌면 day 추가
        append_item_to_report_dict(day_report_dict)
        # 주가 바뀌면 week 추가
        if week_iso != (key.isocalendar()[0], key.isocalendar()[1]):
            week_iso = (key.isocalendar()[0], key.isocalendar()[1])
            week_index += 1
            append_item_to_report_dict(week_report_dict)
        # 월이 바뀌면 month 추가
        if month_num != key.month:
            month_num = key.month
            month_index += 1
            append_item_to_report_dict(month_report_dict)

        plus_item_to_report_dict(day_report_dict, val)
        plus_item_to_report_dict(week_report_dict, val)
        plus_item_to_report_dict(month_report_dict, val)

    report_dict = {
        'day': day_report_dict,
        'week': week_report_dict,
        'month': month_report_dict,
    }

    return report_dict
