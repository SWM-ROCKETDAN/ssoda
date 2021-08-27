import datetime


def get_now_time():
    now = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    return now


def parse_from_str_time_to_date_time(str_time):
    date_time = datetime.datetime.strptime(str_time, '%Y-%m-%dT%H:%M:%S')
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
        now_time = get_now_time()
        interval_day = get_interval_day_from_old_time_to_recent_time(target_time, now_time)
    except Exception as e:
        return 0
    return interval_day
