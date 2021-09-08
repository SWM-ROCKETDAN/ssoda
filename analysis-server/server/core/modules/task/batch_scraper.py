"""
일단 task_join_post 테이블을 생성.
서버에서 PUT join_post 요청이 올 시 해당 join_post_id 를 task_join_post 에 넣을지 말지 판단해서 결정한다.
crontab 으로 10분에 1번 PUT api/vi/task/posts/ 요청을 보내면,
task_join_post 에서 upload_date 와 update_date 으로 판단하여 어떤 것을 우선적으로 update 를 할지 결정한다.
한 번에 몇개의 update 를 할지 결정해야 하고 [그때 그때 판단하는 모듈을 만들어야 할듯]
언제 update 를 할지 결정해야 하고 [upload_date 와 현재 시간과 3일 정도 차이 날때 update 안함]
task_join_post 에서 언제 삭제 해야할지 결정해야 한다.
[deleted 게시물이거나, private 게시물이면 삭제, upload_date 와 현재 시간이 3일이 넘게 차이나면 삭제]
"""


class BatchScraper:
    def get_scraped_post(self):
        pass
