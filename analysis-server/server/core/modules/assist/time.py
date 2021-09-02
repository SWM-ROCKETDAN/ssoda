from datetime import datetime
from datetime import timedelta
import maya


def get_now_date():
    now = datetime.now()

    return now


def get_days_from_now_date_by_day_delta(day_delta):
    days = []
    now_date = get_now_date() - timedelta(days=day_delta)
    for i in range(day_delta):
        days.append(now_date + timedelta(days=i))

    return days


def parse_from_str_time_to_date_time(str_time):
    date_time = maya.parse(str_time).datetime()
    return date_time


def parse_from_utc_timestamp_to_date_time(timestamp):
    date_time = datetime.fromtimestamp(int(timestamp)).strftime('%Y-%m-%dT%H:%M:%S')
    date_time = parse_from_str_time_to_date_time(date_time)
    date_time = date_time - timedelta(hours=9)
    return date_time


def get_interval_day_from_old_time_to_recent_time(old_time, recent_time):
    try:
        old_date_time = parse_from_str_time_to_date_time(old_time)
        recent_date_time = parse_from_str_time_to_date_time(recent_time)
        interval_day = (old_date_time - recent_date_time).days
    except Exception as e:
        return 0
    return int(interval_day)


def get_interval_day_from_now_time_to_target_time(target_time):
    try:
        now_time = get_now_date()
        interval_day = get_interval_day_from_old_time_to_recent_time(target_time, now_time)
    except Exception as e:
        return 0
    return interval_day
