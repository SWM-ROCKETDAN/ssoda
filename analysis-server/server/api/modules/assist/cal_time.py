import datetime


def get_now_time():
    now = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    return now


def get_datetime(time):
    date_time = datetime.datetime.strptime(time, '%Y-%m-%dT%H:%M:%S')
    print(date_time)
    return date_time


def cal_time_gap(start, end):
    try:
        date_time_start = datetime.datetime.strptime(start, '%Y-%m-%dT%H:%M:%S')
        date_time_end = datetime.datetime.strptime(end, '%Y-%m-%dT%H:%M:%S')
        gap = date_time_start - date_time_end
        return str(gap.days) + '-' + str(gap.seconds)
    except:
        return ''
