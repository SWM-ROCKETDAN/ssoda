import datetime
from server.secret.config import InstagramReward


# 이전 데이터 점수 계산 - 게시물 유지 기간, ER 지수
def cal_time_gap(start, end):
    try:
        start_date = datetime.datetime.strptime(start, '%Y-%m-%dT%H:%M:%S')
        end_date = datetime.datetime.strptime(end, '%Y-%m-%dT%H:%M:%S')
        gap = start_date - end_date
        return int(gap.days)
    except:
        return 0


def get_maintain_point(join) -> float:
    upload_date = join['upload_date']
    deleted_date = join['delete_date']
    maintain_day = cal_time_gap(upload_date, deleted_date)
    # 하루 넘으면 100점
    if maintain_day >= InstagramReward.MAINTAIN_DAY:
        return 100
    else:
        return 0


def get_engagement_point(join) -> float:
    like_count = join['like_count']
    comment_count = join['comment_count']
    engagement = like_count + comment_count
    return engagement / InstagramReward.ER_NUMBER * 100
