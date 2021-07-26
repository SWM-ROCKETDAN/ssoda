import datetime
from server.secret import config

# 이전 데이터 점수 계산 - 게시물 유지 기간, ER 지수
def cal_time_gap(start, end):
    try:
        start_date = datetime.datetime.strptime(start, '%Y-%m-%dT%H:%M:%S')
        end_date = datetime.datetime.strptime(end, '%Y-%m-%dT%H:%M:%S')
        gap = start_date - end_date
        return int(gap.days)
    except:
        return 0


def reward_maintain(upload_date, delete_date) -> float:
    maintain_day = cal_time_gap(upload_date, delete_date)
    # 하루 넘으면 100점
    if maintain_day >= config.InstagramReward.MAINTAIN_DAY:
        return 100
    else:
        return 0


def reward_er(like_count, comment_count) -> float:
    er = like_count + comment_count
    return er / config.InstagramReward.ER_NUMBER * 100

