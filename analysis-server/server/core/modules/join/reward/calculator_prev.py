import datetime


# 이전 데이터 점수 계산 - 게시물 유지 기간, ER 지수
def cal_time_gap(start, end):
    try:
        start_date = datetime.datetime.strptime(start, '%Y-%m-%dT%H:%M:%S')
        end_date = datetime.datetime.strptime(end, '%Y-%m-%dT%H:%M:%S')
        gap = start_date - end_date
        return int(gap.days)
    except Exception as e:
        return 0


def calculate_prev_maintain(upload_date, deleted_date, max_maintain_day) -> float:
    maintain_day = cal_time_gap(upload_date, deleted_date)
    return max(min(maintain_day / max_maintain_day * 100, 100), 50)


def calculate_prev_engagement(like_count, comment_count, max_engagement_number) -> float:
    engagement_number = like_count + comment_count
    return max(min(engagement_number / max_engagement_number * 100, 100), 50)
