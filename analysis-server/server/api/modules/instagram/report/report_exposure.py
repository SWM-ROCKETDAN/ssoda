from datetime import datetime, timedelta
from server.secret.config import InstagramReport


def get_day_list():
    day_list = []
    for i in reversed(range(7)):
        day_list.append(datetime.now().date() - timedelta(days=i))
    print(day_list)
    return day_list


def get_day_exposure_list(join_collection_list):
    day_list = get_day_list()
    day_exposure_list = [0 for i in range(0, len(day_list))]

    for join_collection in join_collection_list:
        upload_date = datetime.strptime(join_collection['upload_date'], '%Y-%m-%dT%H:%M:%S').date()
        for key, val in enumerate(day_list):
            if val == upload_date:
                day_exposure_list[key] += int(join_collection['join_user']['follow_count'] * InstagramReport.REACH)

    print(day_exposure_list)
