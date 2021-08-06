import pprint
from datetime import datetime, timedelta
from server.secret.config import InstagramReport, Status

TEST_DATE = datetime(2021, 8, 1).date()


def get_day_list():
    day_list = []
    for i in reversed(range(7)):
        # day_list.append(datetime.now().date() - timedelta(days=i))
        day_list.append(TEST_DATE - timedelta(days=i))
    return day_list


class EventReport:
    def __init__(self, join_post_and_join_user_list, event):
        self.join_post_and_join_user_list = join_post_and_join_user_list
        self.event = event

    def test(self):
        pprint.pprint("test코드 입니다.")
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
                    day_exposure_list[key] += int(join_post_and_join_user['join_user']['follow_count'] * InstagramReport.REACH)
                    day_like_count_list[key] += int(join_post_and_join_user['like_count'])
                    day_comment_count_list[key] += int(join_post_and_join_user['comment_count'])
                    day_post_count_list[key] += 1
                    if join_post_and_join_user['status'] == Status.END:
                        day_delete_count_list[key] += 1
                    if join_post_and_join_user['rewards_level']:
                        day_expenditure_list.append(int(join_post_and_join_user['rewards_level']))


        print(self.event)
        print(day_exposure_list)
        print(day_like_count_list)
        print(day_comment_count_list)
        print(day_post_count_list)
        print(day_delete_count_list)
        print(day_expenditure_list)
