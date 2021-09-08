from datetime import datetime
import pprint
from server.core.modules.assist.time import parse_from_str_time_to_date_time
from server.core.modules.assist.time import get_days_from_now_date_by_day_delta
from server.core.modules.assist.time import get_now_date
from server.core.modules.static.task import Task
import copy

"""
7일치의 게시물이 들어왔다고 가정하고 짜기
"""

"""
time_dict
{
    0: 0,
    600: 0,
    1200: 0,
    1800: 0,
    ...
}
"""


# 24시간을 태스크 타임으로 나눈 딕셔너리 time_dict
def get_time_dict_by_task_time(task_time):
    time = 0
    delta_time = task_time

    time_dict = {}
    while True:
        time_dict[time] = 0
        time += delta_time
        if time >= 24 * 60 * 60:
            break
    # pprint.pprint(time_dict)
    return time_dict


# reward_date 를 reward_date_time 으로 파싱
def parse_reward_date_time_from_reward_date(task_time, reward_date):
    reward_date = parse_from_str_time_to_date_time(reward_date)
    reward_date_hour = reward_date.hour
    reward_date_minute = reward_date.minute
    reward_date_second = reward_date.second
    reward_date_time = reward_date_hour * 60 * 60 + reward_date_minute * 60 + reward_date_second
    reward_date_time = reward_date_time - (reward_date_time % task_time)

    return reward_date_time


"""
join_post_time_dict
{
    0: 0,
    600: a,
    1200: b,
    1800: c,
    ...
}
"""


# 하루 단위의 게시물 시간 계산
def get_join_post_time_dict_by_join_posts(task_time, join_posts):
    join_post_time_dict = get_time_dict_by_task_time(task_time)
    # print(join_posts)
    for join_post in join_posts:
        reward_date_time = parse_reward_date_time_from_reward_date(task_time, join_post['reward_date'])

        if reward_date_time in join_post_time_dict:
            join_post_time_dict[reward_date_time] += 1

    return join_post_time_dict


"""
one_task_time_dict
{
    0: task_count,
    600: task_count,
    1200: A,
    1800: task_count,
    ...
}
"""


# 하루 단위의 태스트 딕셔너리 계산
def get_one_task_time_dict(task_time, join_post_time_dict):
    post_sum = 0
    for post_time, post_count in join_post_time_dict.items():
        post_sum += post_count

    one_task_time_dict = get_time_dict_by_task_time(task_time)
    task_count_per_day = len(one_task_time_dict)
    task_sum = post_sum
    task_count_max = 0
    flag = True
    while flag:
        task_count_delta = max(int(task_sum / task_count_per_day), 1)
        task_count_max += task_count_delta
        for task_time in one_task_time_dict:
            task_count = one_task_time_dict[task_time] + join_post_time_dict[task_time]
            if task_count < task_count_max:
                task_sum -= (task_count_max - task_count)
                if task_sum <= 0:
                    flag = False
                    break
                one_task_time_dict[task_time] = task_count_max

        if flag is False:
            break
    # print('get_one_task_time_dict -> one_task_time_dict', one_task_time_dict)
    return one_task_time_dict


# date_dict 파서
def parse_date_dict_from_date_times(date_times):
    date_dict = {}
    for date_time in date_times:
        date = date_time.date()
        date_dict[date] = []

    return date_dict


# task_time_dicts 를 스케일링 한 scaled_task_time_dict 를 얻어낸다.
def get_scaled_task_time_dict_from_task_time_dicts(task_time, task_time_dicts):
    # 태스크가 0이면 제거할 인덱스에 추가
    delete_indexes = []
    for index, origin_task_time_dict in enumerate(task_time_dicts):
        task_sum = 0
        for time, task in origin_task_time_dict.items():
            task_sum += task
        if task_sum == 0:
            delete_indexes.append(index)

    # 제거할 인덱스로 부터 배열에서 제거
    for delete_index in delete_indexes:
        task_time_dicts.pop(delete_index)

    # 스케일드 태스크 타임 딕셔너리 생성
    scaled_task_time_dict = get_time_dict_by_task_time(task_time)
    for origin_task_time_dict in task_time_dicts:
        for time, task in origin_task_time_dict.items():
            scaled_task_time_dict[time] += task

    task_time_dict_count = len(task_time_dicts)
    for time, task in scaled_task_time_dict.items():
        scaled_task_time_dict[time] = int(task / task_time_dict_count)

    return scaled_task_time_dict


# 여러 날의 태스크 딕셔너리를 얻어낸다.
def get_task_dict_from_task_time_and_day_delta_and_join_posts(task_time, day_delta, join_posts):
    days = get_days_from_now_date_by_day_delta(day_delta)
    join_post_date_dict = parse_date_dict_from_date_times(days)

    # reward_date 를 기준으로 join_post 묶기
    for join_post in join_posts:
        reward_date_time = parse_from_str_time_to_date_time(join_post['reward_date'])
        reward_date = reward_date_time.date()
        # print(reward_date.day)
        # print(join_post_date_dict)
        if reward_date in join_post_date_dict:
            join_post_date_dict[reward_date].append(join_post)

    # join_post_date_dict 를 join_post_time_dicts 에 파싱
    task_time_dicts = []
    for date, join_posts in join_post_date_dict.items():
        join_post_time_dict = get_join_post_time_dict_by_join_posts(task_time, join_posts)
        one_task_time_dict = get_one_task_time_dict(task_time, join_post_time_dict)
        task_time_dicts.append(one_task_time_dict)

    # 스케일링
    task_dict = get_scaled_task_time_dict_from_task_time_dicts(task_time, task_time_dicts)
    # print('get_task_dict_from_task_time_and_day_delta_and_join_posts -> task_dict', task_dict)
    return task_dict


# get_time_dict_by_task_time(10 * 60)
class PostTasker:
    def __init__(self, task_time, day_delta, join_posts):
        self.task_time = task_time
        self.day_delta = day_delta
        self.join_posts = join_posts

    def get_task_dict_from_join_posts(self):
        task_time = self.task_time
        day_delta = self.day_delta
        join_posts = self.join_posts

        task_dict = get_task_dict_from_task_time_and_day_delta_and_join_posts(task_time, day_delta, join_posts)
        return task_dict

    def get_now_task(self):
        task_time = self.task_time
        task_dict = self.get_task_dict_from_join_posts()
        now_date = get_now_date()
        now_time = now_date.hour * 60 * 60 + now_date.minute * 60 + now_date.second
        now_task_time = now_time - (now_time % task_time)

        now_task = task_dict[now_task_time]
        print('self.get_now_task -> task_dict', task_dict)
        return now_task

    def do_task(self):
        now_task = self.get_now_task()
