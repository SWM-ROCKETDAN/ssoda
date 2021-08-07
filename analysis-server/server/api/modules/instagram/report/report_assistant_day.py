from datetime import datetime, timedelta


# 이벤트 시작일 ~ 현재 까지의 datetime 리스트
def get_day_list(event):
    day_list = []
    event_start_date = datetime.strptime(event['start_date'], '%Y-%m-%dT%H:%M:%S').date()
    for i in range((datetime.now().date() - event_start_date).days + 1):
        day_list.append((event_start_date + timedelta(days=i)))

    return day_list
