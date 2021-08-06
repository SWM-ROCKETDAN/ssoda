import pprint
from datetime import datetime, timedelta
from server.secret.config import InstagramReport, Status
from .report_exposure import get_exposure

TEST_DATE = datetime(2021, 8, 1).date()


def get_day_list():
    day_list = []
    for i in reversed(range(7)):
        # day = TEST_DATE - timedelta(days=i)
        day = datetime.now().date() - timedelta(days=i)
        day_list.append(day)
    return day_list


def get_week_list():
    week_iso_list = []
    for i in reversed(range(7)):
        week = datetime.now() - timedelta(weeks=i)
        week_iso = week.isocalendar()
        week_iso_list.append(week_iso)
    return week_iso_list


class EventReport:
    def __init__(self, join_list, event):
        self.join_list = join_list
        self.event = event

    def get_day_list(self):
        day_list = []
        event_start_date = datetime.strptime(self.event['start_date'], '%Y-%m-%dT%H:%M:%S').date()
        print(event_start_date)
        for i in range((datetime.now().date() - event_start_date).days + 1):
            day_list.append((event_start_date + timedelta(days=i)).isocalendar())

        return day_list

    # 속도를 높이기 위한 dict 변환
    def parse_to_dict(self, iso_list):
        report_dict = {}
        for iso in iso_list:
            report_dict[str(iso)] = {
                'exposure_count': 0,
                'participate_count': 0,
                'post_count': 0,
                'delete_post_count': 0,
                'like_count': 0,
                'comment_count': 0,
                'expenditure_count': 0,
            }

        return report_dict

    def get_report_dict(self):
        day_report_dict = self.parse_to_dict(get_day_list())

        for join in self.join_list:
            upload_date = datetime.strptime(join['upload_date'], '%Y-%m-%dT%H:%M:%S').date().isocalendar()
            pass

        pass

    def test(self):
        print(self.get_day_list())
        pprint.pprint(self.parse_to_dict(self.get_day_list()))

    def test3(self):
        pprint.pprint("test 코드 입니다.")
        day_list = get_day_list()
        day_exposure_list = [0 for i in range(7)]
        day_like_count_list = [0 for i in range(7)]
        day_comment_count_list = [0 for i in range(7)]
        day_post_count_list = [0 for i in range(7)]
        day_delete_count_list = [0 for i in range(7)]
        day_expenditure_list = [0 for i in range(7)]

        for join_post_and_join_user in self.join_post_and_join_user_list:
            # exposure_count_list
            upload_date = datetime.strptime(join_post_and_join_user['upload_date'], '%Y-%m-%dT%H:%M:%S').date()
            for key, val in enumerate(day_list):
                if val == upload_date:
                    day_exposure_list[key] += int(
                        join_post_and_join_user['join_user']['follow_count'] * InstagramReport.REACH)
                    day_like_count_list[key] += int(join_post_and_join_user['like_count'])
                    day_comment_count_list[key] += int(join_post_and_join_user['comment_count'])
                    day_post_count_list[key] += 1
                    if join_post_and_join_user['status'] == Status.END:
                        day_delete_count_list[key] += 1
                    if join_post_and_join_user['reward']:
                        print(join_post_and_join_user['reward'])
                        pass

        print(self.event)
        print(day_exposure_list)
        print(day_like_count_list)
        print(day_comment_count_list)
        print(day_post_count_list)
        print(day_delete_count_list)
        print(day_expenditure_list)
