from datetime import datetime, timedelta


def get_now():
    return datetime.now().date()


def get_day_like_count(join_collection_list):
    now = get_now()
    like_count = 0
    for join_collection in join_collection_list:
        upload_date = datetime.strptime(join_collection['upload_date'], '%Y-%m-%dT%H:%M:%S').date()
        if now == upload_date:
            like_count += join_collection['like_count']

    return like_count
